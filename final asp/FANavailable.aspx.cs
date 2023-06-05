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
    public partial class FANavailable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void view_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            DateTime date = DateTime.Parse(date1.Text);
            SqlCommand check = new SqlCommand("select * from availableMatchesToAttend (@date)", conn);
            check.Parameters.AddWithValue("@date", date);

            conn.Open();

            SqlDataReader r = check.ExecuteReader(CommandBehavior.CloseConnection);

            while (r.Read())
            {
                String host1 = r.GetString(r.GetOrdinal("Host"));
                String guest1 = r.GetString(r.GetOrdinal("Guest"));
                String name1 = r.GetString(r.GetOrdinal("Stadium"));
                String location1 = r.GetString(r.GetOrdinal("Location"));
                DateTime stime = r.GetDateTime(r.GetOrdinal("start_time"));



                Label host = new Label();
                host.Text = host1 + "      ,    ";
                Label guest = new Label();
                guest.Text = guest1 + "      ,    ";
                Label stadium = new Label();
                stadium.Text = name1 + "      ,    ";
                Label location = new Label();
                location.Text = location1 + "     ,       ";
                Label stime1 = new Label();
                stime1.Text = stime.ToString() + "......";


                form1.Controls.Add(host);
                form1.Controls.Add(guest);
                form1.Controls.Add(stadium);
                form1.Controls.Add(location);
                form1.Controls.Add(stime1);


            }

        }
    }
}