using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PagePublisher схожа с логикой PageAuthors
    /// </summary>
    public partial class PagePublisher : Page
    {
        public PagePublisher()
        {
            InitializeComponent();
            //DGridPublisher.ItemsSource = LibraryEntities.GetContext().Publisher.ToList();
        }
        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                Manager.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridPublisher.ItemsSource = Manager.GetContext().Publisher.ToList();
            }
        }
        private void Button_Click_Del(object sender, RoutedEventArgs e)
        {
            var delPublisher = DGridPublisher.SelectedItems.Cast<Publisher>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить {delPublisher.Count()} элементов?", "Внимание!", MessageBoxButton.YesNo,
                MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    Manager.GetContext().Publisher.RemoveRange(delPublisher);
                    Manager.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены...");
                    DGridPublisher.ItemsSource = Manager.GetContext().Publisher.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }
        private void Button_Click_Add(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PagePublisherEdit(null, false));
        }
        private void Button_Click_Edit(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PagePublisherEdit((sender as Button).DataContext as Publisher, true));
        }
    }
}
