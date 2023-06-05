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
    public partial class DeleteClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void del_club_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String name = club_name.Text;

            SqlCommand deleteClub = new SqlCommand("deleteClub", conn);
            deleteClub.CommandType = System.Data.CommandType.StoredProcedure;


            deleteClub.Parameters.Add(new SqlParameter("@clubname", name));

            SqlParameter flag = deleteClub.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            deleteClub.ExecuteNonQuery();
            conn.Close();



            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club does not exist!')", true);


            }
            if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club has been deleted successfully!')", true);

            }


        }
    }
}