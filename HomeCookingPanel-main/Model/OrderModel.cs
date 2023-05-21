using System;
using System.Collections.Generic;
using Google.Cloud.Firestore; 

namespace HomeCookingWebPanel.Model
{
    [FirestoreData]
    public class OrderModel
    {
        [FirestoreProperty]
        public string userID { get; set; }

        [FirestoreProperty]
        public List<string> orders { get; set; }

        [FirestoreProperty]
        public string userAdress { get; set; }

        [FirestoreProperty]
        public string orderStatus { get; set; }

        [FirestoreProperty]
        public string orderPrice { get; set; }

        [FirestoreProperty]
        public DateTime orderDate { get; set; }
    }
}