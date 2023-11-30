using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using FinalProject_OrderCoffe.Models;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PagedList.Core;
using AspNetCoreHero.ToastNotification.Abstractions;
using OrderCoffee.Helper;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AdminCategoriesController : Controller
    {
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }
        public AdminCategoriesController(CfOderContext context, INotyfService notifyService)
        {
            _context = context;
            _notifyService = notifyService;
        }

        // GET: Admin/AdminCategories
        public async Task<IActionResult> Index(int? page)
        {
            var pagenumber = page == null || page <= 0 ? 1 : page.Value;
            var pageSize = 20;

            var lsCategory = _context.Categories.AsNoTracking()
                .OrderByDescending(x => x.CardId);

            PagedList<Category> models = new PagedList<Category>(lsCategory, pagenumber, pageSize);

            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }

        // GET: Admin/AdminCategories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Categories == null)
            {
                return NotFound();
            }

            var category = await _context.Categories
                .FirstOrDefaultAsync(m => m.CardId == id);
            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        // GET: Admin/AdminCategories/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/AdminCategories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CardId,Name,ImageUrl,IsAtive,CreateDate")] Category category
            , Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            if (ModelState.IsValid)
            {
                category.Name = Utilities.ToTileCase(category.Name);
                if (fThumb != null)
                {
                    string extension = Path.GetExtension(fThumb.FileName);
                    string img = Utilities.ConvertVietnameseToSEO(category.Name) + extension;
                    category.ImageUrl = await Utilities.UploadFile(fThumb, @"categories", img.ToLower());
                }

                if (string.IsNullOrEmpty(category.ImageUrl))
                {
                    category.ImageUrl = "default.jpg";
                }
                
                category.CreateDate = DateTime.Now;
                _context.Add(category);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(category);
        }

        // GET: Admin/AdminCategories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Categories == null)
            {
                return NotFound();
            }

            var category = await _context.Categories.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            return View(category);
        }

        // POST: Admin/AdminCategories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CardId,Name,ImageUrl,IsAtive,CreateDate")] Category category,
            Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            if (id != category.CardId)
            {
                return NotFound();
            }

            category.Name = Utilities.ToTileCase(category.Name);

            if (fThumb != null && fThumb.Length > 0)
            {
                string extension = Path.GetExtension(fThumb.FileName);
                string img = Utilities.ConvertVietnameseToSEO(category.Name) + extension;
                category.ImageUrl = await Utilities.UploadFile(fThumb, @"categories", img.ToLower());
            }

            var existingCategory = await _context.Categories.FindAsync(category.CardId);
            if (existingCategory == null)
            {
                return NotFound();
            }

            // Update specific properties of the category
            _context.Entry(existingCategory).CurrentValues.SetValues(category);

            await _context.SaveChangesAsync();
            _notifyService.Success("Sửa thành công");
            return RedirectToAction(nameof(Index));
        }


        // GET: Admin/AdminCategories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Categories == null)
            {
                return NotFound();
            }

            var category = await _context.Categories
                .FirstOrDefaultAsync(m => m.CardId == id);
            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        // POST: Admin/AdminCategories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Categories == null)
            {
                return Problem("Entity set 'CfOderContext.Categories'  is null.");
            }
            var category = await _context.Categories.FindAsync(id);
            if (category != null)
            {
                _context.Categories.Remove(category);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CategoryExists(int id)
        {
          return (_context.Categories?.Any(e => e.CardId == id)).GetValueOrDefault();
        }
    }
}
