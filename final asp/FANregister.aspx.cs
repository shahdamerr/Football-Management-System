using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class FANregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Done_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

           
            String fname = name.Text;
            String fuser = username.Text;
            String fpassword = password.Text;
            String fnationalID = nationalID.Text;
            DateTime birth = DateTime.Parse(birthdate.Text);
            String faddress = address.Text;
            int fphone = Int32.Parse(phonenumber.Text);

            SqlCommand addFan = new SqlCommand("addFan", conn);
            addFan.CommandType = CommandType.StoredProcedure;
            addFan.Parameters.Add(new SqlParameter("@name", fname));
            addFan.Parameters.Add(new SqlParameter("@username", fuser));
            addFan.Parameters.Add(new SqlParameter("@password", fpassword));
            addFan.Parameters.Add(new SqlParameter("@national_ID", fnationalID));
            addFan.Parameters.Add(new SqlParameter("@birthdate", birth));
            addFan.Parameters.Add(new SqlParameter("@address", faddress));
            addFan.Parameters.Add(new SqlParameter("@phone", fphone));

            SqlParameter flag = addFan.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            SqlParameter flag1 = addFan.Parameters.Add("@flag1", SqlDbType.Int);
            flag1.Direction = ParameterDirection.Output;

            conn.Open();
            addFan.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username already exists!')", true);
            }
            else if (flag1.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('ID already registered!')", true);

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}
