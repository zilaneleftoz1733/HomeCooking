using System;
using System.Collections.Generic;
using Google.Cloud.Firestore; 

namespace HomeCookingWebPanel.Model
{
    [FirestoreData]
    public class FoodCategoryModel
    {
        [FirestoreProperty]
        public List<string> foodCategories { get; set; }
    }
}