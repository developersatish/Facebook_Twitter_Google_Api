using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;
using WebLogin.Domain;
using WebLogin.TwitterSDK;

namespace WebLogin.Pages
{
    public partial class TwitterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["oauth_token"] != null & Request["oauth_verifier"] != null)
            {
                GetUserDetailsFromTwitter();
            }

        }
        protected void TwitterLogin_Click(object sender, EventArgs e)
        {
            var oAuth = new oAuthTwitter();
            if (Request["oauth_token"] == null)
            {
                var url = HttpContext.Current.Request.Url.Host;
                oAuth.CallBackUrl = "http://" + url + "/twitter";
                Response.Redirect(oAuth.AuthorizationLinkGet());
            }
            else
            {
                GetUserDetailsFromTwitter();
            }
        }

        private void GetUserDetailsFromTwitter()
        {
            if (Request["oauth_token"] != null & Request["oauth_verifier"] != null)
            {
                var oAuth = new oAuthTwitter();
                oAuth.AccessTokenGet(Request["oauth_token"], Request["oauth_verifier"]);
                if (oAuth.TokenSecret.Length > 0)
                {
                    var json = oAuth.oAuthWebRequest(oAuthTwitter.Method.GET, RedirectUrl.getTwitterAccount, String.Empty);
                    JObject jObject = JObject.Parse(json);
                    JToken jUser = jObject["status"];
                    TwitterIdLable.Text = jObject["id"].ToString();
                    NameLable.Text = jObject["name"].ToString();
                    ScreenNameLabel.Text = jObject["screen_name"].ToString();
                    AccountCreatedLabel.Text = jObject["created_at"].ToString();
                    Image1Image.ImageUrl = jObject["profile_image_url"].ToString();
                    Image1.ImageUrl = jObject["profile_image_url_https"].ToString();
                    DataPanel.Visible = true;
                }
            }
        }
    }
}