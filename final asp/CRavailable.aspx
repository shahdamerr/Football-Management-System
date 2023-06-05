<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRavailable.aspx.cs" Inherits="M3.CRavailable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Date:<br />
            <br />
            <asp:TextBox ID="date1" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
            <asp:Button ID="view" runat="server" Text="View" OnClick="view_Click" />
            <br />
            <br />
            (Order: Stadium name, Stadium Location, Stadium Capacity.....)<br />
            <br />
        </div>
    </form>
</body>
</html>
