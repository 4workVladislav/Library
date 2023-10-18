using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для UserMenu.xaml
    /// </summary>
    public partial class UserMenu : Window
    {
        public UserMenu()
        {
            InitializeComponent();
            UpdateDisplay();
        }
        //метод конвертации изображения из байтового формата обратно в изображение по алгоритму Base64ToImage
        public BitmapImage Base64ToImage(string base64String)
        {
            byte[] binaryData = Convert.FromBase64String(base64String);
            BitmapImage bi = new BitmapImage();
            bi.BeginInit();
            bi.StreamSource = new MemoryStream(binaryData);
            bi.EndInit();
            return bi;
        }
        //метод обновления дисплея
        public void UpdateDisplay()
        {
            LibraryEntities1 model = new LibraryEntities1();
             List<Books> allBooks = model.Books.ToList();
            ComboBoxBooks.Items.Clear();
            Vzitie.Items.Clear();
            ListItebBookUI.Children.Clear();

            List<ItemBook> itemBooks = new List<ItemBook>();
            //сравниваем введённые значения в поле поиска с фамилией, именем и названием книги
            //поиск по всей таблицы
            foreach (var book in allBooks)
            {
                if(Poisk.Text!="")
                {
                    if(book.Name_Publication.ToLower().IndexOf(Poisk.Text.ToLower())==-1)
                    {
                        if(book.Authors.Au_Surname.ToLower().IndexOf(Poisk.Text.ToLower()) == -1)
                        {
                            if (book.Authors.Au_Name.ToLower().IndexOf(Poisk.Text.ToLower()) == -1)
                            {
                                continue;
                            }
                        }
                    }
                }
                var ext = model.Extradition.Where(w => w.ID_Publication == book.ID_Publication && w.Date_Return == null).Count();
                if (ext == 0)
                {
                    ComboBoxBooks.Items.Add($"{book.Name_Publication} ({book.Authors.Au_Surname} {book.Authors.Au_Name}) ");
                    //формирование кастомной каротчки книг
                    ItemBook ib = new ItemBook();
                    if (book.Image != null)
                    {
                        ib.ImageBook.Source = Base64ToImage(book.Image);
                    }
                    ib.NameBook.Text = book.Name_Publication;
                    ib.Authors.Text = book.Authors.Au_Surname+ " " +book.Authors.Au_Name;
                                        ib.id = book.ID_Publication;
                    ib.menu = this;
                    itemBooks.Add(ib);
                }
            }
            var extt = model.Extradition.Where(w => w.Login_Readers == Manager.Login && w.Date_Return==null).ToList();
            //вывод книг забраннированных пользователем
            foreach (var ex in extt)
            {
                Vzitie.Items.Add($"{ex.Books.Name_Publication} ({ex.Books.Authors.Au_Surname} {ex.Books.Authors.Au_Name})");
            }
            foreach (var it in itemBooks)
            {
                ListItebBookUI.Children.Add(it);
            }
        }
        //метод поиска обращается к методу обновления дисплея
        private void Poisk_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateDisplay();
        }
    }

}
