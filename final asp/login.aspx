<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="M3.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 153px">
            Please Login<br />
            <br />
            Username<br />
            <asp:TextBox ID="username" runat="server" ></asp:TextBox>
            <br />
            <br />
            Password<br />
        <asp:TextBox ID="password" runat="server" Height="20px" TextMode="Password" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="signin" runat="server" Text="Log in" OnClick="signin_Click" />
        <br />
        <br />
        <asp:Button ID="Register" runat="server" Text="Register Here" OnClick="Register_Click" />
        <br />
      </div>
    </form>
</body>
</html>
