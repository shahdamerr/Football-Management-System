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
    public partial class DeleteStadium : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void delete_stadium_Click(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String stadiumname = name.Text;


            SqlCommand deleteStadium = new SqlCommand("deleteStadium", conn);
            deleteStadium.CommandType = System.Data.CommandType.StoredProcedure;


            deleteStadium.Parameters.Add(new SqlParameter("@StadiumName", stadiumname));
            SqlParameter flag = deleteStadium.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            deleteStadium.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium does not exist!')", true);

            }
            else if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium has been deleted successfully!')", true);

            }
        }
    }
}