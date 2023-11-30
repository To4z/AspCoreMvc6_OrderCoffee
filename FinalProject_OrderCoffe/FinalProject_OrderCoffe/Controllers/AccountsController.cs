using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using System.Security.Cryptography.X509Certificates;
using AspNetCoreHero.ToastNotification.Abstractions;
using FinalProject_OrderCoffe.Models;
using FinalProject_OrderCoffe.ModelViews;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using OrderCoffee.Extension;
using OrderCoffee.Helper;

namespace FinalProject_OrderCoffe.Controllers
{
    [Authorize]
    public class AccountsController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }
        public AccountsController(ILogger<HomeController> logger, CfOderContext context, INotyfService notifyService)
        {
            _logger = logger;
            _context = context;
            _notifyService = notifyService;
        }
        [Route("tai-khoan-cua-toi.html", Name = "Dashboard")]
        public IActionResult Dashboard()
        {
            var tkid = HttpContext.Session.GetString("CustomerId");
            if (tkid != null)
            {

                var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x=> x.CustomerId == Convert.ToInt32(tkid));
                if(khachhang  != null)
                {
                    var lsOrder = _context.Orders
                        .AsNoTracking()
                        .Include(x=> x.TranSacStatus)
                        .Where(x => x.CustomerId == khachhang.CustomerId)
                        .OrderBy(x=> x.OrderDate).ToList();
                    ViewBag.DonHang = lsOrder;
                    return View(khachhang);
                }
            }
            return RedirectToAction("Login");
        }
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ValidatePhone(string phone)
        {
            try
            {
                var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x => x.Phone.ToLower() == phone.ToLower());
                if (khachhang != null)
                {
                    return Json(data: "Số điện thoại : " + phone + " Đã được được đăng ký");
                    
                } return Json(data: true);   
            } catch 
            {
                return Json(data: true);
            }
        }
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ValidateEmail(string email)
        {
            try
            {
                var khachhang = _context.Customers.AsNoTracking().SingleOrDefault(x => x.Email.ToLower() == email.ToLower());
                if (khachhang != null)
                {
                    return Json(data: "Email : " + email + " Đã được được đăng ký <br/>");

                }
                return Json(data: true);
            }
            catch
            {
                return Json(data: true);
            }
        }
        [HttpGet]
        [AllowAnonymous]
        [Route("dang-ky.html", Name = "Dangky")]
        public IActionResult DangKyTaiKhoan() { return  View(); }
        [HttpPost]
        [AllowAnonymous]
        [Route("dang-ky.html", Name = "Dangky")]
        public async Task<IActionResult> DangKyTaiKhoan(RegisterViewModel customer)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string salt = Utilities.GetRandomKey();
                    Customer c = new Customer
                    {
                        Fullname = customer.FullName,
                        Phone = customer.Phone,
                        Email = customer.Email,
                        Password = (customer.Password + salt.Trim()).ToMD5(),
                        Active = true,
                        Salt = salt,
                        CreateDate = DateTime.Now
                        
                    };
                    try
                    {
                        _context.Add(c);
                        await _context.SaveChangesAsync();
                        HttpContext.Session.SetString("CustomerId", c.CustomerId.ToString());
                        var tkId = HttpContext.Session.GetString("CustomerId");
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name , c.Fullname.ToString()),
                            new Claim("CustomerId", c.CustomerId.ToString())
                        };
                        ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, "login");
                        ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
                        await HttpContext.SignInAsync(claimsPrincipal);
                        _notifyService.Success("Đăng ký thành công");
                        return RedirectToAction("Dashboard", "Accounts");
                    } catch 
                    {
                        return RedirectToAction("DangKyTaiKhoan", "Accounts");
                    }
                } else
                {
                    return View(customer);
                }
            } catch
            {
                return View(customer);
            }
        }

        [AllowAnonymous]
        [Route("dang-nhap.html", Name = "DangNhap")]
        public async Task<IActionResult> Login(string returnUrl = null)
        {
            var tkid = HttpContext.Session.GetString("CustomerId");
            if(tkid != null)
            {
                
                return RedirectToAction("Dashboard", "Account");
            }
            return View();
        }
        [HttpPost]
        [AllowAnonymous]
        [Route("dang-nhap.html", Name = "DangNhap")]
        public async Task<IActionResult> Login(LoginViewModel model, string returnUrl = null)
        {
            var khachhang = _context.Customers.AsNoTracking().FirstOrDefault(x => x.Email.Trim().Equals(model.UserName.Trim()));
            var account = _context.Accounts.AsNoTracking().FirstOrDefault(x => x.Email.Trim().Equals(model.UserName.Trim()));
            string passAdmin = (model.Password + account.Salt.Trim()).ToMD5();
            if (account.Password == passAdmin)
            {
                return RedirectToAction("Index", "AdminProducts", new { area = "Admin" });
            }

            if (khachhang == null) return RedirectToAction("DangKyTaiKhoan");
            string pass = (model.Password + khachhang.Salt.Trim()).ToMD5();

            if (khachhang.Password != pass)
            {
                _notifyService.Success("Sai thông tin đăng nhập!");
                return View();
            }


            if (khachhang.Active == false) return RedirectToAction("ThongBao", "Accounts");

            HttpContext.Session.SetString("CustomerId", khachhang.CustomerId.ToString());
            var tkId = HttpContext.Session.GetString("CustomerId");

            var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name , khachhang.Fullname.ToString()),
                        new Claim("CustomerId", khachhang.CustomerId.ToString())
                    };

            ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, "login");
            ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
            await HttpContext.SignInAsync(claimsPrincipal);
            _notifyService.Success("Đăng nhập thành công");
            return RedirectToAction("Dashboard", "Accounts");

        }

        [HttpGet]
        [Route("dang-xuat.html", Name = "LogOut")]
        public IActionResult Lohout()
        {
            HttpContext.SignOutAsync();
            HttpContext.Session.Remove("CustomerId");
            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public IActionResult ChangePassword(ChangePasswordViewModel model)
        {
            var tkid = (HttpContext.Session.GetString("CustomerId"));
            if(tkid == null) {
                return RedirectToAction("Login", "Accounts");
            }
            var taikhoan = _context.Customers.Find(Convert.ToInt32(tkid));
            if (ModelState.IsValid)
            {
                if(taikhoan == null)
                {
                    return RedirectToAction("Index", "Home");
                }
                var pass = (model.PasswordNow.Trim() + taikhoan.Salt.Trim()).ToMD5();
                if(pass == taikhoan.Password)
                {
                    string passnew = (model.Password.Trim() + taikhoan.Salt.Trim()).ToMD5();
                    taikhoan.Password = passnew;
                    _context.Update(taikhoan);
                    _context.SaveChanges();
                    _notifyService.Success("Thay đổi thành công");
                    return RedirectToAction("Dashboard", "Accounts");
                }
            }
            _notifyService.Success("Thay đổi không thành công");
            return RedirectToAction("Dashboard", "Accounts");
        }

    }


}
