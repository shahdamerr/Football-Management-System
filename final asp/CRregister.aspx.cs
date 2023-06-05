using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3
{
    public partial class CRregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Done_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

                String crname = name.Text;
                String cruser = username.Text;
                String crpassword = password.Text;
                String crclubname = clubname.Text;

                SqlCommand addRepresentative = new SqlCommand("addRepresentative", conn);
                addRepresentative.CommandType = CommandType.StoredProcedure;
                addRepresentative.Parameters.Add(new SqlParameter("@Rep_name", crname));
                addRepresentative.Parameters.Add(new SqlParameter("@username", cruser));
                addRepresentative.Parameters.Add(new SqlParameter("@password", crpassword));
                addRepresentative.Parameters.Add(new SqlParameter("@club_name", crclubname));

            SqlParameter flag = addRepresentative.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            SqlParameter flag1 = addRepresentative.Parameters.Add("@flag1", SqlDbType.Int);
            flag1.Direction = ParameterDirection.Output;

            conn.Open();
            addRepresentative.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username already exists!')", true);
            }
            else if (flag1.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club does not exist!')", true);

            }
            else
            {
                Response.Redirect("login.aspx");
            }


        }
    }
}