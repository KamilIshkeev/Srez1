using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Srez1.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext()
    {
    }

    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Material> Materials { get; set; }

    public virtual DbSet<MaterialType> MaterialTypes { get; set; }

    public virtual DbSet<ProductType> ProductTypes { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=srez1;Username=postgres;Password=1108");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Material>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("material_pkey");

            entity.ToTable("material");

            entity.HasIndex(e => e.Name, "material_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.MaterialTypeId).HasColumnName("material_type_id");
            entity.Property(e => e.MinStock)
                .HasPrecision(15, 2)
                .HasColumnName("min_stock");
            entity.Property(e => e.Name).HasColumnName("name");
            entity.Property(e => e.PackageQuantity)
                .HasPrecision(15, 2)
                .HasColumnName("package_quantity");
            entity.Property(e => e.StockQuantity)
                .HasPrecision(15, 2)
                .HasColumnName("stock_quantity");
            entity.Property(e => e.UnitOfMeasure).HasColumnName("unit_of_measure");
            entity.Property(e => e.UnitPrice)
                .HasPrecision(12, 2)
                .HasColumnName("unit_price");

            entity.HasOne(d => d.MaterialType).WithMany(p => p.Materials)
                .HasForeignKey(d => d.MaterialTypeId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("material_material_type_id_fkey");

            entity.HasMany(d => d.Suppliers).WithMany(p => p.Materials)
                .UsingEntity<Dictionary<string, object>>(
                    "MaterialSupplier",
                    r => r.HasOne<Supplier>().WithMany()
                        .HasForeignKey("SupplierId")
                        .HasConstraintName("material_supplier_supplier_id_fkey"),
                    l => l.HasOne<Material>().WithMany()
                        .HasForeignKey("MaterialId")
                        .HasConstraintName("material_supplier_material_id_fkey"),
                    j =>
                    {
                        j.HasKey("MaterialId", "SupplierId").HasName("material_supplier_pkey");
                        j.ToTable("material_supplier");
                        j.IndexerProperty<int>("MaterialId").HasColumnName("material_id");
                        j.IndexerProperty<int>("SupplierId").HasColumnName("supplier_id");
                    });
        });

        modelBuilder.Entity<MaterialType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("material_type_pkey");

            entity.ToTable("material_type");

            entity.HasIndex(e => e.Name, "material_type_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.LossPercentage)
                .HasPrecision(5, 4)
                .HasColumnName("loss_percentage");
            entity.Property(e => e.Name).HasColumnName("name");
        });

        modelBuilder.Entity<ProductType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("product_type_pkey");

            entity.ToTable("product_type");

            entity.HasIndex(e => e.Name, "product_type_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Coefficient)
                .HasPrecision(10, 4)
                .HasColumnName("coefficient");
            entity.Property(e => e.Name).HasColumnName("name");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("supplier_pkey");

            entity.ToTable("supplier");

            entity.HasIndex(e => e.Inn, "supplier_inn_key").IsUnique();

            entity.HasIndex(e => e.Name, "supplier_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Inn).HasColumnName("inn");
            entity.Property(e => e.Name).HasColumnName("name");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.StartDate).HasColumnName("start_date");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
