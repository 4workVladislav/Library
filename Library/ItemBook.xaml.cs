using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для ItemBook.xaml
    /// </summary>
    public partial class ItemBook : UserControl
    {
        public  int id = -1;
        public UserMenu menu;
        public ItemBook()
        {
            InitializeComponent();
        }
        //кнопка бронирования книги передаёт значение о издании читатели и времени взятие и возврата
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            LibraryEntities1 model = new LibraryEntities1();
            if (id != -1)
            {
                var modelBook = model.Books.Single(s => s.ID_Publication == id);
                Extradition extradition = new Extradition();
                extradition.ID_Publication = modelBook.ID_Publication;
                extradition.Login_Readers = Manager.Login;
                extradition.Date_Issue = DateTime.Now;
                extradition.Date_Delivery = DateTime.Now.AddMonths(1);
                model.Extradition.Add(extradition);
                model.SaveChanges();
                menu.UpdateDisplay();
            }
        }
    }
}
