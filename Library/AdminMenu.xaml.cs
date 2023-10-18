using System.Windows;


namespace Library
{
    /// <summary>
    /// Логика взаимодействия для AdminMenu.xaml
    /// </summary>
    public partial class AdminMenu : Window
    {
        public AdminMenu()
        {
            InitializeComponent();
            Manager.MainFrame = MainFrame;

        }

        private void Button_Click_Book(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageBook());
        }

        private void Button_Click_Authors(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageAuthors());
        }

        private void Button_Click_Publisher(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PagePublisher());
        }

        private void Button_Click_Readers(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageReaders());
        }

        private void Button_Click_Extradition(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageExtradition());
        }
    }
}
