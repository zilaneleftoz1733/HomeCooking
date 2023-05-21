<%@ Page Title="Order Panel" Async="true" AutoEventWireup="true" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="false" CodeBehind="OrderPage.aspx.cs" Inherits="HomeCookingWebPanel.OrderPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
        <input type="hidden" id="group" />
        <div class="page-header">
            <h1 class="title">Order Page</h1>
            <ol class="breadcrumb">
                <li class="active">You can see your customers orders on this page.</li>
            </ol>
        </div>
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server"></asp:ScriptManager>
        <div class="container-fluid padding-b-35" style="min-height:600px">
                     <div class="panel-body margin-5 text-right">
                     <label class="control-label form-label">Status:</label>
                     <asp:DropDownList CssClass="btn btn-secondary dropdown-toggle" Font-Size="Smaller" ID="Ddl_FilterStatus" runat="server"></asp:DropDownList>
                     <label class="control-label form-label">Date:</label>
                    <asp:TextBox ID="Txt_FilterDate" Width="110px" Height="28px" Font-Size="Smaller" BackColor="#e3e5e4" AutoCompleteType="Disabled" ReadOnly="false" runat="server" TextMode="Date"></asp:TextBox>
                     <asp:LinkButton Font-Size="Smaller" OnClick="Btn_Reset_Click" Height="30px" BackColor="#cf2627" BorderColor="#353435" BorderWidth="1" runat="server" ID="Btn_Reset" CssClass="btn btn-success"><i class="fa fa-refresh"></i>Reset</asp:LinkButton>
                     <asp:LinkButton OnClick="BtnFilter_Click" Font-Size="Smaller" Height="30px" BackColor="#cf2627" BorderColor="#353435" BorderWidth="1" runat="server" ID="BtnFilter" CssClass="btn btn-success"><i class="fa fa-filter"></i>Filter</asp:LinkButton><br />
                </div>
            <div class="panel-body margin-5">
                <asp:Label ID="Lbl_Comment" runat="server" Text=""></asp:Label>
            </div>
                <asp:GridView RowHeaderColumn="5px" BorderColor="#cf2627" OnRowCommand="OrderGrid_RowCommand" BorderWidth="2px" HeaderStyle-BackColor="Window" OnRowCreated="OrderGrid_RowCreated" ID="OrderGrid" DataKeyNames="ID" CssClass="table table-bordered col-md-12" runat="server" EnablePersistedSelection="True">
                    <RowStyle Font-Size="Small" Height="30px"/>
                     <alternatingrowstyle  Height="30px"/>
                    <Columns>
               <asp:TemplateField HeaderText="Transactions">
            <ItemTemplate>
                <asp:Button CommandArgument="<%# Container.DataItemIndex %>" Font-Size="Smaller" Height="30px" BackColor="#cf2627" BorderWidth="1px" BorderColor="#353435" ControlStyle-CssClass="btn btn-info" Text="Select" runat="server" CommandName="Select"/>
            </ItemTemplate>
        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle BackColor="#FFFFCC" />
                    </asp:GridView>
                </div>
                   <asp:UpdatePanel ID="UP_EditOrder" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="editOrder" runat="server" ClientIDMode="Static" class="modal fade" TabIndex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" style="background-color:#FF7622" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                        <h3 style="text-align:center; color:#cf2627">Order <span style="color:#353435">Edit</span></h3>
                                        </div>
                                     <form method="post" action="OrderPage.aspx">
                                        <div class="modal-body form-horizontal">
                                              <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Orderer:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditOrderer" AutoCompleteType="Disabled" ReadOnly="true" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                                </div>
                                                                                          <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Address:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditAddress" AutoCompleteType="Disabled" ReadOnly="true" class="form-control" TextMode="MultiLine" Rows="3" runat="server" ></asp:TextBox>
                                                </div>
                                                </div>
                                                                                          <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Order Date:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditOrderDate" AutoCompleteType="Disabled" ReadOnly="true" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                                </div>
                                                                                          <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Order Content:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditOrderContent" AutoCompleteType="Disabled" TextMode="MultiLine" Rows="3" ReadOnly="true" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                                </div>
                                                                                          <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Order Price:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditOrderPrice" AutoCompleteType="Disabled" ReadOnly="true" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                                </div>
                                                                                                                                      <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Order Statu:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:DropDownList ID="Dd_EditOrderStatu" CssClass="form-control" runat="server"></asp:DropDownList>
                                                </div>
                                                </div>
                                            </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                                            <asp:Button ID="Btn_Edit" OnClick="Btn_Edit_Click" BackColor="#cf2627" CssClass="btn btn-default" runat="server" Text="Save"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </asp:Panel>     
                    </ContentTemplate>
                    <Triggers>
                         <asp:PostBackTrigger ControlID="Btn_Edit" />
                        <asp:AsyncPostBackTrigger ControlID="OrderGrid" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            <div style="position:fixed; left:0; bottom:0; background-color:#3D464D; width:99%">
            <div style="color:aliceblue; font-size:smaller" class="text-right">
        Copyright © 2023 <a style="color:#FF7622" href="#" target="_blank">Home Cooking</a> All rights reserved.
            </div>
        </div>
    </div>
         <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script type="text/javascript">
            function showEdit() {
                $("#editOrder").modal("show");
            };
        </script>  
</asp:Content>
