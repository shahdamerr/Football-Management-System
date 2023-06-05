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
    public partial class SMinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["name1"];
            String y = (String)Session["stadium1"];

            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getStadiumInfo = new SqlCommand("getStadiumInfo", conn);
            getStadiumInfo.CommandType = CommandType.StoredProcedure;
            getStadiumInfo.Parameters.Add(new SqlParameter("@user", x));

            SqlParameter ID = getStadiumInfo.Parameters.Add("@ID", SqlDbType.Int);
            ID.Direction = ParameterDirection.Output;

            SqlParameter loc = getStadiumInfo.Parameters.Add("@loc", SqlDbType.VarChar, 20);
            loc.Direction = ParameterDirection.Output;

            SqlParameter capacity = getStadiumInfo.Parameters.Add("@capacity", SqlDbType.Int);
            capacity.Direction = ParameterDirection.Output;

            SqlParameter status = getStadiumInfo.Parameters.Add("@status", SqlDbType.Bit);
            status.Direction = ParameterDirection.Output;


            conn.Open();
            getStadiumInfo.ExecuteNonQuery();
            conn.Close();

            String f = Convert.ToString(getStadiumInfo.Parameters["@loc"].Value);

            Response.Write(y);
            Response.Write("......");
            Response.Write(ID.Value);
            Response.Write("......");
            Response.Write(f);
            Response.Write("......");
            Response.Write(capacity.Value);
            Response.Write("......");
            Response.Write(status.Value);
        }
    }
}