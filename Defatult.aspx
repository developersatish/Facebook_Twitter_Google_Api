<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Defatult.aspx.cs" Inherits="WebLogin.Defatult" %>

<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-top: 20px;">
        <table class="table table-bordered table-hover">
            <tr>
                <td>Facebook javascript
                </td>
                <td>
                    <div id="fbLogin" class="fb-login-button" scope="email" data-show-faces="false" data-width="100" data-max-rows="1"></div>

                </td>
            </tr>

            <tr>
                <td>Facebook with C# Code
                </td>
                <td>
                    <asp:Button runat="server" ID="FbBtn" Text="Facebook with C#" CssClass="btn" OnClick="FbBtn_Click" />

                </td>
            </tr>
            <tr>
                <td>Twitter</td>
                <td>
                    <asp:Button runat="server" ID="TwitterLogin" Text="Login Using Twitter" CssClass="btn btn-info" OnClick="TwitterLogin_Click" />

                </td>
            </tr>
            <tr>
                <td>Google + by JavaScript</td>
                <td>
                    <a href="<%:GetRouteUrl("GooglePlusPage",null) %>" class="btn btn-inverse">Google + by javascript</a>
                </td>
            </tr>
            <tr>
                <td>Google +</td>
                <td>
                    <asp:Button runat="server" ID="GooglePlusBtn" CssClass="btn btn-primary" Text="Login with Google" OnClick="GooglePlusBtn_Click" />
                </td>
            </tr>
        </table>


    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContentPlaceHolder" runat="server">
    <script>


        window.fbAsyncInit = function () {
            FB.init({
                appId: '<%= WebConfigurationManager.AppSettings["FacebookAppID"] %>', // App ID
                status: true, // check login status
                cookie: true, // enable cookies to allow the server to access the session
                xfbml: true  // parse XFBML
            });

            // Additional initialization code here
            FB.Event.subscribe('auth.authResponseChange', function (response) {
                if (response.status === 'connected') {
                    // the user is logged in and has authenticated your
                    // app, and response.authResponse supplies
                    // the user's ID, a valid access token, a signed
                    // request, and the time the access token 
                    // and signed request each expire
                    var uid = response.authResponse.userID;
                    var accessToken = response.authResponse.accessToken;

                    // TODO: Handle the access token
                    var form = document.createElement("form");
                    form.setAttribute("method", 'post');
                    // form.setAttribute("action", '/FacebookLoginHandler.ashx');
                    form.setAttribute("action", '/facebookbyjavascript/' + accessToken);
                    var field = document.createElement("input");
                    field.setAttribute("type", "hidden");
                    field.setAttribute("name", 'accessToken');
                    field.setAttribute("value", accessToken);
                    form.appendChild(field);

                    document.body.appendChild(form);

                    form.submit();

                } else if (response.status === 'not_authorized') {
                    // the user is logged in to Facebook, 
                    // but has not authenticated your app
                } else {
                    // the user isn't logged in to Facebook.
                }
            });
        };

        // Load the SDK Asynchronously
        (function (d) {
            var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement('script'); js.id = id; js.async = true;
            js.src = "//connect.facebook.net/en_US/all.js";
            ref.parentNode.insertBefore(js, ref);
        }(document));
    </script>
</asp:Content>
