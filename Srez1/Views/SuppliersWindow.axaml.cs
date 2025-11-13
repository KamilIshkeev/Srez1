// Srez1/Views/SuppliersWindow.axaml.cs
using Avalonia.Controls;
using Microsoft.EntityFrameworkCore;
using Srez1.Data;
using System.Collections.Generic;
using System.Linq;

namespace Srez1.Views;

public partial class SuppliersWindow : Window
{
    public SuppliersWindow()
    {
        InitializeComponent();
    }
    public SuppliersWindow(int materialId, AppDbContext db)
    {
        InitializeComponent();

        // Загружаем материал вместе с его поставщиками
        var material = db.Materials
            .Include(m => m.Suppliers)
            .FirstOrDefault(m => m.Id == materialId);

        if (material != null)
        {
            Grid.ItemsSource = material.Suppliers.ToList();
        }
        else
        {
            Grid.ItemsSource = new List<Supplier>();
        }
    }
}