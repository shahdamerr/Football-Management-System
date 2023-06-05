using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class SAM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addmatch_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddMatch.aspx");
        }

        protected void deletematch_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeleteMatch.aspx");
        }

        protected void viewmatch_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMatch.aspx");
        }

        protected void viewalready_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewAlready.aspx");
        }

        protected void neverplayed_Click(object sender, EventArgs e)
        {
            Response.Redirect("NeverPlayed.aspx");
        }
    }
}