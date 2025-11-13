using System;
using System.Collections.Generic;

namespace Srez1.Data;

public partial class UnitOfMeasure
{
    public int Id { get; set; }

    public string Symbol { get; set; } = null!;

    public virtual ICollection<Material> Materials { get; set; } = new List<Material>();
}
