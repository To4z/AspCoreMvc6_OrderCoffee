using AspNetCoreHero.ToastNotification.Abstractions;
using FinalProject_OrderCoffe.Extension;
using FinalProject_OrderCoffe.Models;
using FinalProject_OrderCoffe.ModelViews;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_OrderCoffe.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }



        public ShoppingCartController(ILogger<HomeController> logger, CfOderContext context, INotyfService notifyService)
        {
            _logger = logger;
            _context = context;
            _notifyService = notifyService;
        }

        public List<CartItem> GioHang
        {
            get
            {
                var gh = HttpContext.Session.Get<List<CartItem>>("GioHang");
                if (gh == default(List<CartItem>))
                {
                    gh = new List<CartItem>();
                }
                return gh;
            }
        }

        [HttpPost]
        [Route("api/cart/add")]
        public IActionResult AddToCart(int pproductId, int amount)
        {
            List<CartItem> gioHang = GioHang;
            CartItem item = gioHang.SingleOrDefault(p => p.Product.ProductId == pproductId);

            if (item != null)
            {
                 item.amount += amount;
            }
            else
            {
                Product product = _context.Products.SingleOrDefault(x => x.ProductId == pproductId);
                item = new CartItem
                {
                    amount = amount,
                    Product = product
                };
                gioHang.Add(item);
            }

            HttpContext.Session.Set<List<CartItem>>("GioHang", gioHang);
            _notifyService.Success("Thêm sản phẩm thành công");
            return Json(new { success = true });
        }

        [HttpPost]
        [Route("api/cart/update")]
        public IActionResult UpdateCart(int pproductId, int amount)
        {
            List<CartItem> gioHang = GioHang;
            CartItem itemToUpdate = gioHang.FirstOrDefault(p => p.Product.ProductId == pproductId);
            if (itemToUpdate != null)
            {
                itemToUpdate.amount = amount;
            }
            HttpContext.Session.Set<List<CartItem>>("GioHang", gioHang);
            return Json(new { success = true });
        }


        [HttpPost]
        [Route("api/cart/remove")]
        public IActionResult Remove(int pproductId)
        {
            List<CartItem> gioHang = GioHang;
            CartItem item = gioHang.SingleOrDefault(p => p.Product.ProductId == pproductId);

            if (item != null)
            {
                gioHang.Remove(item);
            }

            HttpContext.Session.Set<List<CartItem>>("GioHang", gioHang);
            return Json(new { success = true });
        }



        [Route("cart.html", Name = "Cart")]
        public IActionResult Index()
        {
            return View(HttpContext.Session.Get<List<CartItem>>("GioHang")); 
        }
    }
}
