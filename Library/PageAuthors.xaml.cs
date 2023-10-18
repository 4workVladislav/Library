using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageAuthors.xaml
    /// </summary>
    public partial class PageAuthors : Page
    {
        public PageAuthors()
        {
            InitializeComponent();
        }
        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                Manager.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridAuthors.ItemsSource = Manager.GetContext().Authors.ToList();
            }
        }
        //кнопка удаления имеет в себе проверку на ошибочность, что позволяет уберечь от случайного удаления
        private void Button_Click_Del(object sender, RoutedEventArgs e)
        {
            var delAuthors = DGridAuthors.SelectedItems.Cast<Authors>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить {delAuthors.Count()} элементов?", "Внимание!", MessageBoxButton.YesNo, 
                MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    Manager.GetContext().Authors.RemoveRange(delAuthors);
                    Manager.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены...");
                    DGridAuthors.ItemsSource = Manager.GetContext().Authors.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }
        //кнопка добавления элимента
        private void Button_Click_Add(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageAuthorsEdit(null, false));
        }
        //в кнопку редактирования передаём нужное поле для редактирования
        private void Button_Click_Edit(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new PageAuthorsEdit((sender as Button).DataContext as Authors, true));
        }
    }
}
