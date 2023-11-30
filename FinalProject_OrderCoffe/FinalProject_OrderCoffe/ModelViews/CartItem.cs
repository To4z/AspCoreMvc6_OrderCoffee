using System.ComponentModel.DataAnnotations;
using FinalProject_OrderCoffe.Models;

namespace FinalProject_OrderCoffe.ModelViews
{
    public class CartItem
    {
        public Product Product { get; set; }
        public int amount { get; set; }
        public double TotalMoney => amount * Product.Price.Value;
    }
}
