<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMreject.aspx.cs" Inherits="M3.SMreject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name of host club of request:<br />
            <br />
            <asp:TextBox ID="host" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            Name of guest club of request:<br />
            <br />
            <asp:TextBox ID="guest" runat="server" required ="true"></asp:TextBox>
            <br />
            <br />
            <br />
            Start time of match:<br />
            <br />
            <asp:TextBox ID="time" runat="server" required ="true" TextMode="DateTimeLocal"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="accept" runat="server" Text="Reject" OnClick="accept_Click" />
            
        </div>
    </form>
</body>
</html>
