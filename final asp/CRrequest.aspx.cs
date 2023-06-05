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
    public partial class CRrequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Send_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String mname = smname.Text;
            int ID = Int32.Parse(mID.Text);
            String club = (String)Session["club1"];

            SqlCommand sendRequest = new SqlCommand("sendRequest", conn);
            sendRequest.CommandType = CommandType.StoredProcedure;
            sendRequest.Parameters.Add(new SqlParameter("@clubname", club));
            sendRequest.Parameters.Add(new SqlParameter("@smname", mname));
            sendRequest.Parameters.Add(new SqlParameter("@matchID", ID));

            conn.Open();
            sendRequest.ExecuteNonQuery();
            conn.Close();

            smname.Text = String.Empty;
            mID.Text = String.Empty;
            Response.Write("Sent :)");

        }
    }
}