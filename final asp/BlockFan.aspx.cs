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
    public partial class BlockFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void block_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String nationalID = national_ID.Text;

            SqlCommand blockFan = new SqlCommand("blockFan", conn);
            blockFan.CommandType = System.Data.CommandType.StoredProcedure;


            blockFan.Parameters.Add(new SqlParameter("@fan_id", nationalID));
            SqlParameter flag = blockFan.Parameters.Add("@flag", SqlDbType.Int);
            SqlParameter status = blockFan.Parameters.Add("@status", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;
            status.Direction = ParameterDirection.Output;

            conn.Open();
            blockFan.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Fan does not exist')", true);

            }

            if (status.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('fan is already blocked!')", true);

            }
            if (flag.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('fan is  blocked!')", true);

            }

        }
    
}
}