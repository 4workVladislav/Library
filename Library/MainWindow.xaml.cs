using System;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Navigation;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            RegisterFrame.NavigationUIVisibility = NavigationUIVisibility.Hidden;
            Manager.mainWindow = this;
            Manager.RegisterFrame = RegisterFrame;
        }
        //кнопка авторизации
        private void Button_Click_Autorization(object sender, RoutedEventArgs e)
        {
            if(TB_Login.Text == null || TB_Pass.Password == null)
            {
                MessageBox.Show("Заполните поля!");
            }
            else
            {
                //процесс расшифровки хэшированного пароля
                var crypt = System.Security.Cryptography.SHA256.Create();
                var notfinal = crypt.ComputeHash(Encoding.UTF8.GetBytes(TB_Pass.Password));
                var final = Convert.ToBase64String(notfinal);
                Readers user = Manager.GetContext().Readers.FirstOrDefault(p => p.Reader_Login == TB_Login.Text && (p.Reader_Password.ToString() ==
                final));
                //если есть пользователь имеет флаг администратора, то открывается специальное меню
                if (user != null)
                {
                    if(user.Admin == true)
                    {
                        AdminMenu windadmin = new AdminMenu();
                        windadmin.Show();
                        Close();
                    }
                    else { 
                    Manager.Login = user.Reader_Login;
                    UserMenu wind = new UserMenu();
                    wind.Show();
                    Close();
                    }
                }
            }
        }
        //кнопка регистрации
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            GridMain.Visibility = Visibility.Collapsed;
            RegisterFrame.Navigate(new PageRegistration());
        }
        //метод отображения формы регистрации
        public void VisibleMain()
        {
            RegisterFrame.Content = null;
            GridMain.Visibility = Visibility.Visible;
        }
    }
}
