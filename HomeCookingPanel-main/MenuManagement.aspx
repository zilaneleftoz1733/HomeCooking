<%@ Page Title="Menu Management Panel" Async="true" AutoEventWireup="true" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="false" CodeBehind="MenuManagement.aspx.cs" Inherits="HomeCookingWebPanel.MenuManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
        <input type="hidden" id="group" />
        <div class="page-header">
            <h1 class="title">Menu Management Page</h1>
            <ol class="breadcrumb">
                <li class="active">You can add new menus and edit existing menus.</li>
            </ol>
                        <div class="right">
                <div class="btn-group" role="group" aria-label="...">
                    <asp:LinkButton BorderColor="#353435" OnClick="BtnNew_Click" BackColor="#cf2627" ForeColor="White" runat="server" ID="BtnNew" CssClass="btn btn-success"><i class="fa fa-plus-circle"></i> Add New Menu</asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server"></asp:ScriptManager>
        <div class="container-fluid padding-b-35" style="min-height:600px">
                     <div class="panel-body margin-5 text-right">
                     <label class="control-label form-label">Category:</label>
                     <asp:DropDownList CssClass="btn btn-secondary dropdown-toggle" Font-Size="Smaller" ID="Ddl_FilterCategory" runat="server"></asp:DropDownList>
                     <asp:LinkButton Font-Size="Smaller" OnClick="Btn_Reset_Click" Height="30px" BackColor="#cf2627" BorderColor="#353435" BorderWidth="1" runat="server" ID="Btn_Reset" CssClass="btn btn-success"><i class="fa fa-refresh"></i>Reset</asp:LinkButton>
                     <asp:LinkButton OnClick="BtnFilter_Click" Font-Size="Smaller" Height="30px" BackColor="#cf2627" BorderColor="#353435" BorderWidth="1" runat="server" ID="BtnFilter" CssClass="btn btn-success"><i class="fa fa-filter"></i>Filter</asp:LinkButton><br />
                </div>
            <div class="panel-body margin-5">
                <asp:Label ID="Lbl_Comment" runat="server" Text=""></asp:Label>
            </div>
                <asp:GridView RowHeaderColumn="5px" BorderColor="#cf2627" OnRowCommand="MenuGrid_RowCommand" BorderWidth="2px" HeaderStyle-BackColor="Window" OnRowCreated="MenuGridGrid_RowCreated" ID="MenuGrid" DataKeyNames="ID" CssClass="table table-bordered col-md-12" runat="server" EnablePersistedSelection="True">
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
                           <asp:UpdatePanel ID="UP_NewMenu" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="newMenu" runat="server" ClientIDMode="Static" class="modal fade" TabIndex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" style="background-color:#feab97" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                        <h3 style="text-align:center; color:#cf2627">Add <span style="color:#353435">New</span> Menu</h3>
                                        </div>
                                     <form method="post" action="MenuManagement.aspx">
                                        <div class="modal-body form-horizontal">
                                              <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Name:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_NewMenuName" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                               <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Preparation Time:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_NewPerparationTime" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" TextMode="Number" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                              <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Price:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_NewMenuPrice" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" TextMode="Number" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                            <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Raiting (Max 5):</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_NewMenuRaiting" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label form-label">Product Image:</label>
                                                <div class="col-sm-9">
                                                  <asp:FileUpload ID="fileUpload" runat="server" />
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Content:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_NewMenuContent" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" Rows="5" TextMode="MultiLine" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                               <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Category:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:CheckBoxList ID="Cbl_Category" CssClass="checkbox checkbox-inline" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                                </div>
                                          </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                                            <asp:Button ID="BtnAdd" OnClick="BtnAdd_Click" BackColor="#cf2627" CssClass="btn btn-default" runat="server" Text="Add"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </asp:Panel>     
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="BtnAdd" />
                        <asp:AsyncPostBackTrigger ControlID="BtnNew" EventName="click" />
                    </Triggers>
                </asp:UpdatePanel>
                   <asp:UpdatePanel ID="UP_EditMenu" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="editMenu" runat="server" ClientIDMode="Static" class="modal fade" TabIndex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" style="background-color:#FF7622" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                        <h3 style="text-align:center; color:#cf2627">Menu <span style="color:#353435">Edit</span></h3>
                                        </div>
                                     <form method="post" action="OrderPage.aspx">
                                        <div class="modal-body form-horizontal">
                                                <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Name:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditMenuName" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                               <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Preparation Time:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditPreparation" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" TextMode="Number" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                              <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Price:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditPrice" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" TextMode="Number" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                            <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Raiting (Max 5):</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditRaiting" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                             <div class="form-group">
                                                <label class="col-sm-3 control-label form-label">Product Image:</label>
                                                <div class="col-sm-9">
                                                    <asp:Image ID="Image1" runat="server" Width="380"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label form-label">Change Image:</label>
                                                <div class="col-sm-9">
                                                  <asp:FileUpload ID="fileUploadEdit" runat="server" />
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Menu Content:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:TextBox ID="Txt_EditContent" AutoCompleteType="Disabled" ReadOnly="false" class="form-control" Rows="5" TextMode="MultiLine" runat="server" ></asp:TextBox>
                                                </div>
                                          </div>
                                               <div class="form-group">
                                                 <label class="col-sm-3 control-label form-label">Category:</label>
                                                <div class="col-sm-9" style="position:relative">
                                                    <asp:CheckBoxList ID="Cbl_EditCategory" CssClass="checkbox checkbox-inline" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                                </div>
                                          </div>
                                            </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                                            <asp:Button ID="Btn_Delete" OnClick="Btn_Delete_Click" BackColor="#cf2627" CssClass="btn btn-default" runat="server" Text="Delete"/>
                                            <asp:Button ID="Btn_Edit" OnClick="Btn_Edit_Click" BackColor="#353435" CssClass="btn btn-default" runat="server" Text="Save"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </asp:Panel>     
                    </ContentTemplate>
                    <Triggers>
                         <asp:PostBackTrigger ControlID="Btn_Edit" />
                        <asp:AsyncPostBackTrigger ControlID="MenuGrid" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            <div style="position:fixed; left:0; bottom:0; background-color:#3D464D; width:99%">
            <div style="color:aliceblue; font-size:smaller" class="text-right">
        Copyright © 2023 <a style="color:#FF7622" href="#" target="_blank">Home Cooking</a> All rights reserved.
            </div>
        </div>
    </div>
            <style>
  .checkbox label {
    padding-right: 25px;
    padding-left: 3px; }
            </style>
         <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script type="text/javascript">
            function showEdit() {
                $("#editMenu").modal("show");
            };
            function newMenu() {
                $("#newMenu").modal("show");
            };
        </script>  
</asp:Content>
