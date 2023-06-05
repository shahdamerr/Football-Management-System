<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteMatch.aspx.cs" Inherits="M3.DeleteMatch" %>

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
            <asp:TextBox ID="host" runat="server" required="True" ></asp:TextBox>
            <br />
            <br />
            Guest Club Name:</div>
        <asp:TextBox ID="guest" runat="server" required="True" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="delete" runat="server" Text="Delete Match" OnClick="delete_Click" />
    </form>
</body>
</html>
