using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class FANpurchase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void buy_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String x = (String)Session["ID1"];
            String host1 = host.Text;
            String guest1 = guest.Text;
            DateTime time1 = DateTime.Parse(time.Text);

            SqlCommand purchaseTicket = new SqlCommand("purchaseTicket", conn);
            purchaseTicket.CommandType = CommandType.StoredProcedure;
            purchaseTicket.Parameters.Add(new SqlParameter("@FanNationalID", x));
            purchaseTicket.Parameters.Add(new SqlParameter("@HostingClubName", host1));
            purchaseTicket.Parameters.Add(new SqlParameter("@GuestClubName", guest1));
            purchaseTicket.Parameters.Add(new SqlParameter("@StartTime", time1));

            conn.Open();
            purchaseTicket.ExecuteNonQuery();
            conn.Close();

            host.Text = String.Empty;
            guest.Text = String.Empty;
            time.Text = String.Empty;
            Response.Write("Done :)");
        }
    }
}