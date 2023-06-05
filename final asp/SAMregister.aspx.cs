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
    public partial class SAMregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Done_Click(object sender, EventArgs e)
        {
            {
                string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                

                    String samname = name.Text;
                    String samuser = username.Text;
                    String sampassword = password.Text;
                    

                    SqlCommand addAssociationManager = new SqlCommand("addAssociationManager", conn);
                    addAssociationManager.CommandType = CommandType.StoredProcedure;
                    addAssociationManager.Parameters.Add(new SqlParameter("@name", samname));
                    addAssociationManager.Parameters.Add(new SqlParameter("@username", samuser));
                    addAssociationManager.Parameters.Add(new SqlParameter("@pass", sampassword));


                    SqlParameter flag = addAssociationManager.Parameters.Add("@flag", SqlDbType.Int);
                    flag.Direction = ParameterDirection.Output;

                    conn.Open();
                    addAssociationManager.ExecuteNonQuery();
                    conn.Close();

                    if (flag.Value.Equals(0))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Username already exists!')", true);
                    }
                    else
                    {
                        Response.Redirect("login.aspx");
                    }
                }
            }
        }
    }
