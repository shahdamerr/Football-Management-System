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
    public partial class AddClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_club_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String name = club_name.Text;
            String clublocation = location.Text;

            SqlCommand addClub = new SqlCommand("addClub", conn);
            addClub.CommandType = System.Data.CommandType.StoredProcedure;


            addClub.Parameters.Add(new SqlParameter("@name", name));
            addClub.Parameters.Add(new SqlParameter("@location", clublocation));
            SqlParameter flag = addClub.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            addClub.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club already added!')", true);

            }
            else if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club has been added successfully!')", true);

            }

        }
    }
    }