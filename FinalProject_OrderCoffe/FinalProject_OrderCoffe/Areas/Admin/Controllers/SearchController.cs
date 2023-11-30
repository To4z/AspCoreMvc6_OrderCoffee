using FinalProject_OrderCoffe.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class SearchController : Controller
    {

        private readonly CfOderContext _context;

        public SearchController(CfOderContext context) { _context = context; }


        [HttpPost]
        public IActionResult FindProduct(string key)
        {
            List<Product> lproduct = new List<Product>();
            if (string.IsNullOrEmpty(key) || key.Length < 1)
            {
                return PartialView("ListProductsPartialSearch",
                        null
                    );
            }

            lproduct = _context.Products.AsNoTracking()
                                        .Include(x => x.Category)
                                        .Where(x => x.ProductName.Contains(key))
                                        .OrderByDescending(x => x.ProductName)
                                        .ToList();

            if (lproduct == null || lproduct.Count == 0)
            {
                return PartialView("ListProductsPartialSearch", null);
            }
            else
            {
                return PartialView("ListProductsPartialSearch", lproduct);
            }

        }
    }
}
