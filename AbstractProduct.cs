using System;
using System.Collections.Generic;
using System.Text;

namespace DbShopCore.Entities
{
    public class AbstractProduct
    {
        public uint VendorCode { get; }

        public string Department { get; set; }
        public string Category { get; set; }
        public string Model { get; set; }
        public uint Price { get; set; }
        public float Rating { get; set; }
        public string Material { get; set; }

        public string Brand { get; set; }

     

        public AbstractProduct()
        {
            Department = "";
            Category = "";
            Model = "";
            Price = 0;
            Rating = 0;
            Material = "";
            Brand = "";
        }

        public AbstractProduct(string department, string category, string model, uint price, float rating, string material, string brand)
        {
            Department = department;
            Category = category;
            Model = model;
            Price = price;
            Rating = rating;
            Material = material;
            Brand = brand;
        }
    }
}