using System;
using System.Collections.Generic;

namespace FinalProject_OrderCoffe.Models
{
    public partial class Account
    {
        public int Id { get; set; }
        public string? Phone { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? Salt { get; set; }
        public bool Active { get; set; }
        public string? Fullname { get; set; }
        public int? RoleId { get; set; }
        public DateTime? Lastlogin { get; set; }
        public DateTime? CreateDate { get; set; }

        public virtual Role? Role { get; set; }
    }
}
