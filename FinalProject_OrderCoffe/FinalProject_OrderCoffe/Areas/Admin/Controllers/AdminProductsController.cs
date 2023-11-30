using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using FinalProject_OrderCoffe.Models;
using PagedList.Core;
using OrderCoffee.Helper;
using System.Net;
using AspNetCoreHero.ToastNotification.Abstractions;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AdminProductsController : Controller
    {
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }

        public AdminProductsController(CfOderContext context, INotyfService notifyService)
        {
            _context = context;
            _notifyService = notifyService;
        }

        // GET: Admin/AdminProducts
        public async Task<IActionResult> Index(int page = 1, int CatId = 0 )
        {
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");

            List<Product> lsProducts = new List<Product>();

            if(CatId != 0)
            {
                lsProducts = _context.Products.AsNoTracking()
                    .Where(x => x.CategoryId == CatId)
                    .Include(x => x.Category)
                    .OrderByDescending(x => x.ProductId).ToList();
            } else
            {

                lsProducts = _context.Products.AsNoTracking()
                    .Include(x => x.Category)
                    .OrderByDescending(x => x.ProductId).ToList();
            }

            var pagenumber = page;

            var pageSize = 9;

            PagedList<Product> models = new PagedList<Product>(lsProducts.AsQueryable(), pagenumber, pageSize);
            ViewBag.CurrentCatID = CatId;
            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }

        public IActionResult Filter(int CatID = 0)
        {
            var url = $"/Admin/AdminProducts?CatID={CatID}";
            if (CatID == 0)
            {
                url = $"/Admin/AdminProducts";
            }
            return Json(new { status = "success", redirectUrl = url });
        }

        // GET: Admin/AdminProducts/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(m => m.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // GET: Admin/AdminProducts/Create
        public IActionResult Create()
        {
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
            return View();
        }

        // POST: Admin/AdminProducts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ProductId,ProductName,ShortDdesc,Descriptioon,CategoryId,Price,Discount,Thumb,Video,DateCreate,DateModified,BestSellers,HomeFlag,Active,Tags,Title,Alias,MetaDesc,MetaKey,UnitslnStock")] Product product
                                        , Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            if (ModelState.IsValid)
            {
                product.ProductName = Utilities.ToTileCase(product.ProductName);
                if (fThumb != null)
                {
                    string extension = Path.GetExtension(fThumb.FileName);
                    string img = Utilities.ConvertVietnameseToSEO(product.ProductName) + extension;
                    product.Thumb = await Utilities.UploadFile(fThumb, @"products", img.ToLower());
                }

                if (string.IsNullOrEmpty(product.Thumb))
                {
                    product.Thumb = "default.jpg";
                }

                product.Descriptioon = WebUtility.HtmlDecode(product.Descriptioon);
                product.Alias = Utilities.ConvertVietnameseToSEO(product.ProductName);
                product.DateCreate = DateTime.Now;
                product.DateModified = DateTime.Now;
                _context.Add(product);

                await _context.SaveChangesAsync();
                _notifyService.Success("Thêm mới thành công");
                return RedirectToAction(nameof(Index));
            }
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name", product.CategoryId);
            return View(product);
        }

        // GET: Admin/AdminProducts/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name", product.CategoryId);
            return View(product);
        }
        // POST: Admin/AdminProducts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ProductId,ProductName,ShortDdesc,Descriptioon,CategoryId,Price,Discount,Thumb,Video,DateCreate,DateModified,BestSellers,HomeFlag,Active,Tags,Title,Alias,MetaDesc,MetaKey,UnitslnStock")] Product product,
            Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            product.ProductName = Utilities.ToTileCase(product.ProductName);

            if (fThumb == null || fThumb.Length == 0)
            {
                var existingProduct = await _context.Products.FindAsync(product.ProductId);
                if (existingProduct != null)
                {
                    product.Thumb = existingProduct.Thumb;
                    product.Descriptioon = WebUtility.HtmlDecode(product.Descriptioon);
                    product.Alias = Utilities.ConvertVietnameseToSEO(product.ProductName);
                    product.DateModified = DateTime.Now;

                    _context.Entry(existingProduct).State = EntityState.Detached; // Detach the existing product

                    _context.Update(product);
                    _notifyService.Success("Sửa thành công");
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
            }
            else
            {
                string extension = Path.GetExtension(fThumb.FileName);
                string img = Utilities.ConvertVietnameseToSEO(product.ProductName) + extension;
                product.Thumb = await Utilities.UploadFile(fThumb, @"products", img.ToLower());
            }

            product.Descriptioon = WebUtility.HtmlDecode(product.Descriptioon);
            product.Alias = Utilities.ConvertVietnameseToSEO(product.ProductName);
            product.DateModified = DateTime.Now;

            _context.Entry(product).State = EntityState.Modified;
            _notifyService.Success("Sửa thành công");
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }



        // GET: Admin/AdminProducts/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(m => m.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // POST: Admin/AdminProducts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Products == null)
            {
                return Problem("Entity set 'CfOderContext.Products'  is null.");
            }
            var product = await _context.Products.FindAsync(id);
            if (product != null)
            {
                _context.Products.Remove(product);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ProductExists(int id)
        {
          return (_context.Products?.Any(e => e.ProductId == id)).GetValueOrDefault();
        }
    }
}
