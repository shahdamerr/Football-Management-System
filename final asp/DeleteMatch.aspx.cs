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
    public partial class DeleteMatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void delete_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String hostname = host.Text;
            String guestname = guest.Text;

            SqlCommand deleteMatch = new SqlCommand("deleteMatch", conn);
            deleteMatch.CommandType = System.Data.CommandType.StoredProcedure;

            deleteMatch.Parameters.Add(new SqlParameter("@hostClub", hostname));
            deleteMatch.Parameters.Add(new SqlParameter("@guestClub", guestname));
            SqlParameter flag = deleteMatch.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            deleteMatch.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Match does not exist')", true);

            }
            else if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Match has been deleted successfully!')", true);

            }
        }
    }
}