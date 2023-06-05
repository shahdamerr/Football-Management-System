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
    public partial class CRinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String x = (String)Session["name1"];
            String y = (String)Session["club1"];

            string connStr = WebConfigurationManager.ConnectionStrings["M3"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getClubInfo = new SqlCommand("getClubInfo", conn);
            getClubInfo.CommandType = CommandType.StoredProcedure;
            getClubInfo.Parameters.Add(new SqlParameter("@user", x));

            SqlParameter ID = getClubInfo.Parameters.Add("@ID", SqlDbType.Int);
            ID.Direction = ParameterDirection.Output;

            SqlParameter loc = getClubInfo.Parameters.Add("@loc", SqlDbType.VarChar, 20);
            loc.Direction = ParameterDirection.Output;

            conn.Open();
            getClubInfo.ExecuteNonQuery();
            conn.Close();

            String f = Convert.ToString(getClubInfo.Parameters["@loc"].Value);

            Response.Write(y);
            Response.Write("......");
            Response.Write(ID.Value);
            Response.Write("......");
            Response.Write(f);

        }
    }
}