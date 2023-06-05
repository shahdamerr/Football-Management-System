<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM.aspx.cs" Inherits="M3.SAM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Choose an action to perform:<br />
            <br />
            <asp:Button ID="addmatch" runat="server" Text="Add Match" OnClick="addmatch_Click" />
            <br />
            <br />
            <asp:Button ID="deletematch" runat="server" Text="Delete Match" OnClick="deletematch_Click" />
            <br />
            <br />
            <asp:Button ID="viewmatch" runat="server" Text="View All Upcoming Matches " OnClick="viewmatch_Click" />
            <br />
            <br />
            <asp:Button ID="viewalready" runat="server" Text="View Already Played Matches " OnClick="viewalready_Click" />
            <br />
            <br />
            <asp:Button ID="neverplayed" runat="server" Text="View Clubs Never Played Each Other " OnClick="neverplayed_Click" />
        </div>
    </form>
</body>
</html>
