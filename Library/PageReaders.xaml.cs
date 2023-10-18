using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageReaders схожа с логикой PageAuthors
    /// </summary>
    public partial class PageReaders : Page
    {
        public PageReaders()
        {
            InitializeComponent();
        }
        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                Manager.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridReaders.ItemsSource = Manager.GetContext().Readers.ToList();
            }
        }
        private void Button_Click_Del(object sender, RoutedEventArgs e)
        {
            var delReaders = DGridReaders.SelectedItems.Cast<Readers>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить {delReaders.Count()} элементов?", "Внимание!", MessageBoxButton.YesNo,
                MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    Manager.GetContext().Readers.RemoveRange(delReaders);
                    Manager.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены...");
                    DGridReaders.ItemsSource = Manager.GetContext().Readers.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }
        private void Button_Click_Add(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageReadersEdit(null, false));
        }
        private void Button_Click_Edit(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageReadersEdit((sender as Button).DataContext as Readers, true));
        }
    }
}
