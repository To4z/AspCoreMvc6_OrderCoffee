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
    public class AdminPagesController : Controller
    {
        private readonly CfOderContext _context;

        public INotyfService _notifyService { get; }
        public AdminPagesController(CfOderContext context, INotyfService notifyService)
        {
            _context = context;
            _notifyService = notifyService;
        }

        // GET: Admin/AdminPages
        public async Task<IActionResult> Index(int? page)
        {
            var pagenumber = page == null || page <= 0 ? 1 : page.Value;

            var pageSize = 20;

            var lsPages = _context.Pages.AsNoTracking()
                .OrderByDescending(x => x.PageId);

            PagedList<Page> models = new PagedList<Page>(lsPages, pagenumber, pageSize);

            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }

        // GET: Admin/AdminPages/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Pages == null)
            {
                return NotFound();
            }

            var page = await _context.Pages
                .FirstOrDefaultAsync(m => m.PageId == id);
            if (page == null)
            {
                return NotFound();
            }

            return View(page);
        }

        // GET: Admin/AdminPages/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/AdminPages/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PageId,PageName,Contents,Thumb,Published,Title,MetaDesc,MetaKey,Alias,CreateAt,Ordering")] Page page
            , Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            if (ModelState.IsValid)
            {
                page.PageName = Utilities.ToTileCase(page.PageName);
                if (fThumb != null)
                {
                    string extension = Path.GetExtension(fThumb.FileName);
                    string img = Utilities.ConvertVietnameseToSEO(page.PageName) + extension;
                    page.Thumb = await Utilities.UploadFile(fThumb, @"pages", img.ToLower());
                }

                if (string.IsNullOrEmpty(page.Thumb))
                {
                    page.Thumb = "default.jpg";
                }
                page.Alias = Utilities.SEOUrl(page.PageName);
                page.CreateAt = DateTime.Now;
                _context.Add(page);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(page);
        }

        // GET: Admin/AdminPages/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Pages == null)
            {
                return NotFound();
            }

            var page = await _context.Pages.FindAsync(id);
            if (page == null)
            {
                return NotFound();
            }
            return View(page);
        }

        // POST: Admin/AdminPages/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PageId,PageName,Contents,Thumb,Published,Title,MetaDesc,MetaKey,Alias,CreateAt,Ordering")] Page page
            , Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            page.PageName = Utilities.ToTileCase(page.PageName);
            page.Alias = Utilities.SEOUrl(page.PageName);
            if (fThumb == null || fThumb.Length == 0)
            {
                var existingProduct = await _context.Products.FindAsync(page.PageId);
                if (existingProduct != null)
                {
                    page.Thumb = existingProduct.Thumb;
                    _context.Entry(existingProduct).State = EntityState.Detached; // Detach the existing product
                    _context.Update(page);
                    _notifyService.Success("Sửa thành công");
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
            }
            else
            {
                string extension = Path.GetExtension(fThumb.FileName);
                string img = Utilities.ConvertVietnameseToSEO(page.PageName) + extension;
                page.Thumb = await Utilities.UploadFile(fThumb, @"pages", img.ToLower());
            }

            _context.Entry(page).State = EntityState.Modified;
            _notifyService.Success("Sửa thành công");
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        // GET: Admin/AdminPages/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Pages == null)
            {
                return NotFound();
            }

            var page = await _context.Pages
                .FirstOrDefaultAsync(m => m.PageId == id);
            if (page == null)
            {
                return NotFound();
            }

            return View(page);
        }

        // POST: Admin/AdminPages/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Pages == null)
            {
                return Problem("Entity set 'CfOderContext.Pages'  is null.");
            }
            var page = await _context.Pages.FindAsync(id);
            if (page != null)
            {
                _context.Pages.Remove(page);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PageExists(int id)
        {
          return (_context.Pages?.Any(e => e.PageId == id)).GetValueOrDefault();
        }
    }
}
