using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3
{
    public partial class CR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
           SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["name"];
            //Response.Write(x);

            String y = (String)Session["club"];
            //Response.Write(y);

        }


        protected void CRinfo_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["name"];
            Session["name1"] = x;
            String y = (String)Session["club"];
            Session["club1"] = y;

            Response.Redirect("CRinfo.aspx");
        }

        protected void CRavailable_Click(object sender, EventArgs e)
        {
            Response.Redirect("CRavailable.aspx");
        }

        protected void CRupcoming_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["club"];
            Session["club2"] = x;

            Response.Redirect("CRupcoming.aspx");
        }

        protected void CRrequest_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["club"];
            Session["club1"] = x;

            Response.Redirect("CRrequest.aspx");
        }
    }
}