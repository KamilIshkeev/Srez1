// Srez1/Views/MaterialEditWindow.axaml.cs
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

        foreach (var t in _types)
            TypeCombo.Items.Add(t.Name);

        if (_material != null)
        {
            NameBox.Text = _material.Name;
            TypeCombo.SelectedIndex = _types.FindIndex(t => t.Id == _material.MaterialTypeId);
            PriceBox.Text = _material.UnitPrice.ToString("F2", CultureInfo.InvariantCulture); // ← добавлено InvariantCulture
            StockBox.Text = _material.StockQuantity.ToString("F2", CultureInfo.InvariantCulture);
            MinStockBox.Text = _material.MinStock.ToString("F2", CultureInfo.InvariantCulture);
            PackageBox.Text = _material.PackageQuantity.ToString("F0", CultureInfo.InvariantCulture);
            UnitBox.Text = _material.UnitOfMeasure;
        }
    }

    private void OnSave(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        try
        {
            var name = NameBox!.Text.Trim();
            var typeIdx = TypeCombo!.SelectedIndex;
            var unit = UnitBox!.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(unit) || typeIdx < 0)
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
                // Добавление нового материала
                _db.Materials.Add(new Material
                {
                    Name = name,
                    MaterialTypeId = _types[typeIdx].Id,
                    UnitPrice = price,
                    StockQuantity = stock,
                    MinStock = min,
                    PackageQuantity = pkg,
                    UnitOfMeasure = unit
                });
            }
            else
            {
                // Редактирование существующего материала — ОБНОВЛЯЕМ СВОЙСТВА МОДЕЛИ, а не UI!
                _material.Name = name;
                _material.MaterialTypeId = _types[typeIdx].Id;
                _material.UnitPrice = price;
                _material.StockQuantity = stock;
                _material.MinStock = min;
                _material.PackageQuantity = pkg;
                _material.UnitOfMeasure = unit;
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