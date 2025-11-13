using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Srez1.Data
{
    public partial class Material
    {
        public decimal MinOrderCost
        {
            get
            {
                if (StockQuantity >= MinStock) return 0;

                var deficit = MinStock - StockQuantity;
                var packages = Math.Ceiling((double)(deficit / PackageQuantity));
                var orderQty = packages * (double)PackageQuantity;
                return (decimal)(orderQty * (double)UnitPrice);
            }
        }
    }
}
