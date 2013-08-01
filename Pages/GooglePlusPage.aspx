<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GooglePlusPage.aspx.cs" Inherits="WebLogin.Pages.GooglePlusPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     <h3>Login with Google+</h3>
    <div style="margin-top: 20px;margin-bottom: 20px;">
    <a href='#' class="btn btn-primary" onclick='login();' id="loginText">Google Plus </a>
    <a href="#" class="btn btn-success" style="display: none" id="logoutText" target='myIFrame' onclick="myIFrame.location='https://www.google.com/accounts/Logout'; startLogoutPolling();return false;">Click here to logout </a>
    <iframe name='myIFrame' id="myIFrame" style='display: none'></iframe>
    </div>
   
    <table class="table table-bordered">

            <tr>
                <td>Google+ id</td>
                <td>
                    <span id="userid"></span>
                </td>
            </tr>
         <tr>
                <td>Email</td>
                <td>
                    <span id="Email"></span>
                </td>
            </tr>
            <tr>
                <td>First Name</td>
                <td>
                    <span id="Fname"></span>
                </td>
            </tr>
           <tr>
                <td>Last Name</td>
                <td>
                    <span id="LName"></span>
                </td>
            </tr>

             <tr>
                <td>Full Name</td>
                <td>
                    <div id='uName'></div>
                </td>
            </tr>
           <tr>
                <td>Gender</td>
                <td>
                    <span id="Gender"></span>
                </td>
            </tr>
            <tr>
                <td>Image</td>
                <td>
                    <img style="width: 80px;height: 80px;" src="/Pages/noUser.jpg" id='imgHolder' />
                </td>
            </tr>
        </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContentPlaceHolder" runat="server">
    <script language="javascript" type="text/javascript">
        var OAUTHURL = 'https://accounts.google.com/o/oauth2/auth?';
        var VALIDURL = 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=';
        var SCOPE = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email';
        var CLIENTID = '458433852094.apps.googleusercontent.com';
        var REDIRECT = 'http://sk.applogin.com/googleplus';
        var LOGOUT = 'http://accounts.google.com/Logout';
        var TYPE = 'token';
        var _url = OAUTHURL + 'scope=' + SCOPE + '&client_id=' + CLIENTID + '&redirect_uri=' + REDIRECT + '&response_type=' + TYPE;
        var acToken;
        var tokenType;
        var expiresIn;
        var user;
        var loggedIn = false;


        function login() {
            var win = window.open(_url, "windowname1", 'width=800, height=600');

            var pollTimer = window.setInterval(function () {
                try {
                    console.log(win.document.URL);
                    if (win.document.URL.indexOf(REDIRECT) != -1) {
                        window.clearInterval(pollTimer);
                        var url = win.document.URL;
                        acToken = gup(url, 'access_token');
                        tokenType = gup(url, 'token_type');
                        expiresIn = gup(url, 'expires_in');
                        win.close();
                        validateToken(acToken);
                    }
                } catch (e) {
                }
            }, 500);
        }

        function validateToken(token) {
            $.ajax({
                url: VALIDURL + token,
                data: null,
                success: function (responseText) {
                    getUserInfo();
                    loggedIn = true;
                    $('#loginText').hide();
                    $('#logoutText').show();
                },
                dataType: "jsonp"
            });
        }

        function getUserInfo() {
            $.ajax({
                url: 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=' + acToken,
                data: null,
                success: function (resp) {
                    user = resp;
                    console.log(user);
                    $('#userid').text(user.id);
                    $('#Email').text(user.email);
                    $('#Fname').text(user.given_name);
                    $('#LName').text(user.family_name);
                    $('#Gender').text(user.gender);
                    $('#uName').text(user.name);
                    $('#imgHolder').attr('src', user.picture);
                },
                dataType: "jsonp"
            });
        }

        //credits: http://www.netlobo.com/url_query_string_javascript.html
        function gup(url, name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\#&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(url);
            if (results == null)
                return "";
            else
                return results[1];
        }

        function startLogoutPolling() {
            $('#loginText').show();
            $('#logoutText').hide();
            loggedIn = false;
          //  $('#uName').text('Welcome ');
           // $('#imgHolder').attr('src', 'none.jpg');
        }


    </script>
</asp:Content>
