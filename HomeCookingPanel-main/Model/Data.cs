using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeCookingWebPanel.Model
{
    public class Data
    {
        static readonly Data instance;
        public static Data Instance { get { return Data.instance; } }
        static Data() { instance = new Data(); }

        //LoginPage

        public string UserInfoID;
        public string UserInfo { get { return UserInfoID; } set { UserInfoID = value; } }

        //OrderPage

        public string OrderProcessID, CombinedOrderID,OrdererByID;

        public string OrdererBy { get { return OrdererByID; } set { OrdererByID = value; } }
        public string OrderProcess { get { return OrderProcessID; } set { OrderProcessID = value; } }
        public string CombinedOrder { get { return CombinedOrderID; } set { CombinedOrderID = value; } }

        //FoodPage

        public string MenuProcessID, CombinedCategoryID, CombinedContentID;
        public string MenuProcess { get { return MenuProcessID; } set { MenuProcessID = value; } }
        public string CombinedCategory { get { return CombinedCategoryID; } set { CombinedCategoryID = value; } }
        public string CombinedContent { get { return CombinedContentID; } set { CombinedContentID = value; } }
    }
    public class Islem
    {
        public Timestamp TarihCevir(DateTime date)
        {
            Timestamp timestamp = Timestamp.FromDateTime(date);
            return timestamp;
        }
        public double EpochNumber()
        {
           DateTime epochStart = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
           TimeSpan timeSpan = DateTime.UtcNow - epochStart;
           double epochNumber = Math.Floor(timeSpan.TotalSeconds);
           return epochNumber;
        }

    }
}