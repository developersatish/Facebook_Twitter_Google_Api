<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="FacebookByJavaScriptPage.aspx.cs" Inherits="WebLogin.Pages.FacebookByJavaScriptPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Facebook Data</h3>
    <table class="table table-bordered">

        <tr>
            <td>Facebook id</td>
            <td>
                <asp:Label runat="server" ID="FbIdLable"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>Firs Name</td>
            <td>
                <asp:Label runat="server" ID="FNameLable"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td>
                <asp:Label runat="server" ID="LNameLabel"></asp:Label>

            </td>
        </tr>

        <tr>
            <td>EmailID</td>
            <td>
                <asp:Label runat="server" ID="EmailidLabel"></asp:Label>

            </td>
        </tr>
        <tr>
            <td>Location</td>
            <td>
                <asp:Label runat="server" ID="LocationLabel"></asp:Label>

            </td>
        </tr>
        <tr>
            <td>Image 1</td>
            <td>
                <asp:Image runat="server" ID="Image1Image" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField runat="server" ID="tokenHiddenFld" />
            </td>
            <td>
                <asp:LinkButton CssClass="btn btn-success" runat="server" ID="LogOutBtn" OnClick="LogOutBtn_Click">Facebook Logout</asp:LinkButton>
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContentPlaceHolder" runat="server">
</asp:Content>
