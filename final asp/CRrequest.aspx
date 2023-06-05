<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRrequest.aspx.cs" Inherits="M3.CRrequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Stadium Manager Name:<br />
            <asp:TextBox ID="smname" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Match ID you want to host:<br />
            <asp:TextBox ID="mID" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Send" runat="server" Text="Send" OnClick="Send_Click" />
        </div>
    </form>
</body>
</html>
