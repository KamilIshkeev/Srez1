using Avalonia.Controls;

namespace Srez1.Views;

public partial class MessageBoxWindow : Window
{
    public MessageBoxWindow()
    {
        InitializeComponent();
    }
    public MessageBoxWindow(string message, string title = "Сообщение")
    {
        InitializeComponent();
        Title = title;
        MessageText.Text = message;
    }

    private void OnClick(object? sender, Avalonia.Interactivity.RoutedEventArgs e) => Close();
}