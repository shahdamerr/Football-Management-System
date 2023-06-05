<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMregister.aspx.cs" Inherits="M3.SMregister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name:<br />
            <asp:TextBox ID="name" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server" required ="true" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            Stadium Name:<br />
            <asp:TextBox ID="stadiumname" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="Done" runat="server" Text="Done" OnClick="Done_Click" />
            <br />
        </div>
    </form>
</body>
</html>
