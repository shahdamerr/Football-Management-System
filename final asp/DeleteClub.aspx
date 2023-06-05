<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteClub.aspx.cs" Inherits="M3.DeleteClub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please fill in the textbox:<br />
            <br />
        <div>
            Club Name:</div>
        <asp:TextBox ID="club_name" runat="server" required="True" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="del_club" runat="server" Text="Delete Club" OnClick="del_club_Click" />
        </div>
    </form>
</body>
</html>
