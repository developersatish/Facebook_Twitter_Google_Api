using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;
using WebLogin.Domain;
using WebLogin.TwitterSDK;

namespace WebLogin
{
    public partial class Defatult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["oauth_token"] != null & Request["oauth_verifier"] != null)
            {
                GetUserDetailsFromTwitter();
            }
            if (Request.QueryString["state"] == "google")
            {
                
            }
            if (Request.QueryString["code"] != null && Request.QueryString["state"]!="google")
            {
                string code = Request.QueryString["code"];
                Facebook(code);
            }


        }

        protected void TwitterLogin_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute("TwitterAccount", null);
            /* var oAuth = new oAuthTwitter();
             if (Request["oauth_token"] == null)
             {
                 var url = HttpContext.Current.Request.Url.Host;
                 oAuth.CallBackUrl = "http://" + url;
                 Response.Redirect(oAuth.AuthorizationLinkGet());
             }
             else
             {
                 GetUserDetailsFromTwitter();
             }*/
        }

        private void GetUserDetailsFromTwitter()
        {
            if (Request["oauth_token"] != null & Request["oauth_verifier"] != null)
            {
                var oAuth = new oAuthTwitter();
                oAuth.AccessTokenGet(Request["oauth_token"], Request["oauth_verifier"]);
                if (oAuth.TokenSecret.Length > 0)
                {
                    Session["data"] = oAuth.oAuthWebRequest(oAuthTwitter.Method.GET, RedirectUrl.getTwitterAccount,
                                                            String.Empty);
                    Response.RedirectToRoute("TwitterAccount", null);

                }
            }
        }

        protected void FbBtn_Click(object sender, EventArgs e)
        {
            var fb = new FacebookClient();
            var loginUrl = fb.GetLoginUrl(new
                                              {
                                                  client_id = WebConfigurationManager.AppSettings["FacebookAppID"],
                                                  client_secret = WebConfigurationManager.AppSettings["FacebookSecret"],
                                                  redirect_uri = RedirectUrl.redirectUrl,
                                                  response_type = "code",
                                                  scope = "email"
                                              });

            Response.Redirect(loginUrl.AbsoluteUri);

        }

        private void Facebook(string code)
        {
            if (!String.IsNullOrEmpty(code))
            {
                var fb = new FacebookClient();
                dynamic result = fb.Post("oauth/access_token", new
                                                                   {
                                                                       client_id =
                                                                   WebConfigurationManager.AppSettings["FacebookAppID"],
                                                                       client_secret =
                                                                   WebConfigurationManager.AppSettings["FacebookSecret"],
                                                                       redirect_uri = RedirectUrl.redirectUrl,
                                                                       code = code
                                                                   });
                var accessToken = result.access_token;
                Response.RedirectToRoute("FacebookByJavaScriptPage",
                                         new RouteValueDictionary() { { "access_code", accessToken } });
                /* var client = new FacebookClient(accessToken);
                 dynamic me = client.Get("me", new { fields = "id,email,first_name,last_name,location,picture" });*/
            }

        }

        protected void GooglePlusBtn_Click(object sender, EventArgs e)
        {

            StringBuilder authLink = new StringBuilder();
            authLink.Append("https://accounts.google.com/o/oauth2/auth");
            authLink.AppendFormat("?response_type={0}", "code");
            authLink.AppendFormat("&client_id={0}", "458433852094.apps.googleusercontent.com");
            authLink.AppendFormat("&redirect_uri={0}", RedirectUrl.redirectUrl);
            authLink.AppendFormat("&state={0}", "google");
            authLink.Append("&scope=https://www.googleapis.com/auth/plus.me");
            string url = string.Format(authLink.ToString());
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url.ToString());
            request.Method = HttpMethod.Get.ToString();
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = 0;

            try
            {
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    Response.Redirect(response.ResponseUri.AbsoluteUri);
                }
            }
            catch (Exception exception)
            {

            }
        }

        private void Google(string code)
        {
            
        }
    }


}
