using Firebase.Auth;
using HomeCookingWebPanel.Model;
using System;
using System.Web.UI;

namespace HomeCookingWebPanel
{
    public partial class Login : System.Web.UI.Page
    {
        private const string API_KEY = "AIzaSyDnJpPnzSKUkng6EBCamRu0cH-Ij2azGEk";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void LoginButton_Click(object sender, EventArgs e)
        {
            string email = Txt_Email.Text;
            string password = Txt_Password.Text;
            try
            {
                var authProvider = new FirebaseAuthProvider(new FirebaseConfig(API_KEY));
                var auth = await authProvider.SignInWithEmailAndPasswordAsync(email, password);

                // Kullanıcı girişi başarılı ise;
                if (auth != null && !string.IsNullOrEmpty(auth.FirebaseToken))
                {
                    Data.Instance.UserInfo = auth.User.Email;
                    Response.Redirect("OrderPage.aspx");
                }
                else
                {
                    //Kullanıcı girişi başarısız ise;
                    string script = "swal({title: 'Login failed. Please check your email and password!', icon: 'error', button: 'OK'});";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                }
            }
            catch (FirebaseAuthException ex)
            {
                //Herhangi bir sebeple bağlantı kurulamadı ise;
                string script = "swal({title: '" + "Error: " + ex.HResult.ToString() + "', icon: 'error', button: 'OK'});";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }
    }
}