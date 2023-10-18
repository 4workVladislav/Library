using Microsoft.Win32;
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Library
{
    /// <summary>
    /// Логика взаимодействия для PageExtradition.xaml
    /// </summary>
    public partial class PageExtradition : Page
    {
        public PageExtradition()
        {
            InitializeComponent();
            DGridExtradition.ItemsSource = Manager.GetContext().Extradition.ToList();
        }
        //событие выбора поля для возможности выставления отметки о возврате книги
        private void DGridExtradition_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ButtonReturnBook.IsEnabled = false;
            var bb = (Extradition)DGridExtradition.SelectedItem;
            if(bb.Date_Return==null)
            {
                ButtonReturnBook.IsEnabled = true;
            }
        }
        //кнопка возврата книги выставляет сегодняшнюю дату
        private void ButtonReturnBook_Click(object sender, RoutedEventArgs e)
        {
            var bb = (Extradition)DGridExtradition.SelectedItem;
            bb.Date_Return = DateTime.Now;
            Manager.GetContext().SaveChanges();
            DGridExtradition.ItemsSource = Manager.GetContext().Extradition.ToList();
        }
        //кнопка выгрузки списка должников
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            var allDljniki = Manager.GetContext().Extradition.Where(w => w.Date_Return == null).ToList();
            string Text = "";
            //перебор всех полей таблицы Extradition
            foreach(var dljniki in allDljniki)
            {
                Text += $"{dljniki.ID_Extradition}\t{dljniki.Login_Readers}\t{dljniki.ID_Publication}\t{dljniki.Date_Issue}\t{dljniki.Date_Delivery}\n";
            }
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "Text files(*.txt)|*.txt";
            saveFileDialog.DefaultExt = "txt";
            saveFileDialog.AddExtension = true;
            if (saveFileDialog.ShowDialog() == false)
                return;
            string filename = saveFileDialog.FileName;
            // сохраняем текст в файл
            System.IO.File.WriteAllText(filename, Text);
            MessageBox.Show("Файл сохранен");

        }
        //удаление записей таблицы с проверкой на "дурака"
        private void Button_Click_Del(object sender, RoutedEventArgs e)
        {
            var delExtradition = DGridExtradition.SelectedItems.Cast<Extradition>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить {delExtradition.Count()} элементов?", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question)
                == MessageBoxResult.Yes)
            {
                try
                {
                    Manager.GetContext().Extradition.RemoveRange(delExtradition);
                    Manager.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены");
                    DGridExtradition.ItemsSource = Manager.GetContext().Books.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }
    }
}
