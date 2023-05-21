<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HomeCookingWebPanel.Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <link rel="shortcut icon" href="#" type="image/x-icon">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="SincApp Web Panel Giriş Sayfası">
    <meta name="keywords" content="login,page,personel,bilgi,sistemi" />
    <title>Home Cooking Login Panel</title>
    <link href="css/root.css" rel="stylesheet">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body style="background: linear-gradient(to right, #353435, #cf2627, #353435);">
    <div class="login-form">
        <form runat="server" method="post">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server"></asp:Panel>
            <div class="top">
             <img src="img/homecooking-logo.png" alt="icon" height="180">
                <div display: flex;>
                <h1 style="color:#353435">Web <span style="color:#cf2627">Panel</span></h1>
                </div>
            </div>
            <div class="form-area">
                <div class="group">
                    <asp:TextBox CssClass="form-control" placeholder="E-Mail" ID="Txt_Email" runat="server">
            </asp:TextBox>
                    <i class="fa fa-user"></i>
                </div>
                <div class="group">
                    <asp:TextBox CssClass="form-control" type="password" placeholder="Password" ID="Txt_Password" runat="server">
            </asp:TextBox>
                    <i class="fa fa-key"></i>
                </div>
                <asp:Button BackColor="#cf2627" OnClick="LoginButton_Click" CssClass="btn btn-default btn-block" ID="BtnLogin" runat="server" Text="Login"/>
                <asp:Label ID="Lbl_Login" runat="server" Visible="True"></asp:Label>
                <asp:LinkButton CssClass="pull-right margin-t-5" ID="LinkButton1" ForeColor="#cf2627" runat="server">Forgot password</asp:LinkButton>
            </div>
        </form>
    </div>
</body>
</html>
       
