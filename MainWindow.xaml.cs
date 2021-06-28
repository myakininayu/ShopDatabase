using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;


using System.Data;

using MySql.Data;
using MySql.Data.MySqlClient;

using DbShopCore.Entities;


namespace db_shop_gui
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        public MainWindow()
        {
            InitializeComponent();
        }

        // Обработчик для выполнения аналитического запроса №14. Рассчитать стоимость заказа
        private void CalcQuery14(object sender, RoutedEventArgs e)
        {
            int IdBooking = int.Parse(BookingIDInput.Text);
            string[] BookingInfo = GetTotalBookingPrice(IdBooking);
            if (BookingInfo[0] != "")
            {
                Query14Res.Text = "Имя клиента: " + BookingInfo[0] + System.Environment.NewLine + "Дата: " + BookingInfo[1] + System.Environment.NewLine +
                    "Цена заказа: " + BookingInfo[2] + System.Environment.NewLine + "Цена доставки: " + BookingInfo[3] + System.Environment.NewLine + "Полная цена: " + BookingInfo[4];
            }
            else
            {
                Query14Res.Text = "В базе данных нет информации о заказе с заданным номером";
            }
        }

        // Обработчик для выполнения аналитического запроса №15. Вывести кол-во купленных товаров в заданной категории за заданный месяц
        private void CalcQuery15(object sender, RoutedEventArgs e)
        {
            int year = int.Parse(YearInput.Text);
            int month = MonthInput.SelectedIndex + 1;
            string category = CategoryCombo.Text;
            Query15Res.Text = NumOfBoughtProducts(category, year, month).ToString();
        }

        // Обработчик для выполнения аналитического запроса №16. Показать кол-во оформленных заказов за заданный месяц
        private void CalcQuery16(object sender, RoutedEventArgs e)
        {
            int year = int.Parse(YearInput.Text);
            int month = MonthInput.SelectedIndex + 1;
            string category = CategoryCombo.Text;
            Query16Res.Text = GetBookingsNumPerMonth(year, month).ToString();
        }

        // Обработчик для выполнения аналитического запроса №17. Показать средний чек заказа за заданный месяц
        private void CalcQuery17(object sender, RoutedEventArgs e)
        {
            int year = int.Parse(YearInput.Text);
            int month = MonthInput.SelectedIndex + 1;
            Query17Res.Text = GetAvgBookingPricePerMonth(year, month).ToString();
        }

        // Проверить заполнение поля "Номер заказа"
        private void CheckIdBooking(object sender, TextChangedEventArgs e)
        {
            string EmptyStr = "";
            if (EmptyStr != BookingIDInput.Text)
            {
                CalcBtn1.IsEnabled = true;
            }
            else
            {
                CalcBtn1.IsEnabled = false;
            }
        }

        // Проверить заполнение поля "Год"
        private void CheckYear(object sender, TextChangedEventArgs e)
        {
            string EmptyStr = "";
            if (EmptyStr != YearInput.Text)
            {
                CalcBtn2.IsEnabled = true;
                CalcBtn3.IsEnabled = true;
                CalcBtn4.IsEnabled = true;
            }
            else
            {
                CalcBtn2.IsEnabled = false;
                CalcBtn3.IsEnabled = false;
                CalcBtn4.IsEnabled = false;
            }
        }


        // Проверить заполнение поля "Артикул" для товара
        private void CheckVendorAbs(object sender, TextChangedEventArgs e)
        {
            string EmptyStr = "";
            if (EmptyStr != VCInputAbs.Text)
            {
                ReadBtn1.IsEnabled = true;
                UpdateBtn1.IsEnabled = true;
                DeleteBtn1.IsEnabled = true;
            }
            else
            {
                ReadBtn1.IsEnabled = false;
                UpdateBtn1.IsEnabled = false;
                DeleteBtn1.IsEnabled = false;
            }
        }

        // Проверить заполнение поля "Артикул" для экземпляров товара
        private void CheckVendorEx(object sender, TextChangedEventArgs e)
        {
            string EmptyStr = "";
            if (EmptyStr != VCInputEx.Text)
            {
                ReadBtn2.IsEnabled = true;
                UpdateBtn2.IsEnabled = true;
                DeleteBtn2.IsEnabled = true;
            }
            else
            {
                ReadBtn2.IsEnabled = false;
                UpdateBtn2.IsEnabled = false;
                DeleteBtn2.IsEnabled = false;  
            }
        }

        // Аналитический запрос №14. Рассчитать стоимость заказа
        public string[] GetTotalBookingPrice(int Id)
        {
            string[] BookingInfo = new string[5];
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";

            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT" +
                                        " c.name AS client_name," +
                                        " DATE(b.date_time) AS date," +
                                        " SUM(a.price * e_to_b.amount) AS booking_price," +
                                        " IF(d.price is null, 0, d.price) AS delivery_price," +
                                        " SUM(a.price * e_to_b.amount) +IF(d.price is null, 0, d.price) AS total_price" +
                                        " FROM bookings b" +
                                        " JOIN example_products_to_bookings e_to_b" +
                                        " ON b.id_booking = e_to_b.id_booking" +
                                        " JOIN example_products e" +
                                        " ON e_to_b.id_example_product = e.id_example_product" +
                                        " JOIN abstract_products a" +
                                        " ON a.vendor_code = e.vendor_code" +
                                        " JOIN clients c" +
                                        " ON b.id_client = c.id_client" +
                                        " LEFT JOIN deliveries d" +
                                        " ON b.id_booking = d.id_delivery" +
                                        " WHERE b.id_booking = @ID; ";

                command.Parameters.AddWithValue("ID", Id);

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (!reader.IsDBNull(0))
                    {
                        BookingInfo[0] = reader.GetString(0);
                        BookingInfo[1] = reader.GetString(1);
                        BookingInfo[2] = reader.GetUInt32(2).ToString();
                        BookingInfo[3] = reader.GetInt32(3).ToString();
                        BookingInfo[4] = reader.GetUInt32(4).ToString();
                    }
                    else
                    {
                        BookingInfo[0] = "";
                    }
                }

                reader.Close();
                command.Dispose();
                connection.Close();
                return BookingInfo;

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }


        // Аналитический запрос №15. Вывести кол-во купленных товаров в заданной категории за заданный месяц
        public int NumOfBoughtProducts(string Category, int Year, int MonthNum)
        {
            int ProductsNum = 0;
            string ChosenCategory = CategoryCombo.Text;
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";

            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT" +
                                        " SUM(e_to_b.amount) AS products_num" +
                                        " FROM bookings b" +
                                        " JOIN example_products_to_bookings e_to_b" +
                                        " ON b.id_booking = e_to_b.id_booking" +
                                        " JOIN example_products e" +
                                        " ON e_to_b.id_example_product = e.id_example_product" +
                                        " JOIN abstract_products a" +
                                        " ON a.vendor_code = e.vendor_code" +
                                        " WHERE YEAR(date_time) = @YearParam AND MONTH(date_time) = @MonthParam AND category = @CategoryParam;";

                command.Parameters.AddWithValue("YearParam", Year);
                command.Parameters.AddWithValue("MonthParam", MonthNum);
                command.Parameters.AddWithValue("CategoryParam", ChosenCategory);

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.IsDBNull(0))
                        ProductsNum = 0;
                    else
                        ProductsNum = reader.GetInt32(0);
                }

                reader.Close();
                command.Dispose();
                connection.Close();
                return ProductsNum;

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }

        // Аналитический запрос №16. Показать кол-во оформленных заказов за заданный месяц
        public int GetBookingsNumPerMonth(int Year, int MonthNum)
        {
            int BookingNum = 0;
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT " +
                                        " COUNT(*) AS bookings_num" +
                                       " FROM bookings" +
                                        " WHERE MONTH(date_time) = @MonthParam" +
                                        " AND YEAR(date_time) = @YearParam; ";

                command.Parameters.AddWithValue("YearParam", Year);
                command.Parameters.AddWithValue("MonthParam", MonthNum);

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.IsDBNull(0))
                        BookingNum = 0;
                    else
                        BookingNum = reader.GetInt32(0);
                }

                reader.Close();
                command.Dispose();
                connection.Close();
                return BookingNum;

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }


        // Аналитический запрос №17. Показать средний чек заказа за заданный месяц
        public float GetAvgBookingPricePerMonth(int Year, int MonthNum)
        {
            float AvgPrice = 0;
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT ROUND(AVG(overall_price), 0) AS avg_booking_price" +
                                        " FROM( SELECT" +
                                        " b.id_booking," +
                                        " b.date_time," +
                                        " SUM(a.price) AS overall_price" +
                                        " FROM bookings b" +
                                        " JOIN example_products_to_bookings e_to_b" +
                                        " ON b.id_booking = e_to_b.id_booking" +
                                        " JOIN example_products e" +
                                        " ON e_to_b.id_example_product = e.id_example_product" +
                                        " JOIN abstract_products a" +
                                        " ON a.vendor_code = e.vendor_code" +
                                        " GROUP BY b.id_booking) AS tmp_table" +
                                        " WHERE YEAR(date_time) = @YearParam AND MONTH(date_time)= @MonthParam; ";

                command.Parameters.AddWithValue("YearParam", Year);
                command.Parameters.AddWithValue("MonthParam", MonthNum);

                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.IsDBNull(0))
                        AvgPrice = 0;
                    else
                        AvgPrice = reader.GetInt32(0);
                }

                reader.Close();
                command.Dispose();
                connection.Close();
                return AvgPrice;

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }



        ExampleProduct[] GetALLExampleProducts(int VendorCode)
        {
            List<ExampleProduct> ExPrList = new List<ExampleProduct> { };
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT" +
                                        " e.size," +
                                        " e.color," +
                                        " e.amount," +
                                        " s.address" +
                                        " FROM example_products e" +
                                        " JOIN storages s" +
                                        " ON e.id_storage = s.id_storage" +
                                        " WHERE e.vendor_code = @VCParam;";

                command.Parameters.AddWithValue("VCParam", VendorCode);


                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.IsDBNull(0)) ;
                    else
                        ExPrList.Add(new ExampleProduct(reader.GetString(0), reader.GetString(1), reader.GetUInt32(2), reader.GetString(3)));
                }
                reader.Close();
                command.Dispose();
                connection.Close();
                return ExPrList.ToArray();

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }


        private void GetAllExampleProducts(object sender, RoutedEventArgs e)
        {
            int VendorCode = int.Parse(VCInputEx.Text);
            ExampleProduct[] allExPr = GetALLExampleProducts(VendorCode);

            if (allExPr.Length == 0)
            {
                ExPr.Text = "Нет товара с заданным артикулом";
            }
            else
            {
                ExPr.Text = "Размер: " + allExPr[0].Size + ", Цвет: " + allExPr[0].Color + ", Кол-во: " + allExPr[0].Amount + ", Адрес: " + allExPr[0].StorageAddr;
                for (int i = 1; i < allExPr.Length; i++)
                {
                    ExPr.Text += System.Environment.NewLine + "Размер: " + allExPr[i].Size + ", Цвет: " + allExPr[i].Color + ", Кол-во: " + allExPr[i].Amount + ", Адрес: " + allExPr[i].StorageAddr;
                }
            }
        }


        AbstractProduct GetAbstractProductById(int VendorCode)
        {
            List<AbstractProduct> AbsPrList = new List<AbstractProduct> { };
            AbsPrList.Add(new AbstractProduct());
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "SELECT" +
                                        " a.department," +
                                        " a.category," +
                                        " a.model," +
                                        " a.price," +
                                        " a.rating," +
                                        " a.material," +
                                        " b.`name`" +
                                        " FROM abstract_products a" +
                                        " JOIN brands b" +
                                        " ON a.id_brand = b.id_brand" +
                                        " WHERE a.vendor_code = @VCParam";

                command.Parameters.AddWithValue("VCParam", VendorCode);


                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (reader.IsDBNull(0)) ;
                    else
                    {
                        AbsPrList.RemoveAt(0);
                        AbsPrList.Add(new AbstractProduct(reader.GetString(0), reader.GetString(1), reader.GetString(2), reader.GetUInt32(3), reader.GetFloat(4), reader.GetString(5), reader.GetString(6)));
                    }
                }
                reader.Close();
                command.Dispose();
                connection.Close();
                return AbsPrList[0];

            }
            catch (MySqlException ex)
            {
                throw;
            }
        }


        private void GetAllAbstractProducts(object sender, RoutedEventArgs e)
        {
            int VendorCode = int.Parse(VCInputAbs.Text);
            AbstractProduct APr = GetAbstractProductById(VendorCode);

            if (APr.Category == "")
            {
                AbsPr.Text = "Нет товара с заданным артикулом";
            }
            else
            {
                AbsPr.Text = "Отдел: " + APr.Department + System.Environment.NewLine + "Категория: " + APr.Category + System.Environment.NewLine +
                 "Модель: " + APr.Model + System.Environment.NewLine + "Цена: " + APr.Price + System.Environment.NewLine + "Рейтинг: " + APr.Rating +
                 System.Environment.NewLine + "Бренд: " + APr.Brand;
            }
        }

        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        // Удаление экземпляра товара в GUI
        private void DeleteExampleProductGui(object sender, RoutedEventArgs e)
        {
            int VendorCode = int.Parse(VCInputEx.Text);
            DeleteExampleProduct(VendorCode);
        }

        // Удаление экземпляра товара в БД
        private void DeleteExampleProduct(int Id)
        {
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "DELETE" +
                                        " FROM example_products" +
                                        " WHERE vendor_code = @ID";

                command.Parameters.AddWithValue("ID", Id);


                command.ExecuteNonQuery();
                command.Dispose();
                connection.Close();
            }
            catch (MySqlException ex)
            {
                throw;
            }

        }

        // Удаление товара в GUI
        private void DeleteAbstractProductGui(object sender, RoutedEventArgs e)
        {
            int VendorCode = int.Parse(VCInputAbs.Text);
            DeleteAbstractProduct(VendorCode);
        }

        // Удаление товара в БД
        private void DeleteAbstractProduct(int Id)
        {
            string ConnectionString = "server=localhost;user=root;database=clothes_shop;port=3306;password=#OxMk18j921";
            try
            {
                var connection = new MySqlConnection(ConnectionString);
                connection.Open();

                var command = connection.CreateCommand();

                command.CommandText = "DELETE" +
                                        " FROM abstract_products" +
                                        " WHERE vendor_code = @ID";

                command.Parameters.AddWithValue("ID", Id);


                command.ExecuteNonQuery();
                command.Dispose();
                connection.Close();
            }
            catch (MySqlException ex)
            {
                throw;
            }

        }

        private void UpdateExampleProductGui(object sender, RoutedEventArgs e)
        {
            dataWork.Focus();
            Save.IsEnabled = true;
            vendor_code.IsEnabled = true;
            size.IsEnabled = true;
            color.IsEnabled = true;
            amount.IsEnabled = true;
            addr.IsEnabled = true;
        }

        private void UpdateAbstractProductGui(object sender, RoutedEventArgs e)
        {
            dataWork.Focus();
            Save.IsEnabled = true;
            department.IsEnabled = true;
            category.IsEnabled = true;
            model.IsEnabled = true;
            price.IsEnabled = true;
            rating.IsEnabled = true;
            material.IsEnabled = true;
            brand.IsEnabled = true;
        }

        private void CreateAbstractProductGui(object sender, RoutedEventArgs e)
        {
            dataWork.Focus();
            Save.IsEnabled = true;
            department.IsEnabled = true;
            category.IsEnabled = true;
            model.IsEnabled = true;
            price.IsEnabled = true;
            rating.IsEnabled = true;
            material.IsEnabled = true;
            brand.IsEnabled = true;

            //string d = department.Text;
            //string c = category.Text;
            //string md = model.Text;
            //int p = int.Parse(price.Text);
            //float r = float.Parse(rating.Text);
            //string mt = material.Text;
            //string b = brand.Text;
        }

        private void CreateExampleProductGui(object sender, RoutedEventArgs e)
        {
            dataWork.Focus();
            Save.IsEnabled = true;
            vendor_code.IsEnabled = true;
            size.IsEnabled = true;
            color.IsEnabled = true;
            amount.IsEnabled = true;
            addr.IsEnabled = true;

            
        }
    }
}
