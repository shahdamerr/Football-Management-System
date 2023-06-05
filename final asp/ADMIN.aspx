<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ADMIN.aspx.cs" Inherits="M3.ADMIN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Welcome !<br />
            Please choose an action to perform:
            <br />
            <br />
            <asp:Button ID="addclub" runat="server" Text="Add Club" OnClick="addclub_Click" />
            <br />
            <br />
        </div>
        <asp:Button ID="deleteclub" runat="server" Text="Delete Club" OnClick="deleteclub_Click" />
        <br />
        <br />
        <asp:Button ID="addstadium" runat="server" Text="Add Stadium" OnClick="addstadium_Click" />
        <br />
        <br />
        <asp:Button ID="deletestadium" runat="server" Text="Delete Stadium" OnClick="deletestadium_Click" />
        <br />
        <br />
        <asp:Button ID="blockfan" runat="server" Text="Block Fan" OnClick="blockfan_Click" />
        <br />
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
