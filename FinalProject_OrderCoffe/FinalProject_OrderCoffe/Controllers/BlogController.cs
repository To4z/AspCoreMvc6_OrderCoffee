using FinalProject_OrderCoffe.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;

namespace FinalProject_OrderCoffe.Controllers
{
    public class BlogController : Controller
    {
        private readonly CfOderContext _context;

        public BlogController(CfOderContext context)
        {
            _context = context;
        }
        [Route("blogs.html", Name ="Blog")]
        public async Task<IActionResult> Index(int? page)
        {
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
            var pagenumber = page == null || page <= 0 ? 1 : page.Value;
            var pageSize = 4;
            var lsTintuc = _context.Tintucs.AsNoTracking()
                .OrderBy(x => x.PostId);

            PagedList<Tintuc> models = new PagedList<Tintuc>(lsTintuc, pagenumber, pageSize);

            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }

        [Route("/tin-tuc/{Alias}-{id}.html", Name = "TinDetails")]
        public async Task<IActionResult> Details(int? id)
        {
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
            if (id == null || _context.Tintucs == null)
            {
                return NotFound();
            }
            var tintuc = await _context.Tintucs
                .FirstOrDefaultAsync(m => m.PostId == id);
            if (tintuc == null)
            {
                return NotFound();
            }

            var lsTinTucLienQuan = _context.Tintucs
                .AsNoTracking()
                .Where(x => x.Published == true && x.PostId != id)
                .Take(3).OrderBy(x => x.CreateDate).ToList();
            ViewBag.lsTinTucLienQuan = lsTinTucLienQuan;
            return View(tintuc);
        }

    }
}
