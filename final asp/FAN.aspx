<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAN.aspx.cs" Inherits="M3.FAN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="available" runat="server" Text="Available Matches To Attend" OnClick="available_Click" />
            <br />
            <br />
            <asp:Button ID="purchase" runat="server" Text="Purchase Ticket" OnClick="purchase_Click" />
            <br />
        </div>
    </form>
</body>
</html>
