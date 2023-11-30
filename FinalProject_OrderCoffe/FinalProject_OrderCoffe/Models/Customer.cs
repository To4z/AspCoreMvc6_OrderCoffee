using System;
using System.Collections.Generic;

namespace FinalProject_OrderCoffe.Models
{
    public partial class Customer
    {
        public Customer()
        {
            Orders = new HashSet<Order>();
        }

        public int CustomerId { get; set; }
        public string? Fullname { get; set; }
        public DateTime? Birthday { get; set; }
        public string? Avartar { get; set; }
        public string? Address { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public int? LocationId { get; set; }
        public string? District { get; set; }
        public string? Ward { get; set; }
        public DateTime? CreateDate { get; set; }
        public string? Password { get; set; }
        public string? Salt { get; set; }
        public DateTime? LastLogin { get; set; }
        public bool Active { get; set; }
        public string? Location { get; set; }

        public virtual Location? LocationNavigation { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
