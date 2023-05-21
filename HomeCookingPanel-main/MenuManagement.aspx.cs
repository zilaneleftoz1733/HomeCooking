using Google.Cloud.Firestore;
using Google.Cloud.Storage.V1;
using HomeCookingWebPanel.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace HomeCookingWebPanel
{
    public partial class MenuManagement : System.Web.UI.Page
    {
        FirestoreDb database;
        readonly Islem islem = new Islem();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Menu Yonetim sayfası yüklendiğinde;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"firestore.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            database = FirestoreDb.Create("project-management-22705");
            if (!IsPostBack)
            {
                _ = FillDropDownAsync();
                FetchMenus();
            }
        }

        async Task FillDropDownAsync()
        {
            //Dropdown alanlarının doldurulması için;
            Query Qref = database.Collection("categories");
            QuerySnapshot snap = await Qref.GetSnapshotAsync();
            foreach (DocumentSnapshot docsnap in snap)
            {
                FoodCategoryModel foodCategory = docsnap.ConvertTo<FoodCategoryModel>();
                if (docsnap.Exists)
                {
                    for (int i=0; i < foodCategory.foodCategories.Count; i++)
                    {
                        Ddl_FilterCategory.Items.Add(foodCategory.foodCategories[i]);
                        Cbl_Category.Items.Add(foodCategory.foodCategories[i]);
                        Cbl_EditCategory.Items.Add(foodCategory.foodCategories[i]);
                    }    
                }
            }
        }

        async void FetchMenus()
        {
            //Menülerin çekilerek tablo haline getirilmesi;
            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("Name");
            table.Columns.Add("Category");
            table.Columns.Add("Price");
            table.Columns.Add("Menu Content");
            table.Columns.Add("Rating");
            table.Columns.Add("Preparation Time");
            table.Columns.Add("Creation Date");

            //Haberler koleksiyonu ile bağlantı kuruyoruz.
            Query Qref = database.Collection("recipes").OrderByDescending("creationDate");
            QuerySnapshot snap = await Qref.GetSnapshotAsync();
            foreach (DocumentSnapshot docsnap in snap)
            {
                FoodsModel foods = docsnap.ConvertTo<FoodsModel>();
                if (docsnap.Exists)
                {
                        Data.Instance.CombinedContent = string.Join(", ", foods.malzemeler);
                        Data.Instance.CombinedCategory = string.Join(", ", foods.urunTipi);
                        table.Rows.Add(
                        docsnap.Id,
                        foods.urunAdi,
                        Data.Instance.CombinedCategory,
                        foods.urunPrice + " TL",
                        Data.Instance.CombinedContent,
                        foods.urunPuani,
                        foods.hazirlamaSuresi + " Minute",
                        foods.creationDate.AddHours(3).ToString());
                }
            }
            MenuGrid.DataSource = table;
            MenuGrid.DataBind();
            if (MenuGrid.Rows.Count > 0)

                Lbl_Comment.Text = "You can change your menus with the <span style='font-weight: bold;'>Select</span> button.";
            else
                Lbl_Comment.Text = "No menu found to display. You can add new menu.";
        }

        protected void Btn_Reset_Click(object sender, EventArgs e)
        {
            //Sayfa yenilenmesi;
            Response.Redirect(Request.RawUrl);
        }

        protected void BtnFilter_Click(object sender, EventArgs e)
        {
             FetchMenusFilter();
        }

        async void FetchMenusFilter()
        {
            //Menüleri filtrelemek için kullanılır.
            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("Name");
            table.Columns.Add("Category");
            table.Columns.Add("Price");
            table.Columns.Add("Menu Content");
            table.Columns.Add("Rating");
            table.Columns.Add("Preparation Time");
            table.Columns.Add("Creation Date");

            //Haberler koleksiyonu ile bağlantı kuruyoruz.
            Query Qref = database.Collection("recipes").OrderByDescending("creationDate");
            QuerySnapshot snap = await Qref.GetSnapshotAsync();
            foreach (DocumentSnapshot docsnap in snap)
            {
                FoodsModel foods = docsnap.ConvertTo<FoodsModel>();
                if (docsnap.Exists)
                {
                    for (int i=0;i<foods.urunTipi.Count;i++)
                    {
                        if(Ddl_FilterCategory.SelectedValue == foods.urunTipi[i])
                        {
                            Data.Instance.CombinedContent = string.Join(", ", foods.malzemeler);
                            Data.Instance.CombinedCategory = string.Join(", ", foods.urunTipi);
                            table.Rows.Add(
                            docsnap.Id,
                            foods.urunAdi,
                            Data.Instance.CombinedCategory,
                            foods.urunPrice + " TL",
                            Data.Instance.CombinedContent,
                            foods.urunPuani,
                            foods.hazirlamaSuresi + " Minute",
                            foods.creationDate.AddHours(3).ToString());
                        }
                    }
                }
            }
            MenuGrid.DataSource = table;
            MenuGrid.DataBind();
            if (MenuGrid.Rows.Count > 0)

                Lbl_Comment.Text = "You can change your menus with the <span style='font-weight: bold;'>Select</span> button.";
            else
                Lbl_Comment.Text = "No menu found to display. You can add new menu.";
        }

        protected void Btn_Edit_Click(object sender, EventArgs e)
        {
            //Menü üzerinde yapılan değişikliklerin sisteme kayıt edilmesi için kullanılır.
            if (Txt_EditContent.Text == "" || Txt_EditMenuName.Text == "" || Txt_EditPreparation.Text=="" || Txt_EditPrice.Text =="" || Txt_EditRaiting.Text =="")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'Please fill in the blanks!', icon: 'error', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
            }
            else
            {
                string ImageURL = Image1.ImageUrl;
                if (fileUploadEdit.HasFile)
                {
                    var fileName = System.IO.Path.GetExtension(fileUpload.FileName);
                    if (IsImageFile(fileName))
                    {
                        fileName = fileUploadEdit.FileName;
                        var contentType = fileUploadEdit.PostedFile.ContentType;
                        var fileStream = fileUploadEdit.PostedFile.InputStream;
                        ImageURL = AddMenuPic(fileName, contentType, fileStream);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'The file you uploaded does not look like an image. Please upload pictures!', icon: 'error', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
                    }
                }
                EditIslem(ImageURL);
            }
        }
        async void EditIslem(string EditImageURL)
        {
            string multilineText = Txt_EditContent.Text;
            string[] lines = multilineText.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            ArrayList MenuContent = new ArrayList();
            foreach (string line in lines)
            { MenuContent.Add(line); }
            ArrayList selectedItems = new ArrayList();
            foreach (ListItem item in Cbl_EditCategory.Items)
            {
                if (item.Selected)
                { selectedItems.Add(item.Value); }
            }
            DocumentReference docref = database.Collection("recipes").Document(Data.Instance.MenuProcess);
            Dictionary<string, object> data = new Dictionary<string, object>()
            {
                {"hazirlamaSuresi",Txt_EditPreparation.Text},
                {"urunAdi", Txt_EditMenuName.Text},
                {"urunGorseli",EditImageURL },
                {"urunPrice",Txt_EditPrice.Text},
                {"urunPuani",Txt_EditRaiting.Text }
            };
            DocumentSnapshot snap = await docref.GetSnapshotAsync();
            data.Add("malzemeler", MenuContent);
            data.Add("urunTipi", selectedItems);
            data.Add("urunAdiArray", TextSplit(Txt_EditMenuName.Text));
            if (snap.Exists)
            { await docref.UpdateAsync(data); }
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'Changes made to the menu are saved.', icon: 'success', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
        }

        protected void MenuGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = MenuGrid.Rows[rowIndex];
            if (e.CommandName == "Select")
            {
                Txt_EditContent.Text = "";
                foreach (ListItem item in Cbl_EditCategory.Items)
                {
                    item.Selected = false;
                }
                Data.Instance.MenuProcess = row.Cells[0].Text;
                ShowEditPage();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "showEdit();", true);
            }
        }
        async void ShowEditPage()
        {
            DocumentReference docref = database.Collection("recipes").Document(Data.Instance.MenuProcess);
            DocumentSnapshot snap = await docref.GetSnapshotAsync();
            FoodsModel food = snap.ConvertTo<FoodsModel>();
            Txt_EditMenuName.Text = food.urunAdi;
            Txt_EditPreparation.Text = food.hazirlamaSuresi;
            Txt_EditPrice.Text = food.urunPrice;
            Txt_EditRaiting.Text = food.urunPuani;
            Image1.ImageUrl = food.urunGorseli;
            foreach (var veri in food.malzemeler)
            {
                Txt_EditContent.Text += veri + Environment.NewLine;
            }
            foreach (ListItem checkboxItem in Cbl_EditCategory.Items)
            {
                if (food.urunTipi.Contains(checkboxItem.Value))
                {
                    checkboxItem.Selected = true;
                }
            }
        }

        protected void MenuGridGrid_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow row = e.Row;
            TableCell processRow = row.Cells[0];
            TableCell idrow = row.Cells[1];
            idrow.Visible = false;
            row.Cells.Remove(processRow);
            row.Cells.Add(processRow);
        }

        protected void BtnNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "newMenu();", true);
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            //Yeni menü eklemek için kullanılır.
            if (Txt_NewMenuName.Text == "" || Txt_NewMenuContent.Text == "" || Txt_NewMenuPrice.Text==""|| Txt_NewMenuRaiting.Text=="" || Txt_NewPerparationTime.Text==""||fileUpload.HasFile == false)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'Please fill in all fields!', icon: 'error', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
            }
            else
            {
                if (fileUpload.HasFile)
                {
                    var fileName = System.IO.Path.GetExtension(fileUpload.FileName);
                    if (IsImageFile(fileName))
                    {
                        string ImageURL;
                        fileName = fileUpload.FileName;
                        var contentType = fileUpload.PostedFile.ContentType;
                        var fileStream = fileUpload.PostedFile.InputStream;
                        ImageURL = AddMenuPic(fileName, contentType, fileStream);
                        MenuEkle(ImageURL);
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'Adding new menu successful.', icon: 'success', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'The file you uploaded does not look like an image. Please upload pictures!', icon: 'error', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
                    }
                }

            }
        }
        private string AddMenuPic(string fileName, string contentType, Stream fileStream)
        {
            //Resim eklemek için kullanılır.
            // StorageClient oluşturuluyor
            var storage = StorageClient.Create();

            // Dosyanın yükleneceği bucketName ve objectName oluşturuluyor
            var bucketName = "project-management-22705.appspot.com";
            var objectName = "Menu Picture/" + fileName;

            // Yeni bir Object oluşturuluyor
            var newObject = new Google.Apis.Storage.v1.Data.Object()
            {
                Bucket = bucketName,
                Name = objectName,
                ContentType = contentType,
                Metadata = new Dictionary<string, string>()
            {
            // Firebase Storage download URL'sini oluşturmak için gerekli olan token'ı ekleyin
            { "firebaseStorageDownloadTokens", Guid.NewGuid().ToString() }
            }
            };

            // Dosya yükleniyor
            storage.UploadObject(bucketName, objectName, contentType, fileStream);

            // Download URL'si oluşturuluyor
            string url = $"https://firebasestorage.googleapis.com/v0/b/{bucketName}/o/{Uri.EscapeDataString(objectName)}?alt=media&token={newObject.Metadata["firebaseStorageDownloadTokens"]}";
            return url;
        }
        private bool IsImageFile(string fileExtension)
        {
            //Yüklenen resmin formatı için kontrol etmek;
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            return allowedExtensions.Contains(fileExtension.ToLower());
        }
        void MenuEkle(string ImageURL)
        {
            //Yeni menü eklemek için kullanılır.
            string multilineText = Txt_NewMenuContent.Text;
            string[] lines = multilineText.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            ArrayList MenuContent = new ArrayList();
            foreach (string line in lines)
            {MenuContent.Add(line);}
            ArrayList selectedItems = new ArrayList();

            foreach (ListItem item in Cbl_Category.Items)
            {
                if (item.Selected)
                {
                    selectedItems.Add(item.Value);
                }
            }
            DocumentReference DOC = database.Collection("recipes").Document(islem.EpochNumber().ToString());
            Dictionary<string, object> data = new Dictionary<string, object>()
            {
                {"creationDate", islem.TarihCevir(DateTime.UtcNow)},
                {"hazirlamaSuresi",Txt_NewPerparationTime.Text},
                {"urunAdi", Txt_NewMenuName.Text},
                {"urunGorseli",ImageURL },
                {"urunPrice",Txt_NewMenuPrice.Text},
                {"urunPuani",Txt_NewMenuRaiting.Text }
            };
            data.Add("malzemeler", MenuContent);
            data.Add("urunTipi", selectedItems);
            data.Add("urunAdiArray", TextSplit(Txt_NewMenuName.Text));
            DOC.SetAsync(data);
        }
        ArrayList TextSplit(string str)
        {
            str = str.ToLower();
            ArrayList kombinasyonlar = new ArrayList();
            string[] kelimeler = str.Split(' ');
            foreach (string kelime in kelimeler)
            {
                for (int i = 0; i < kelime.Length; i++)
                {
                    if (kelime[i] == kelime[0])
                    {
                        for (int j = i + 1; j <= kelime.Length; j++)
                        {
                            kombinasyonlar.Add(kelime.Substring(i, j - i));
                        }
                    }
                }
            }
            return kombinasyonlar;
        }

        protected void Btn_Delete_Click(object sender, EventArgs e)
        {
            //Menü silinmesi için kullanılır.
            DocumentReference docref = database.Collection("recipes").Document(Data.Instance.MenuProcess);
            docref.DeleteAsync();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'The menu has been removed!', icon: 'success', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
        }
    }
}