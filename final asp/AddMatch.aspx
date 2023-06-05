<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMatch.aspx.cs" Inherits="M3.AddMatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please fill in the textboxes:<br />
            <br />
            Host Club Name:<br />
            <asp:TextBox ID="host_name" runat="server" required="True" ></asp:TextBox>
            <br />
            <br />
            Guest Club Name:<br />
            <asp:TextBox ID="guest_name" runat="server" required="True" ></asp:TextBox>
            <br />
            <br />
            Start Time:<br />
            <asp:TextBox ID="starttime" runat="server" required="True" TextMode="DateTimeLocal"></asp:TextBox>
            <br />
            <br />
            End Time:</div>
        <asp:TextBox ID="endtime" runat="server"  required="True" TextMode="DateTimeLocal"></asp:TextBox>
        <p>
            <asp:Button ID="add_match" runat="server" Text="Add Match" OnClick="add_match_Click" />
        </p>
    </form>
</body>
</html>
