using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void signin_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user = username.Text;
            String pass = password.Text;

            SqlCommand checkTable = new SqlCommand("checkTable", conn);
            checkTable.CommandType = CommandType.StoredProcedure;
            checkTable.Parameters.Add(new SqlParameter("@username", user));
            checkTable.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter t = checkTable.Parameters.Add("@t", SqlDbType.Int);
            t.Direction = ParameterDirection.Output;

            conn.Open();
            checkTable.ExecuteNonQuery();
            conn.Close();

            if (t.Value.Equals(1))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username does not exist!')", true);
            }
            else if (t.Value.Equals(2))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Password Incorrect!')", true);
            }
            else if (t.Value.Equals(3))
            {
                Session["name"] = username.Text;

                SqlCommand getClub = new SqlCommand("getClub", conn);
                getClub.CommandType = CommandType.StoredProcedure;
                getClub.Parameters.Add(new SqlParameter("@user", username.Text));

                SqlParameter name = getClub.Parameters.Add("@name", SqlDbType.VarChar, 20);
                name.Direction = ParameterDirection.Output;

                conn.Open();
                getClub.ExecuteNonQuery();
                conn.Close();

                String cr = Convert.ToString(getClub.Parameters["@name"].Value); ;

                Session["club"] = cr;

                Response.Redirect("CR.aspx");
            }
            else if (t.Value.Equals(4))
            {
                Session["name"] = username.Text;

                SqlCommand getFanID = new SqlCommand("getFanID", conn);
                getFanID.CommandType = CommandType.StoredProcedure;
                getFanID.Parameters.Add(new SqlParameter("@user", username.Text));

                SqlParameter ID = getFanID.Parameters.Add("@ID", SqlDbType.VarChar, 20);
                ID.Direction = ParameterDirection.Output;

                conn.Open();
                getFanID.ExecuteNonQuery();
                conn.Close();

                String f = Convert.ToString(getFanID.Parameters["@ID"].Value); 

                Session["ID"] = f;

                Server.Transfer("FAN.aspx");
            }
            else if (t.Value.Equals(5))
            {
                Session["name"] = username.Text;
                Server.Transfer("SAM.aspx");
            }
            else if (t.Value.Equals(6))
            {
                Session["name"] = username.Text;

                SqlCommand getStadium = new SqlCommand("getStadium", conn);
                getStadium.CommandType = CommandType.StoredProcedure;
                getStadium.Parameters.Add(new SqlParameter("@user", username.Text));

                SqlParameter name = getStadium.Parameters.Add("@name", SqlDbType.VarChar, 20);
                name.Direction = ParameterDirection.Output;

                conn.Open();
                getStadium.ExecuteNonQuery();
                conn.Close();

                String s = Convert.ToString(getStadium.Parameters["@name"].Value); ;

                Session["stadium"] = s;

                Server.Transfer("SM.aspx");
            }
            else if (t.Value.Equals(7))
            {
                Session["name"] = username.Text;
                Server.Transfer("ADMIN.aspx");
            }
        }
            protected void Register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}