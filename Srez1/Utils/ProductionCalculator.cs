using Microsoft.EntityFrameworkCore;
using Srez1.Data;
using System;
using System.Linq;

namespace Srez1.Utils;


public static class ProductionCalculator
{
    public static int CalculateProducedQuantity(
        int productTypeId,
        int materialTypeId,
        decimal rawMaterialAmount,
        decimal param1,
        decimal param2,
        AppDbContext dbContext)
    {
        if (param1 <= 0 || param2 <= 0 || rawMaterialAmount <= 0)
            return -1;
        var productType = dbContext.ProductTypes.FirstOrDefault(p => p.Id == productTypeId);
        var materialType = dbContext.MaterialTypes.FirstOrDefault(m => m.Id == materialTypeId);
        if (productType == null || materialType == null)
            return -1;
        var baseMaterialPerUnit = param1 * param2 * productType.Coefficient;
        var effectiveMaterialPerUnit = baseMaterialPerUnit / (1 - materialType.LossPercentage);
        var maxUnits = rawMaterialAmount / effectiveMaterialPerUnit;
        return (int)Math.Floor(maxUnits);
    }
}