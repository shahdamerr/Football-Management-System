using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3
{
    public partial class SMrequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["name1"];

            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand req = new SqlCommand("select * from allReqs (@stadiumManagerUsername)", conn);
            req.Parameters.AddWithValue("@stadiumManagerUsername", x);

            conn.Open();

            SqlDataReader r = req.ExecuteReader(CommandBehavior.CloseConnection);

            while (r.Read())
            {
                String rep = r.GetString(r.GetOrdinal("Club_Rep"));
                String host = r.GetString(r.GetOrdinal("Host_Club"));
                String guest = r.GetString(r.GetOrdinal("Guest_Club"));
                DateTime stime = r.GetDateTime(r.GetOrdinal("start_time"));
                DateTime etime = r.GetDateTime(r.GetOrdinal("end_time"));
                String status = r.GetString(r.GetOrdinal("status"));

                Label represent = new Label();
                represent.Text = rep + "     ,     ";
                Label hname = new Label();
                hname.Text = host + "      ,      ";
                Label gname = new Label();
                gname.Text = guest + "      ,      ";
                Label stime1 = new Label();
                stime1.Text = stime.ToString() + "    ,      ";
                Label etime1 = new Label();
                etime1.Text = etime.ToString() + "      ,     ";
                Label status1 = new Label();
                status1.Text = status + "........";

                form1.Controls.Add(represent);
                form1.Controls.Add(hname);
                form1.Controls.Add(gname);
                form1.Controls.Add(stime1);
                form1.Controls.Add(etime1);
                form1.Controls.Add(status1);

            }

        }
    }
}