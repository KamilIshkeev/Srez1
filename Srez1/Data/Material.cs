using System;
using System.Collections.Generic;

namespace Srez1.Data;

public partial class Material
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int MaterialTypeId { get; set; }

    public decimal UnitPrice { get; set; }

    public decimal StockQuantity { get; set; }

    public decimal MinStock { get; set; }

    public decimal PackageQuantity { get; set; }

    public int UnitOfMeasureId { get; set; }

    public virtual MaterialType MaterialType { get; set; } = null!;

    public virtual UnitOfMeasure UnitOfMeasure { get; set; } = null!;

    public virtual ICollection<Supplier> Suppliers { get; set; } = new List<Supplier>();
}
