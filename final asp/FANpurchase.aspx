<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FANpurchase.aspx.cs" Inherits="M3.FANpurchase" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Host Club Name:<br />
            <br />
            <asp:TextBox ID="host" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Guest Club Name:<br />
            <br />
            <asp:TextBox ID="guest" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Start Time:<br />
            <br />
            <asp:TextBox ID="time" runat="server" required ="true" TextMode="DateTimeLocal"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="buy" runat="server" Text="Buy" OnClick="buy_Click" />
        </div>
    </form>
</body>
</html>
