<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TwitterPage.aspx.cs" Inherits="WebLogin.Pages.TwitterPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Login with Twitter</h3>
    <div style="margin-top: 20px;margin-bottom: 20px;">
    <asp:Button runat="server" ID="TwitterLogin" Text="Login Using Twitter" CssClass="btn" OnClick="TwitterLogin_Click" />    
    </div>
    <asp:Panel runat="server" ID="DataPanel" Visible="False">
        <table class="table table-bordered">

            <tr>
                <td>Twitter id</td>
                <td>
                    <asp:Label runat="server" ID="TwitterIdLable"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Name</td>
                <td>
                    <asp:Label runat="server" ID="NameLable"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Screen Name</td>
                <td>
                    <asp:Label runat="server" ID="ScreenNameLabel"></asp:Label>

                </td>
            </tr>

            <tr>
                <td>Account Created</td>
                <td>
                    <asp:Label runat="server" ID="AccountCreatedLabel"></asp:Label>

                </td>
            </tr>
            <tr>
                <td>Image 1</td>
                <td>
                    <asp:Image runat="server" ID="Image1Image" />
                </td>
            </tr>
            <tr>
                <td>Image 2
                </td>
                <td>
                    <asp:Image runat="server" ID="Image1" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContentPlaceHolder" runat="server">
</asp:Content>
