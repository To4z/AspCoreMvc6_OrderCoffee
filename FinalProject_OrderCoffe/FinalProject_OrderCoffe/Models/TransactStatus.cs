using System;
using System.Collections.Generic;

namespace FinalProject_OrderCoffe.Models
{
    public partial class TransactStatus
    {
        public TransactStatus()
        {
            Orders = new HashSet<Order>();
        }

        public int TransacstatusId { get; set; }
        public string? Status { get; set; }
        public string? Description { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
