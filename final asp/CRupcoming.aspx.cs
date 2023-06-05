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
    public partial class CRupcoming : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["club2"];
            //Response.Write(x);

            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand up = new SqlCommand("select * from upcomingMatchesOfClub (@name)", conn);
            up.Parameters.AddWithValue("@name", x);

            conn.Open();

            SqlDataReader r = up.ExecuteReader(CommandBehavior.CloseConnection);

            while (r.Read())
            {
                String hname1 = r.GetString(r.GetOrdinal("Host"));
                String gname1 = r.GetString(r.GetOrdinal("Guest"));
                DateTime stime1 = r.GetDateTime(r.GetOrdinal("start_time"));
                DateTime etime1 = r.GetDateTime(r.GetOrdinal("end_time"));
                String sname1 = r.GetString(r.GetOrdinal("Stadium"));

                Label hname = new Label();
                hname.Text = hname1 + "     ,     ";
                Label gname = new Label();
                gname.Text = gname1 + "      ,      ";
                Label stime = new Label();
                stime.Text = stime1.ToString() + "    ,      ";
                Label etime = new Label();
                etime.Text = etime1.ToString() + "      ,     ";
                Label sname = new Label();
                sname.Text = sname1 + "........";

                form1.Controls.Add(hname);
                form1.Controls.Add(gname);
                form1.Controls.Add(stime);
                form1.Controls.Add(etime);
                form1.Controls.Add(sname);

            }   }
    }
}