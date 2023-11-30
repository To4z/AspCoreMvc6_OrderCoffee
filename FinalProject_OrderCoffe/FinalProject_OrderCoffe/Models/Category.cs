using System;
using System.Collections.Generic;

namespace FinalProject_OrderCoffe.Models
{
    public partial class Category
    {
        public Category()
        {
            Products = new HashSet<Product>();
        }

        public int CardId { get; set; }
        public string? Name { get; set; }
        public string? ImageUrl { get; set; }
        public bool? IsAtive { get; set; }
        public DateTime? CreateDate { get; set; }

        public virtual ICollection<Product> Products { get; set; }
    }
}
