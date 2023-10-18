using System;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    ///Логика взаимодействия для PagePublisherEdit схожа с логикой PageAuthorsEdit
    /// </summary>
    public partial class PagePublisherEdit : Page
    {
        bool _edit;
        private Publisher _currentPublisher = new Publisher();
        public PagePublisherEdit(Publisher selectedPublisher, bool edit)
        {
            InitializeComponent();
            _edit = edit;
            if (selectedPublisher != null)
            {
                TB_ID_Publisher.IsEnabled = false;
                _currentPublisher = selectedPublisher;
            }
            DataContext = _currentPublisher;
        }
        private void Button_Click_Save(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentPublisher.Name_Publisher))
                errors.AppendLine("Пустое поле названия издательства!");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            try
            {
                if (!_edit)
                {
                    Manager.GetContext().Publisher.Add(_currentPublisher);
                }
                Manager.GetContext().SaveChanges();
                MessageBox.Show("сохранено ...");
                Manager.MainFrame.GoBack();
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message.ToString());
            }
        }
    }
}
