using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class ADMIN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addclub_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddClub.aspx");
        }

        protected void deleteclub_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeleteClub.aspx");
        }

        protected void addstadium_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddStadium.aspx");
        }

        protected void deletestadium_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeleteStadium.aspx");
        }

        protected void blockfan_Click(object sender, EventArgs e)
        {
            Response.Redirect("BlockFan.aspx");
        }
    }
}