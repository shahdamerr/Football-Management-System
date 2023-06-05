using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3
{
    public partial class SMaccept : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void accept_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["name1"];
            String host1 = host.Text;
            String guest1 = guest.Text;
            DateTime time1 = DateTime.Parse(time.Text);


            SqlCommand acceptRequest = new SqlCommand("acceptRequest", conn);
            acceptRequest.CommandType = CommandType.StoredProcedure;
            acceptRequest.Parameters.Add(new SqlParameter("@username", x));
            acceptRequest.Parameters.Add(new SqlParameter("@host", host1));
            acceptRequest.Parameters.Add(new SqlParameter("@guest", guest1));
            acceptRequest.Parameters.Add(new SqlParameter("@start", time1));

            conn.Open();
            acceptRequest.ExecuteNonQuery();
            conn.Close();

            host.Text = String.Empty;
            guest.Text = String.Empty;
            time.Text= String.Empty;
            Response.Write("Accepted :)");

        }
    }
}