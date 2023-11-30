using FinalProject_OrderCoffe.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;

namespace FinalProject_OrderCoffe.Controllers
{
    public class ProductController : Controller
    {

        private readonly CfOderContext _context;

        public ProductController(CfOderContext context)
        {
            _context = context;
        }
        [Route("/shop.html", Name = "ShopProduct")]
        public IActionResult Index(int? page)
        {
            try
            {
                ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
                var pagenumber = page == null || page <= 0 ? 1 : page.Value;
                var pageSize = 9;
                var lsproducts = _context.Products.AsNoTracking()
                    .OrderBy(x => x.DateCreate);

                PagedList<Product> models = new PagedList<Product>(lsproducts, pagenumber, pageSize);

                var cat = _context.Categories.AsNoTracking().OrderBy(x => x.Name).ToList();

                ViewBag.Cat = cat;
                ViewBag.CurrentPage = pagenumber;

                return View(models);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Home");
            }
            
        }
        [Route("/{Alias}", Name = "ListProduct")]
        public IActionResult List(string Alias, int page = 1)
        {
            try
            {
                ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
                
                var pageSize = 9;
                var danhmuc = _context.Categories.AsNoTracking().SingleOrDefault(x => x.ImageUrl == Alias);

                var lsproducts = _context.Products.AsNoTracking()
                    .Where(x => x.CategoryId == danhmuc.CardId)
                    .OrderBy(x => x.DateCreate);
                PagedList<Product> models = new PagedList<Product>(lsproducts, page, pageSize);

                ViewBag.CurrentPage = page;
                ViewBag.CurrentCat = danhmuc;
                ViewBag.cat = _context.Categories.AsNoTracking().OrderBy(x => x.Name).ToList();

                return View(models);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Home");
            }

        }
        [Route("/{Alias}-{id}.html", Name = "ProductDetails")]
        public IActionResult Details(int id)
        {
            var product = _context.Products.Include(x => x.Category).FirstOrDefault(x => x.ProductId == id);
            var lsProducts = _context.Products.AsNoTracking()
                            .Where(x => x.CategoryId == product.CategoryId && x.ProductId != id && x.Active == true)
                            .OrderBy(x=> x.DateCreate).Take(3).ToList();
                            
            ViewBag.Sanpham = lsProducts;
            return View(product);
        }
    }
}
