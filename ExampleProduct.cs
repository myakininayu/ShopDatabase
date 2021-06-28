using System;
using System.Collections.Generic;
using System.Text;

namespace DbShopCore.Entities
{
    public class ExampleProduct
    {
        public ExampleProduct()
        {
        }

        public ExampleProduct(string size, string color, uint amount, string storageAddr)
        {
            StorageAddr = storageAddr;
            Size = size;
            Color = color;
            Amount = amount;
        }

        public ExampleProduct(uint vendorCode, string size, string color, uint amount, string storageAddr)
        {
            StorageAddr = storageAddr;
            Size = size;
            Color = color;
            Amount = amount;
            VendorCode = vendorCode;
        }

        public uint IdExample_product { get; set; }
        public string StorageAddr { get; set; }

        public string Size { get; set; }

        public string Color { get; set; }

        public uint Amount { get; set; }

        public uint VendorCode { get; set; }

       
    }
}
