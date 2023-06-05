using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("SAMregister.aspx");
        }

        protected void CRregister_Click(object sender, EventArgs e)
        {
            Response.Redirect("CRregister.aspx");
        }

        protected void SMregister_Click(object sender, EventArgs e)
        {
            Response.Redirect("SMregister.aspx");
        }

        protected void FANregister_Click(object sender, EventArgs e)
        {
            Response.Redirect("FANregister.aspx");
        }
    }
}