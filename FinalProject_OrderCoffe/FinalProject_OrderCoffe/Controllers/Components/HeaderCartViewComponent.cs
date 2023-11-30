using FinalProject_OrderCoffe.Extension;
using FinalProject_OrderCoffe.ModelViews;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_OrderCoffe.Controllers.Components
{
    public class HeaderCartViewComponent : ViewComponent
    {
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var gh = HttpContext.Session.Get<List<CartItem>>("GioHang");
            return View(gh);
        }
    }
}
