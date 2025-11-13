// Srez1/App.axaml.cs
using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;

namespace Srez1;

public partial class App : Application
{



    public override void OnFrameworkInitializationCompleted()
    {
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            desktop.MainWindow = new Views.MainWindow();
        }
        base.OnFrameworkInitializationCompleted();
    }
}