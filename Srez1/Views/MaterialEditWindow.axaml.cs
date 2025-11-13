using Avalonia.Controls;
using Srez1.Data;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Srez1.Views;

public partial class MaterialEditWindow : Window
{
    private readonly Material? _material;
    private readonly AppDbContext _db;
    private readonly List<MaterialType> _types;
    public MaterialEditWindow()
    {
        InitializeComponent();
    }
    public MaterialEditWindow(Material? material, AppDbContext db)
    {
        InitializeComponent();
        _material = material;
        _db = db;
        _types = _db.MaterialTypes.ToList();
        _units = _db.UnitOfMeasures.ToList();

        foreach (var t in _types)
            TypeCombo.Items.Add(t.Name);
        foreach (var u in _units) UnitCombo.Items.Add(u.Symbol); 

        if (_material != null)
        {
            NameBox.Text = _material.Name;
            TypeCombo.SelectedIndex = _types.FindIndex(t => t.Id == _material.MaterialTypeId);
            PriceBox.Text = _material.UnitPrice.ToString("F2", CultureInfo.InvariantCulture); 
            StockBox.Text = _material.StockQuantity.ToString("F2", CultureInfo.InvariantCulture);
            MinStockBox.Text = _material.MinStock.ToString("F2", CultureInfo.InvariantCulture);
            PackageBox.Text = _material.PackageQuantity.ToString("F0", CultureInfo.InvariantCulture);
            UnitCombo.SelectedIndex = _units.FindIndex(u => u.Id == _material.UnitOfMeasureId);
        }
    }

    private readonly List<UnitOfMeasure> _units;
    private readonly List<SupplierType> _supplierTypes;

    private void OnSave(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        try
        {
            var name = NameBox!.Text.Trim();
            var typeIdx = TypeCombo!.SelectedIndex;
            var unitId = _units[UnitCombo.SelectedIndex].Id;

            if (string.IsNullOrWhiteSpace(name) || unitId < 0 || typeIdx < 0)
                throw new ArgumentException("Заполните все поля.");

            if (!decimal.TryParse(PriceBox!.Text, NumberStyles.Float, CultureInfo.InvariantCulture, out var price) ||
                !decimal.TryParse(StockBox!.Text, NumberStyles.Float, CultureInfo.InvariantCulture, out var stock) ||
                !decimal.TryParse(MinStockBox!.Text, NumberStyles.Float, CultureInfo.InvariantCulture, out var min) ||
                !decimal.TryParse(PackageBox!.Text, NumberStyles.Float, CultureInfo.InvariantCulture, out var pkg))
                throw new ArgumentException("Неверный формат числа. Используйте точку как десятичный разделитель.");

            if (price < 0 || stock < 0 || min < 0 || pkg <= 0)
                throw new ArgumentException("Числовые значения должны быть >= 0 (упаковка > 0).");

            if (_material == null)
            {
                _db.Materials.Add(new Material
                {
                    Name = name,
                    MaterialTypeId = _types[typeIdx].Id,
                    UnitPrice = price,
                    StockQuantity = stock,
                    MinStock = min,
                    PackageQuantity = pkg,
                    UnitOfMeasureId = unitId
                });
            }
            else
            {
                _material.Name = name;
                _material.MaterialTypeId = _types[typeIdx].Id;
                _material.UnitPrice = price;
                _material.StockQuantity = stock;
                _material.MinStock = min;
                _material.PackageQuantity = pkg;
                _material.UnitOfMeasureId = unitId;
            }

            _db.SaveChanges();
            Close();
        }
        catch (Exception ex)
        {
            new MessageBoxWindow($"Ошибка: {ex.Message}", "Ошибка ввода").Show();
        }
    }

    private void OnCancel(object? sender, Avalonia.Interactivity.RoutedEventArgs e) => Close();
}