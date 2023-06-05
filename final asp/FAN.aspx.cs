using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class FAN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["ID"];
            //Response.Write(x);
            //Response.Write(y);

        }

        protected void available_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["ID"];

            Session["name1"] = x;
            Session["ID1"] = y;

            Response.Redirect("FANavailable.aspx");
        }

        protected void purchase_Click(object sender, EventArgs e)
        {
            String x = (String)Session["name"];
            String y = (String)Session["ID"];

            Session["name1"] = x;
            Session["ID1"] = y;

            Response.Redirect("FANpurchase.aspx");
        }
    }
}