using System;
using System.Collections.Generic;
using Google.Cloud.Firestore; 

namespace HomeCookingWebPanel.Model
{
    [FirestoreData]
    public class UserModel
    {
        [FirestoreProperty]
        public string userName { get; set; }

    }
}