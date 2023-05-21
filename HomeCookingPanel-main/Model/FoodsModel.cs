using System;
using System.Collections.Generic;
using Google.Cloud.Firestore; 

namespace HomeCookingWebPanel.Model
{
    [FirestoreData]
    public class FoodsModel
    {
        [FirestoreProperty]
        public string hazirlamaSuresi { get; set; }

        [FirestoreProperty]
        public List<string> malzemeler { get; set; }

        [FirestoreProperty]
        public string urunAdi { get; set; }

        [FirestoreProperty]
        public List<string> urunAdiArray { get; set; }

        [FirestoreProperty]
        public string urunGorseli { get; set; }

        [FirestoreProperty]
        public string urunPrice { get; set; }

        [FirestoreProperty]
        public string urunPuani { get; set; }

        [FirestoreProperty]
        public List<string> urunTipi { get; set; }

        [FirestoreProperty]
        public DateTime creationDate { get; set; }
    }
}