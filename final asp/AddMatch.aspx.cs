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
    public partial class AddMatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_match_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String host = host_name.Text;
            String guest = guest_name.Text;
            DateTime start = DateTime.Parse(starttime.Text);
            DateTime end = DateTime.Parse(endtime.Text);

            SqlCommand addNewMatch = new SqlCommand("addNewMatch", conn);
            addNewMatch.CommandType = System.Data.CommandType.StoredProcedure;

            addNewMatch.Parameters.Add(new SqlParameter("@hostClub", host));
            addNewMatch.Parameters.Add(new SqlParameter("@guestClub", guest));
            addNewMatch.Parameters.Add(new SqlParameter("@startTime", start));
            addNewMatch.Parameters.Add(new SqlParameter("@endTime", end));
            SqlParameter flag = addNewMatch.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;


            conn.Open();
            addNewMatch.ExecuteNonQuery();
            conn.Close();

             if (flag.Value.Equals(0))
            {
                Response.Write("Match already added/One of the clubs no not exist");
            }
            else if (flag.Value.Equals(1))
            {
                Response.Write("Match has been added sucessfully");

            }
        }

    }
    }