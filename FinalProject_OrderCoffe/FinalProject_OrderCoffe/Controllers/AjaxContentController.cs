using Microsoft.AspNetCore.Mvc;

namespace FinalProject_OrderCoffe.Controllers
{
    public class AjaxContentController : Controller
    {
        public IActionResult HeaderCart()
        {
            return ViewComponent("HeaderCart");
        }

        public IActionResult HeaderNumber()
        {
            return ViewComponent("NumberCart");
        }
    }
}
