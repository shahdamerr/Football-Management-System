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
    public partial class ViewAlready : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            DateTime date = DateTime.Now;
            SqlCommand allPreviousMatches = new SqlCommand("select * from allPreviousMatches('2022-12-29 20:16:00.000')  ", conn);
            allPreviousMatches.Parameters.AddWithValue("@date", date);

            conn.Open();
            SqlDataReader x = allPreviousMatches.ExecuteReader(CommandBehavior.CloseConnection);

            while (x.Read())
            {
                String host = x.GetString(x.GetOrdinal("Host"));
                String guest = x.GetString(x.GetOrdinal("Guest"));
                DateTime start = x.GetDateTime(x.GetOrdinal("Start_Time"));
                DateTime end = x.GetDateTime(x.GetOrdinal("End_Time"));

                Label host_name = new Label();
                host_name.Text = host + "    ,    ";
                Label guest_name = new Label();
                guest_name.Text = guest + "     ,    ";
                Label starttime = new Label();
                starttime.Text = start.ToString() + "     ,      ";
                Label endtime = new Label();
                endtime.Text = end.ToString();

                form1.Controls.Add(host_name);
                form1.Controls.Add(guest_name);
                form1.Controls.Add(starttime);
                form1.Controls.Add(endtime);






            }
        }
    }
}