﻿using Microsoft.AspNetCore.Mvc;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        [Area("Admin")]

        public IActionResult Index()
        {
            return View();
        }
    }
}
