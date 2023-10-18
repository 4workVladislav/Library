using System.Windows.Controls;

namespace Library
{
    //функция менеджера отвечает за переходы между страницами и хранит нужную системную информацию
    internal class Manager
    {
        private static LibraryEntities1 _context;
        public static Frame MainFrame { get; set; }
        public static Frame RegisterFrame { get; set; }
        public static string Login { get; set; }
        public static MainWindow mainWindow  { get; set; }
        public static LibraryEntities1 GetContext()
        {
            if (_context == null)
                _context = new LibraryEntities1();
            return _context;
        }
    }
}
