using AspNetCoreHero.ToastNotification.Abstractions;
using FinalProject_OrderCoffe.Extension;
using FinalProject_OrderCoffe.Models;
using FinalProject_OrderCoffe.ModelViews;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using OrderCoffee.Helper;

namespace FinalProject_OrderCoffe.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }
        public CheckoutController(ILogger<HomeController> logger, CfOderContext context, INotyfService notifyService)
        {
            _logger = logger;
            _context = context;
            _notifyService = notifyService;
        }

        [Route("checkout.html", Name = "Checkout")]
        public IActionResult Index(string returnUrl = null)
        {
            var cart = HttpContext.Session.Get<List<CartItem>>("GioHang");
            var taikhoanId = HttpContext.Session.GetString("CustomerId");
            MuaHangViewModel model = new MuaHangViewModel();
            if(taikhoanId != null)
            {
                var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x=>x.CustomerId == Convert.ToInt32(taikhoanId));
                model.CustomerId = khachhang.CustomerId;
                model.FullName = khachhang.Fullname;
                model.Email = khachhang.Email;
                model.Phone = khachhang.Phone;
                model.Address = khachhang.Address;
            }
            ViewBag.GioHang = cart;
            return View(model);
        }

        [HttpPost]
        [Route("checkout.html", Name = "Checkout")]
        public IActionResult Index(MuaHangViewModel muahang)
        {
            
            var cart = HttpContext.Session.Get<List<CartItem>>("GioHang");
            var taikhoanId = HttpContext.Session.GetString("CustomerId");
            MuaHangViewModel model = new MuaHangViewModel();
            Customer c = new Customer();
            Order don = new Order();
            if (taikhoanId != null)
            {
                var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x => x.CustomerId == Convert.ToInt32(taikhoanId));
                model.CustomerId = khachhang.CustomerId;
                model.FullName = khachhang.Fullname;
                model.Email = khachhang.Email;
                model.Phone = khachhang.Phone;
                model.Address = khachhang.Address;

                khachhang.Location = muahang.TinhThanh;
                khachhang.District = muahang.QuanHuyen;
                khachhang.Ward = muahang.PhuongXa;
                khachhang.Address = muahang.Address;
                _context.Update(khachhang);
                _context.SaveChanges();
                don.CustomerId = khachhang.CustomerId;
            } else
            {
                c.Fullname = muahang.FullName;
				c.Email = muahang.Email;
				c.Phone = muahang.Phone;
				c.Address = muahang.Address;

				c.Location = muahang.TinhThanh;
				c.District = muahang.QuanHuyen;
				c.Ward = muahang.PhuongXa;
				c.Address = muahang.Address;
				_context.Add(c);
                _context.SaveChanges();
                don.CustomerId = c.CustomerId;
            }

            
            don.OrderDate = DateTime.Now;
            don.TranSacStatusId = 1;
            
            don.Deleted = false;
            don.Paid = false;
            don.Note = model.Note;
            if(cart.Count == 1 && cart[0].amount == 1)
            {
                don.TotalMoney = Convert.ToInt32(cart[0].TotalMoney);
            }
            else
            {
                don.TotalMoney = Convert.ToInt32(cart.Sum(x => x.TotalMoney));
            }
            _context.Add(don);
            _context.SaveChanges();

            foreach (var item in cart)
            {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.OrderId = don.OrderId;
                orderDetail.ProductId = item.Product.ProductId;
                orderDetail.Quantity = item.amount;
                orderDetail.Total = Convert.ToInt32(don.TotalMoney);
                orderDetail.ShipDate = DateTime.Now;
                _context.Add(orderDetail);
            }
            _context.SaveChanges();

            HttpContext.Session.Remove("GioHang");
            _notifyService.Success("Đơn hàng đặt hàng thành công");
            return RedirectToAction("Success");

        }

        public IActionResult Success()
        {
            var taikhoanId = HttpContext.Session.GetString("CustomerId");
            
            var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x => x.CustomerId == Convert.ToInt32(taikhoanId));
            if(khachhang == null)
            {
                khachhang = _context.Customers.OrderBy(x=> x.CustomerId).LastOrDefault();
            }
            var don = _context.Orders.AsNoTracking().SingleOrDefault(x => x.CustomerId == Convert.ToInt32(khachhang.CustomerId));
            MuaHangSuccess muaHangSuccess = new MuaHangSuccess();
            muaHangSuccess.FullName = khachhang.Fullname;
            muaHangSuccess.DonHangId = don.OrderId;
            muaHangSuccess.Phone = khachhang.Phone;
            muaHangSuccess.Address = khachhang.Address;
            muaHangSuccess.PhuongXa = khachhang.Ward;
            muaHangSuccess.QuanHuyen = khachhang.District;
            muaHangSuccess.TinhThanh = khachhang.Location;

            return View(muaHangSuccess);
        }
    }
}
