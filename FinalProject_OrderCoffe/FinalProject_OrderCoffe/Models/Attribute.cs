using System;
using System.Collections.Generic;

namespace FinalProject_OrderCoffe.Models
{
    public partial class Attribute
    {
        public Attribute()
        {
            AttributesPrices = new HashSet<AttributesPrice>();
        }

        public int AttributesId { get; set; }
        public string? Name { get; set; }

        public virtual ICollection<AttributesPrice> AttributesPrices { get; set; }
    }
}
