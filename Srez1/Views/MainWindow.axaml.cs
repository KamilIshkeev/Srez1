using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Media;
using Microsoft.EntityFrameworkCore;
using Srez1.Data;
using System.Collections.Generic;
using System.Linq;

namespace Srez1.Views;

public partial class MainWindow : Window
{
    private readonly AppDbContext _db = new();
    private Material? _selectedMaterial;
    private Border? _lastSelectedBorder;

    public MainWindow()
    {
        InitializeComponent();
        LoadData();
    }

    private void LoadData()
    {
        var materials = _db.Materials
            .Include(m => m.MaterialType)
            .Include(m => m.UnitOfMeasure)
            .OrderBy(m => m.Id)
            .ToList();

        MaterialsList.ItemsSource = materials;
        _selectedMaterial = null;
        _lastSelectedBorder = null;
    }

    private void OnAddClick(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        var win = new MaterialEditWindow(null, _db);
        win.Show();
        win.Closed += (_, _) => LoadData();
    }

    private void MaterialsList_ItemClicked(object? sender, PointerPressedEventArgs e)
    {
        if (e.Source is Border border && border.DataContext is Material material)
        {
            if (_lastSelectedBorder != null)
            {
                _lastSelectedBorder.BorderBrush = new SolidColorBrush(Color.Parse("#ABCFCE"));
                _lastSelectedBorder.BorderThickness = new Thickness(1);
            }

            border.BorderBrush = Brushes.Black;
            border.BorderThickness = new Thickness(3);

            _lastSelectedBorder = border;
            _selectedMaterial = material;
        }
    }

    private void MaterialsList_ItemDoubleTapped(object? sender, TappedEventArgs e)
    {
        if (e.Source is Border border && border.DataContext is Material material)
        {
            var win = new MaterialEditWindow(material, _db);
            win.Show();
            win.Closed += (_, _) => LoadData();
        }
    }

    private void OnSuppliersClick(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        if (_selectedMaterial == null)
        {
            new MessageBoxWindow("Выберите материал в списке (кликните по карточке).", "Внимание").Show();
            return;
        }

        var win = new SuppliersWindow(_selectedMaterial.Id, _db);
        win.Show();
    }
}