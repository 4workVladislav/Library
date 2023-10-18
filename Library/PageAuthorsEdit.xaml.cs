using System;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageAuthorsEdit.xaml
    /// </summary>
    public partial class PageAuthorsEdit : Page
    {
        bool _edit;
        private Authors _currentAuthors = new Authors(); 
        //в случае редактирования не позволяем трогать поле ID
        public PageAuthorsEdit(Authors selectedAuthors, bool edit)
        {
            InitializeComponent();
            _edit = edit;
            if (selectedAuthors != null)
            {
                TB_ID_Author.IsEnabled = false;
               _currentAuthors = selectedAuthors;
            }
            DataContext = _currentAuthors;
        }
        //кнопка сохранения с проверками на заполненность полей
        private void Button_Click_Save(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentAuthors.Au_Surname))
                errors.AppendLine("Пустое поле фамилии автора!");
            //если есть ошибки то отменяем сохранение
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            //задаём логику сохранения при добавлении и сохраненни изменения при редактировании с помощью 
            //булевской переменной
            try
            {
                if (!_edit)
                {
                    Manager.GetContext().Authors.Add(_currentAuthors);
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
