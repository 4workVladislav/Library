using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageBook схожа с логикой PageAuthors
    /// </summary>
    public partial class PageBook : Page
    {
        public PageBook()
        {
            InitializeComponent();
        }
        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                Manager.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridBook.ItemsSource = Manager.GetContext().Books.ToList();
            }
        }
        private void Button_Click_Edit(object sender, RoutedEventArgs e)
        {
           
            Manager.MainFrame.Navigate(new PageBookEdit((sender as Button).DataContext as Books, true));
        }
        private void Button_Click_Add(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageBookEdit(null, false));
        }
        private void Button_Click_Del(object sender, RoutedEventArgs e)
        {
            var delBooks = DGridBook.SelectedItems.Cast<Books>().ToList();
            if(MessageBox.Show($"Вы точно хотите удалить {delBooks.Count()} элементов?", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) 
                == MessageBoxResult.Yes)
            {
                try
                {
                    Manager.GetContext().Books.RemoveRange(delBooks);
                    Manager.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены");
                    DGridBook.ItemsSource = Manager.GetContext().Books.ToList();
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }
    }
}
