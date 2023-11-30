using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using FinalProject_OrderCoffe.Models;
using PagedList.Core;

namespace FinalProject_OrderCoffe.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AdminOrdersController : Controller
    {
        private readonly CfOderContext _context;

        public AdminOrdersController(CfOderContext context)
        {
            _context = context;
        }

        // GET: Admin/AdminOrders
        public async Task<IActionResult> Index(int? page)
        {
            var pagenumber = page == null || page <= 0 ? 1 : page.Value;

            var pageSize = 20;

            var lsCustomer = _context.Orders.Include(o => o.Customer).Include(o => o.TranSacStatus).OrderBy(x=> x.OrderDate);

            PagedList<Order> models = new PagedList<Order>(lsCustomer, pagenumber, pageSize);

            ViewBag.CurrentPage = pagenumber;

            return View(models);
        }
        // GET: Admin/AdminOrders/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.Customer)
                .Include(o => o.TranSacStatus)
                .FirstOrDefaultAsync(m => m.OrderId == id);

            var lsOrder = _context.OrderDetails
                        .Include(x=> x.Product)
                        .AsNoTracking()
                        .Where(x => x.OrderId == order.OrderId)
                        .OrderBy(x => x.OderDetailsId).ToList();

            ViewBag.DonHang = lsOrder;
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // GET: Admin/AdminOrders/Create
        public IActionResult Create()
        {
            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "CustomerId");
            ViewData["TranSacStatusId"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "TransacstatusId");
            return View();
        }

        // POST: Admin/AdminOrders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("OrderId,CustomerId,OrderDate,ShipDate,TranSacStatusId,Deleted,Paid,PaymentDate,PaymentId,Note,TotalMoney")] Order order)
        {
            if (ModelState.IsValid)
            {
                _context.Add(order);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "CustomerId", order.CustomerId);
            ViewData["TranSacStatusId"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "TransacstatusId", order.TranSacStatusId);
            return View(order);
        }

        // GET: Admin/AdminOrders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders.FindAsync(id);
            if (order == null)
            {
                return NotFound();
            }
            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "CustomerId", order.CustomerId);
            ViewData["TranSacStatusId"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "TransacstatusId", order.TranSacStatusId);
            return View(order);
        }

        
        // POST: Admin/AdminOrders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderId,CustomerId,OrderDate,ShipDate,TranSacStatusId,Deleted,Paid,PaymentDate,PaymentId,Note,TotalMoney")] Order order)
        {
            if (id != order.OrderId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(order);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrderExists(order.OrderId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "CustomerId", order.CustomerId);
            ViewData["TranSacStatusId"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "TransacstatusId", order.TranSacStatusId);
            return View(order);
        }

        public async Task<IActionResult> ChangeStatus(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }
            var order = await _context.Orders.FindAsync(id);
            if (order == null)
            {
                return NotFound();
            }

            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "Fullname", order.CustomerId);
            ViewData["TrangThai"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "Status", order.TranSacStatusId);
            return View(order);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ChangeStatus(int id, [Bind("OrderId,CustomerId,OrderDate,ShipDate,TranSacStatusId,Deleted,Paid,PaymentDate,PaymentId,Note,TotalMoney")] Order order)
        {
            if (id != order.OrderId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                
                try
                {
                    var don = _context.Orders.AsNoTracking().Include(x=> x.Customer).FirstOrDefault();
                    if(order.TranSacStatusId == 5)
                    {
                        order.Deleted = true;
                    } else if(order.TranSacStatusId == 5)
                    {
                        order.ShipDate = DateTime.Now;
                    }
                    _context.Update(order);
                    
                    
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrderExists(order.OrderId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["CustomerId"] = new SelectList(_context.Customers, "CustomerId", "CustomerId", order.CustomerId);
            ViewData["TranSacStatusId"] = new SelectList(_context.TransactStatuses, "TransacstatusId", "TransacstatusId", order.TranSacStatusId);
            return View(order);
        }

        // GET: Admin/AdminOrders/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.Customer)
                .Include(o => o.TranSacStatus)
                .FirstOrDefaultAsync(m => m.OrderId == id);
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // POST: Admin/AdminOrders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Orders == null)
            {
                return Problem("Entity set 'CfOderContext.Orders'  is null.");
            }
            var order = await _context.Orders.FirstOrDefaultAsync(m => m.OrderId == id);
            if (order != null)
            {

                order.Deleted = true;
                _context.Update(order);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool OrderExists(int id)
        {
          return (_context.Orders?.Any(e => e.OrderId == id)).GetValueOrDefault();
        }
    }
}
