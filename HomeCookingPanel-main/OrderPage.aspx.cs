using Google.Cloud.Firestore;
using HomeCookingWebPanel.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace HomeCookingWebPanel
{
    public partial class OrderPage : System.Web.UI.Page
    {
        FirestoreDb database;
        protected void Page_Load(object sender, EventArgs e)
        {
            //OrderPage sayfası yüklendiğinde;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"firestore.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            database = FirestoreDb.Create("project-management-22705");
            if (!IsPostBack)
            {
                FillDropDown(); //Dropdown alanlarının doldurulması için kullanılır.
                FetchOrders(); //Siparişlerin getirilmesi için kullanılır.
            }
        }
        void FillDropDown()
        {
            //Dropdown alanları doldurulur.
            Ddl_FilterStatus.Items.Add("Preparing");
            Ddl_FilterStatus.Items.Add("On Delivery");
            Ddl_FilterStatus.Items.Add("Completed");
            Dd_EditOrderStatu.Items.Add("Preparing");
            Dd_EditOrderStatu.Items.Add("On Delivery");
            Dd_EditOrderStatu.Items.Add("Completed");
        }

        async void FetchOrders()
        {
            //Firebase ile bağlantı kurup siparişleri çekiyoruz.
            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("Orderer");
            table.Columns.Add("Address");
            table.Columns.Add("Order Date");
            table.Columns.Add("Order Content");
            table.Columns.Add("Order Price");
            table.Columns.Add("Order Statu");

            //Haberler koleksiyonu ile bağlantı kuruyoruz.
            Query Qref = database.Collection("orders").OrderByDescending("orderDate");
            QuerySnapshot snap = await Qref.GetSnapshotAsync();
            foreach (DocumentSnapshot docsnap in snap)
            {
                OrderModel order = docsnap.ConvertTo<OrderModel>();
                if (docsnap.Exists)
                {
                    if(order.orderStatus != "Completed")
                    {
                        List<string> myOrders = new List<string>();
                        for (int i=0;i<order.orders.Count;i++)
                        {
                            DocumentReference docref = database.Collection("recipes").Document(order.orders[i]);
                            DocumentSnapshot snap1 = await docref.GetSnapshotAsync();
                            if (snap1.Exists)
                            {
                                FoodsModel food = snap1.ConvertTo<FoodsModel>();
                                myOrders.Add(food.urunAdi);
                            }
                        }
                        DocumentReference docref1 = database.Collection("users").Document(order.userID);
                        DocumentSnapshot snap2 = await docref1.GetSnapshotAsync();
                        if (snap2.Exists)
                        {
                            UserModel user = snap2.ConvertTo<UserModel>();
                            Data.Instance.OrdererBy = user.userName;
                        }
                        Data.Instance.CombinedOrder = string.Join(", ", myOrders);
                        table.Rows.Add(
                        docsnap.Id,
                        Data.Instance.OrdererBy,
                        order.userAdress,
                        order.orderDate.AddHours(3).ToString(),
                        Data.Instance.CombinedOrder,
                        order.orderPrice + " TL",
                        order.orderStatus);
                    }                 
                }
            }
            OrderGrid.DataSource = table;
            OrderGrid.DataBind();
            if (OrderGrid.Rows.Count > 0)
                Lbl_Comment.Text = "Only <span style='font-weight: bold;'>incomplete</span> orders are displayed. You can filter for other orders.";
            else
                Lbl_Comment.Text = "No order found to display.";
        }

        protected void Btn_Reset_Click(object sender, EventArgs e)
        {
            //Sayfa yenileme işlemi;
            Response.Redirect(Request.RawUrl);
        }

        protected void BtnFilter_Click(object sender, EventArgs e)
        {
            //Filtre yapmak için;
            if (Txt_FilterDate.Text == "")
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'You have not entered a date!', icon: 'error', button: 'OK'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
            else
                FetchOrdersFilter();
        }

        async void FetchOrdersFilter()
        {
            //Gelen veriler ile filtrele işlemi yapılır.
            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("Orderer");
            table.Columns.Add("Address");
            table.Columns.Add("Order Date");
            table.Columns.Add("Order Content");
            table.Columns.Add("Order Price");
            table.Columns.Add("Order Statu");

            //Haberler koleksiyonu ile bağlantı kuruyoruz.
            Query Qref = database.Collection("orders").OrderByDescending("orderDate");
            QuerySnapshot snap = await Qref.GetSnapshotAsync();
            foreach (DocumentSnapshot docsnap in snap)
            {
                OrderModel order = docsnap.ConvertTo<OrderModel>();
                if (docsnap.Exists)
                {
                    DateTime filterDate = Convert.ToDateTime(Txt_FilterDate.Text);
                    if (order.orderStatus == Ddl_FilterStatus.SelectedValue && order.orderDate.Year == filterDate.Year && order.orderDate.Month == filterDate.Month && order.orderDate.Day == filterDate.Day)
                    {
                        List<string> myOrders = new List<string>();
                        for (int i=0;i<order.orders.Count;i++)
                        {
                            DocumentReference docref = database.Collection("recipes").Document(order.orders[i]);
                            DocumentSnapshot snap1 = await docref.GetSnapshotAsync();
                            if (snap1.Exists)
                            {
                                FoodsModel food = snap1.ConvertTo<FoodsModel>();
                                myOrders.Add(food.urunAdi);
                            }
                        }
                        DocumentReference docref1 = database.Collection("users").Document(order.userID);
                        DocumentSnapshot snap2 = await docref1.GetSnapshotAsync();
                        if (snap2.Exists)
                        {
                            UserModel user = snap2.ConvertTo<UserModel>();
                            Data.Instance.OrdererBy = user.userName;
                        }
                        Data.Instance.CombinedOrder = string.Join(", ", myOrders);
                        table.Rows.Add(
                        docsnap.Id,
                        Data.Instance.OrdererBy,
                        order.userAdress,
                        order.orderDate.AddHours(3).ToString(),
                        Data.Instance.CombinedOrder,
                        order.orderPrice + " TL",
                        order.orderStatus);
                    }
                }
            }
            OrderGrid.DataSource = table;
            OrderGrid.DataBind();
            if (OrderGrid.Rows.Count > 0)
                Lbl_Comment.Text = "Only orders on <span style='font-weight: bold;'>" + Txt_FilterDate.Text + "</span> date and <span style='font-weight: bold;'>" + Ddl_FilterStatus.SelectedValue + "</span> status are displayed.";
            else
                Lbl_Comment.Text = "No order found to display.";
        }

        protected void Btn_Edit_Click(object sender, EventArgs e)
        {
            //Edit buton işlemi;
            EditIslem();
        }
        async void EditIslem()
        {
            //Yapılan edit işlemlerinin firebase'e kayıt edilmesi.
            DocumentReference docref = database.Collection("orders").Document(Data.Instance.OrderProcess);
            Dictionary<string, object> data = new Dictionary<string, object>()
            {
                {"orderStatus",Dd_EditOrderStatu.SelectedValue },
            };
            DocumentSnapshot snap = await docref.GetSnapshotAsync();
            if (snap.Exists)
            {
                await docref.UpdateAsync(data);
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "swal({title: 'Changes made to the order are saved.', icon: 'success', button: 'Tamam'}).then(function() {window.location.href = '" + Request.RawUrl + "';});", true);
        }

        protected void OrderGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = OrderGrid.Rows[rowIndex];
            if (e.CommandName == "Select")
            {
                Data.Instance.OrderProcess = row.Cells[0].Text;
                Data.Instance.CombinedOrder = row.Cells[4].Text;
                Data.Instance.OrdererBy = row.Cells[1].Text;
                ShowEditPage();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "showEdit();", true);
            }
        }
        async void ShowEditPage()
        {
            //İlgili siparişlerin edit sayfasında görüntülenmesi;
            DocumentReference docref = database.Collection("orders").Document(Data.Instance.OrderProcess);
            DocumentSnapshot snap = await docref.GetSnapshotAsync();
            OrderModel order = snap.ConvertTo<OrderModel>();
            Txt_EditOrderer.Text = Data.Instance.OrdererBy;
            Txt_EditOrderDate.Text = order.orderDate.AddHours(3).ToString();
            Txt_EditOrderContent.Text = Data.Instance.CombinedOrder;
            Txt_EditAddress.Text = order.userAdress;
            Txt_EditOrderPrice.Text = order.orderPrice;
            Dd_EditOrderStatu.SelectedValue = order.orderStatus;
        }

        protected void OrderGrid_RowCreated(object sender, GridViewRowEventArgs e)
        {
            GridViewRow row = e.Row;
            TableCell processRow = row.Cells[0];
            TableCell idrow = row.Cells[1];
            idrow.Visible = false;
            row.Cells.Remove(processRow);
            row.Cells.Add(processRow);
        }
    }
}