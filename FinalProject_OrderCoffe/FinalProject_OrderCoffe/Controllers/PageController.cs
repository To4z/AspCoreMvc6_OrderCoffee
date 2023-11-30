using FinalProject_OrderCoffe.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;

namespace FinalProject_OrderCoffe.Controllers
{
    public class PageController : Controller
    {
        private readonly CfOderContext _context;

        public PageController(CfOderContext context)
        {
            _context = context;
        }
      
        [Route("/page/{Alias}", Name = "PagesDetails")]
        public async Task<IActionResult> Details(string alias)
        {
            if(string.IsNullOrEmpty(alias))
            {
                return RedirectToAction("Index", "Home");
            }
           
            var page = _context.Pages.AsNoTracking().SingleOrDefault(m => m.Alias == alias);
            if (page == null)
            {
                return RedirectToAction("Index", "Home");
            }
            return View(page);
        }
    }
}
