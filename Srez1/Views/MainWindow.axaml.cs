// Srez1/Views/MainWindow.axaml.cs
using Avalonia.Controls;
using Microsoft.EntityFrameworkCore;
using Srez1.Data;
using System.Collections.Generic;
using System.Linq;

namespace Srez1.Views;

public partial class MainWindow : Window
{
    private readonly AppDbContext _db = new();

    public MainWindow()
    {
        InitializeComponent();
        LoadData();
    }

    private void LoadData()
    {
        var materials = _db.Materials
            .Include(m => m.MaterialType)
            .OrderBy(m => m.Id) // ← сортировка по ID (или по Name)
            .ToList();
        MaterialsGrid.ItemsSource = materials;
    }

    private void OnAddClick(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        var win = new MaterialEditWindow(null, _db);
        win.Show();
        win.Closed += (_, _) => LoadData();
    }

    private void MaterialsGrid_DoubleTapped(object? sender, Avalonia.Input.TappedEventArgs e)
    {
        if (MaterialsGrid.SelectedItem is Material m)
        {
            var win = new MaterialEditWindow(m, _db);
            win.Show();
            win.Closed += (_, _) => LoadData();
        }
    }

    private void OnSuppliersClick(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        if (MaterialsGrid.SelectedItem is not Material m)
        {
            new MessageBoxWindow("Выберите материал в списке.", "Внимание").Show();
            return;
        }

        var win = new SuppliersWindow(m.Id, _db);
        win.Show();
    }
}