using System.Diagnostics;
using System.Net.WebSockets;
using FinalProject_OrderCoffe.Models;
using FinalProject_OrderCoffe.ModelViews;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_OrderCoffe.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly CfOderContext _context;
        public HomeController(ILogger<HomeController> logger, CfOderContext context)
        {
            _logger = logger;
            _context = context;
        }

        [Route("/" , Name = "Index")]
        public IActionResult Index()
        {
            HomeViewModel model = new HomeViewModel();

            var lsproducts = _context.Products.AsNoTracking()
                .Where(x=> x.Active == true && x.HomeFlag == true)
                .OrderBy(x=> x.DateCreate)
                .ToList();
            
            List<ProductHomeView> productHomeViews = new List<ProductHomeView>();

            var lsCats = _context.Categories.AsNoTracking().Where(x => x.IsAtive == true)
                                .OrderBy(x=> x.CreateDate).ToList();

            foreach(var cat in lsCats)
            {
                ProductHomeView productHomeView = new ProductHomeView();
                productHomeView.Category = cat;
                productHomeView.Products = lsproducts.Where(x=> x.CategoryId == cat.CardId).ToList();
                productHomeViews.Add(productHomeView);
            }

            var tintuc = _context.Tintucs.AsNoTracking()
                .Where(x=> x.Published == true && x.IsNewFeed == true).OrderBy(x=> x.CreateDate).Take(2).ToList();

            model.ProductHomeViews = productHomeViews;
            model.Tintucs = tintuc;
            ViewBag.All = lsproducts;

            return View(model);
        }
        [Route("gioi-thieu.html", Name = "About")]
        public IActionResult About()
        {
            return View();
        }

        [Route("lien-he.html", Name = "Contact")]
        public IActionResult Contact()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}