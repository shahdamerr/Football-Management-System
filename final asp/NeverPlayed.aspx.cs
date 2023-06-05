using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class NeverPlayed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand clubsNeverMatched = new SqlCommand("select * from clubsNeverMatched", conn);

            conn.Open();
            SqlDataReader x = clubsNeverMatched.ExecuteReader(CommandBehavior.CloseConnection);

            while (x.Read())
            {
                String host = x.GetString(x.GetOrdinal("First_Club"));
                String guest = x.GetString(x.GetOrdinal("Sec_Club"));


                Label host_name = new Label();
                host_name.Text = host + "    ,    ";
                Label guest_name = new Label();
                guest_name.Text = guest + " .......  ";


                form1.Controls.Add(host_name);
                form1.Controls.Add(guest_name);

            }
        }
    }
}