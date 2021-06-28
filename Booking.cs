using System;
using System.Collections.Generic;
using System.Text;

using System.Data;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace DbShopCore.Entities
{
    public enum PayMethod
    {
        cash = 1,
        card
    }

    public class Booking
    {
        public string IdBooking { set; get; }
        public string Date { set; get; }

        public PayMethod PayingMethod { set; get; }

        public string EmployeeName { set; get; }

        public string ClientName { set; get; }

        public string ProductsPrice { set; get; }

        public string DeliveryPrice { set; get; }
        public string TotalPrice { set; get; }
        public Booking(string idBooking, string date, PayMethod payingMethod, string employeeName, string clientName)
        {
            IdBooking = idBooking;
            Date = date;
            PayingMethod = payingMethod;
            EmployeeName = employeeName;
            ClientName = clientName;
        }

        public Booking(string date, PayMethod payingMethod, string employeeName, string clientName)
        {
            Date = date;
            PayingMethod = payingMethod;
            EmployeeName = employeeName;
            ClientName = clientName;
        }

        public Booking()
        {
            Date = "2021.01.01";
            PayingMethod = (PayMethod)1;
            EmployeeName = "";
            ClientName = "";
        }

    }
}
