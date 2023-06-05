<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddClub.aspx.cs" Inherits="M3.AddClub" %>

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
            Club Name:</div>
        <asp:TextBox ID="club_name" runat="server" required="True" ></asp:TextBox>
        <p>
            Club Location:</p>
        <asp:TextBox ID="location" runat="server" required="True" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="add_club" runat="server" Text="Add Club" OnClick="add_club_Click" />
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
