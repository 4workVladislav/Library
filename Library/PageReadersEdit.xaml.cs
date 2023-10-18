using System;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageReadersEdit схожа с логикой PageAuthorsEdit
    /// за тем исключением, что при редактировании можно менять ключевое поле
    /// </summary>
    public partial class PageReadersEdit : Page
    {
        bool _edit;
        private Readers _currentReaders = new Readers();
        public PageReadersEdit(Readers selectedReaders, bool edit)
        {
            InitializeComponent();
            _edit = edit;
            if (selectedReaders != null)
            {
                Reader_Password.IsEnabled = false;
                _currentReaders = selectedReaders;
            }
            DataContext = _currentReaders;
        }
        private void Button_Click_Save(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentReaders.Surname))
                errors.AppendLine("Пустое поле фамилии читателя!");
            if (string.IsNullOrWhiteSpace(_currentReaders.Name))
                errors.AppendLine("Пустое поле имени читателя!");
            if (string.IsNullOrWhiteSpace(_currentReaders.Reader_Password))
                errors.AppendLine("Пустое поле пароля читателя!");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            try
            {
                if (!_edit)
                {
                    Manager.GetContext().Readers.Add(_currentReaders);
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
