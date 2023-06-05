using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class SM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["stadium"];
            //Response.Write(x);
            //Response.Write(y);
        }

        protected void info_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["stadium"];
            Session["name1"] = x;
            Session["stadium1"] = y;

            Response.Redirect("SMinfo.aspx");
        }

        protected void request_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["stadium"];
            Session["name1"] = x;
            Session["stadium1"] = y;

            Response.Redirect("SMrequest.aspx");
        }

        protected void accept_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["stadium"];
            Session["name1"] = x;
            Session["stadium1"] = y;

            Response.Redirect("SMaccept.aspx");
        }

        protected void reject_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["stadium"];
            Session["name1"] = x;
            Session["stadium1"] = y;

            Response.Redirect("SMreject.aspx");
        }
    }
}