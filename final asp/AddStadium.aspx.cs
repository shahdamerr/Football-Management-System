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
    public partial class AddStadium : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void add_stadium_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String stadiumname = name.Text;
            String stadiumlocation = location.Text;
            int scapacity = Int32.Parse(capacity.Text);

            SqlCommand addStadium = new SqlCommand("addStadium", conn);
            addStadium.CommandType = System.Data.CommandType.StoredProcedure;


            addStadium.Parameters.Add(new SqlParameter("@StadiumName", stadiumname));
            addStadium.Parameters.Add(new SqlParameter("@Location", stadiumlocation));
            addStadium.Parameters.Add(new SqlParameter("@capacity", scapacity));
            SqlParameter flag = addStadium.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            addStadium.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium already added!')", true);

            }
            else if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium has been added successfully!')", true);

            }
        }
    }
}