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
    public partial class SMregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Done_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


                String samname = name.Text;
                String samuser = username.Text;
                String sampassword = password.Text;
                String samstadiumname = stadiumname.Text;

                SqlCommand addStadiumManager = new SqlCommand("addStadiumManager", conn);
                addStadiumManager.CommandType = CommandType.StoredProcedure;
                addStadiumManager.Parameters.Add(new SqlParameter("@name", samname));
                addStadiumManager.Parameters.Add(new SqlParameter("@username", samuser));
                addStadiumManager.Parameters.Add(new SqlParameter("@password", sampassword));
                addStadiumManager.Parameters.Add(new SqlParameter("@stadium_name", samstadiumname));

            SqlParameter flag = addStadiumManager.Parameters.Add("@flag", SqlDbType.Int);
            flag.Direction = ParameterDirection.Output;

            SqlParameter flag1 = addStadiumManager.Parameters.Add("@flag1", SqlDbType.Int);
            flag1.Direction = ParameterDirection.Output;

            conn.Open();
            addStadiumManager.ExecuteNonQuery();
            conn.Close();

            if (flag.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username already exists!')", true);
            }
            else if (flag1.Value.Equals(0))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium does not exist!')", true);

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
        }
    }
