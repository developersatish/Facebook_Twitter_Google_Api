using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace WebLogin.Domain
{
    public class MyRoute
    {
        public static void Route(RouteCollection route)
        {
            route.MapPageRoute("Default", "", "~/Defatult.aspx");
            route.MapPageRoute("TwitterAccount", "twitter", "~/Pages/TwitterPage.aspx");
            route.MapPageRoute("FacebookByJavaScriptPage", "facebookbyjavascript/{access_code}",
                               "~/Pages/FacebookByJavaScriptPage.aspx", true, new RouteValueDictionary { { "access_code", " " } });
            route.MapPageRoute("GooglePlusPage", "googleplus", "~/Pages/GooglePlusPage.aspx");

        }
    }
}