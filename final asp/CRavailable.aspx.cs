using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace M3
{
    public partial class CRavailable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 

        }

        protected void view_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            DateTime date = DateTime.Parse(date1.Text);
            SqlCommand check = new SqlCommand("select * from viewAvailableStadiumsOn (@datetime)", conn);
            check.Parameters.AddWithValue("@datetime", date);
           // Response.Write(date.ToString());

            conn.Open();

            SqlDataReader r = check.ExecuteReader(CommandBehavior.CloseConnection);

            while (r.Read())
            {
                String name1 = r.GetString(r.GetOrdinal("Name"));
                String location1 = r.GetString(r.GetOrdinal("Location"));
                int capacity1 = r.GetInt32(r.GetOrdinal("Capacity"));

                Label name = new Label();
                name.Text = name1 + "      ,    ";
                Label location= new Label();
                location.Text = location1 + "     ,       ";
                Label capacity = new Label();
                capacity.Text = capacity1.ToString() + ".......";
               

                form1.Controls.Add(name);
                form1.Controls.Add(location);
                form1.Controls.Add(capacity);
                

            }



        }
    }
}