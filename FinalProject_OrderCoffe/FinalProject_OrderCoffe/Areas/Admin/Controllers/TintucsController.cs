using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using FinalProject_OrderCoffe.Models;
using PagedList.Core;
using OrderCoffee.Helper;
using System.Net;
using AspNetCoreHero.ToastNotification.Abstractions;
using AspNetCoreHero.ToastNotification.Notyf;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class TintucsController : Controller
    {
        private readonly CfOderContext _context;
        public INotyfService _notifyService { get; }
        public TintucsController(CfOderContext context, INotyfService notifyService)
        {
            _context = context;
            _notifyService = notifyService;
        }

        // GET: Admin/Tintucs
        public async Task<IActionResult> Index(int? page)
        {
            
            
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");

            var pagenumber = page == null || page <= 0 ? 1 : page.Value;

            var pageSize = 20;

            var lsTintuc = _context.Tintucs.AsNoTracking()
                .OrderByDescending(x => x.PostId);

            PagedList<Tintuc> models = new PagedList<Tintuc>(lsTintuc, pagenumber, pageSize);

            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }

        // GET: Admin/Tintucs/Details/5
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

            return View(tintuc);
        }

        // GET: Admin/Tintucs/Create
        public IActionResult Create()
        {
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name");
            return View();
        }

        // POST: Admin/Tintucs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PostId,Title,Scontents,Contents,Thumb,Published,Alias,CreateDate,Author,AccountId,Tags,CategoryId,IsHot,IsNewFeed,MetaKey,MetaDesc,Views")] Tintuc tintuc
             , Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            if (ModelState.IsValid)
            {
                tintuc.Title = Utilities.ToTileCase(tintuc.Title);
                if (fThumb != null)
                {
                    string extension = Path.GetExtension(fThumb.FileName);
                    string img = Utilities.ConvertVietnameseToSEO(tintuc.Title) + extension;
                    tintuc.Thumb = await Utilities.UploadFile(fThumb, @"news", img.ToLower());
                }

                if (string.IsNullOrEmpty(tintuc.Thumb))
                {
                    tintuc.Thumb = "default.jpg";
                }


                tintuc.Alias = Utilities.ConvertVietnameseToSEO(tintuc.Title);
                tintuc.CreateDate = DateTime.Now;
                _context.Add(tintuc);

                await _context.SaveChangesAsync();
                _notifyService.Success("Thêm mới thành công");
                return RedirectToAction(nameof(Index));
            }
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name", tintuc.CategoryId);
            
            return View(tintuc);
        }

        // GET: Admin/Tintucs/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Tintucs == null)
            {
                return NotFound();
            }

            var tintuc = await _context.Tintucs.FindAsync(id);
            if (tintuc == null)
            {
                return NotFound();
            }
            ViewData["DanhMuc"] = new SelectList(_context.Categories, "CardId", "Name", tintuc.CategoryId);
            return View(tintuc);
        }

        // POST: Admin/Tintucs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PostId,Title,Scontents,Contents,Thumb,Published,Alias,CreateDate,Author,AccountId,Tags,CategoryId,IsHot,IsNewFeed,MetaKey,MetaDesc,Views")] Tintuc tintuc
            ,Microsoft.AspNetCore.Http.IFormFile fThumb)
        {
            tintuc.Title= Utilities.ToTileCase(tintuc.Title);

            if (fThumb == null || fThumb.Length == 0)
            {
                var existingProduct = await _context.Products.FindAsync(tintuc.PostId);
                if (existingProduct != null)
                {
                    tintuc.Thumb = existingProduct.Thumb;
                    
                    tintuc.Alias = Utilities.ConvertVietnameseToSEO(tintuc.Title);

                    _context.Entry(existingProduct).State = EntityState.Detached; // Detach the existing product

                    _context.Update(tintuc);
                    _notifyService.Success("Sửa thành công");
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
            }
            else
            {
                string extension = Path.GetExtension(fThumb.FileName);
                string img = Utilities.ConvertVietnameseToSEO(tintuc.Title) + extension;
                tintuc.Thumb = await Utilities.UploadFile(fThumb, @"news", img.ToLower());
            }

            tintuc.Alias = Utilities.ConvertVietnameseToSEO(tintuc.Title);

            _context.Entry(tintuc).State = EntityState.Modified;
            _notifyService.Success("Sửa thành công");
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        // GET: Admin/Tintucs/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
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

            return View(tintuc);
        }

        // POST: Admin/Tintucs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Tintucs == null)
            {
                return Problem("Entity set 'CfOderContext.Tintucs'  is null.");
            }
            var tintuc = await _context.Tintucs.FindAsync(id);
            if (tintuc != null)
            {
                _context.Tintucs.Remove(tintuc);
            }
            
            await _context.SaveChangesAsync();
            _notifyService.Success("Xoá thành công");
            return RedirectToAction(nameof(Index));
        }

        private bool TintucExists(int id)
        {
          return (_context.Tintucs?.Any(e => e.PostId == id)).GetValueOrDefault();
        }
    }
}
