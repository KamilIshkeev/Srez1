using Microsoft.EntityFrameworkCore;
using Srez1.Data;
using System;
using System.Linq;

namespace Srez1.Utils;

/// <summary>
/// Класс для расчёта количества готовой продукции с учётом потерь сырья.
/// </summary>
public static class ProductionCalculator
{
    /// <summary>
    /// Рассчитывает количество готовой продукции на основе типа продукции, типа материала,
    /// количества сырья и параметров продукции.
    /// </summary>
    /// <param name="productTypeId">Идентификатор типа продукции (из таблицы product_type)</param>
    /// <param name="materialTypeId">Идентификатор типа материала (из таблицы material_type)</param>
    /// <param name="rawMaterialAmount">Количество сырья (в единицах измерения материала)</param>
    /// <param name="param1">Первый параметр продукции (положительное число)</param>
    /// <param name="param2">Второй параметр продукции (положительное число)</param>
    /// <param name="dbContext">Контекст базы данных для получения коэффициентов и потерь</param>
    /// <returns>
    /// Целое количество продукции, которое можно произвести.
    /// Возвращает -1, если входные данные некорректны или типы не найдены.
    /// </returns>
    public static int CalculateProducedQuantity(
        int productTypeId,
        int materialTypeId,
        decimal rawMaterialAmount,
        decimal param1,
        decimal param2,
        AppDbContext dbContext)
    {
        // Валидация входных параметров
        if (param1 <= 0 || param2 <= 0 || rawMaterialAmount <= 0)
            return -1;

        // Получаем тип продукции и тип материала из БД
        var productType = dbContext.ProductTypes.FirstOrDefault(p => p.Id == productTypeId);
        var materialType = dbContext.MaterialTypes.FirstOrDefault(m => m.Id == materialTypeId);

        if (productType == null || materialType == null)
            return -1;

        // Расчёт базового количества сырья на 1 единицу продукции
        var baseMaterialPerUnit = param1 * param2 * productType.Coefficient;

        // Учёт потерь: эффективный расход = базовый / (1 - потери)
        // Потери хранятся как доля (например, 0.0012 вместо 0.12%)
        var effectiveMaterialPerUnit = baseMaterialPerUnit / (1 - materialType.LossPercentage);

        // Максимальное количество продукции = общее сырьё / сырьё на единицу
        var maxUnits = rawMaterialAmount / effectiveMaterialPerUnit;

        // Возвращаем целую часть (нельзя произвести дробную плитку)
        return (int)Math.Floor(maxUnits);
    }
}