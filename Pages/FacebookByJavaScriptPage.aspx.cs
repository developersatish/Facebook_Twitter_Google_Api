using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;

using Newtonsoft.Json.Linq;
using WebLogin.Domain;

namespace WebLogin.Pages
{
    public partial class FacebookByJavaScriptPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["access_code"] != null)
            {
                string accessCode = RouteData.Values["access_code"].ToString();
                ProcessRequest(accessCode);
            }
            else
            {
                Response.RedirectToRoute("Default",null);
            }
           
        }

        public void ProcessRequest(string accessToken)
        {
            var client = new FacebookClient(accessToken);
            dynamic result = client.Get("me", new { fields = "id,email,first_name,last_name,location,picture" });
            FbIdLable.Text = result.id;
            EmailidLabel.Text = result.email;
            FNameLable.Text = result.first_name;
            LNameLabel.Text = result.last_name;
            LocationLabel.Text = result.location.name;
            Image1Image.ImageUrl = result.picture.data.url;
            tokenHiddenFld.Value = accessToken;
        }

        protected void LogOutBtn_Click(object sender, EventArgs e)
        {
            var client = new FacebookClient();
            var logout = client.GetLogoutUrl(new
                                                 {
                                                     next=RedirectUrl.redirectUrl,
                                                     access_token=tokenHiddenFld.Value
                                                 });
            Response.Redirect(logout.AbsoluteUri);
        }
    }
}