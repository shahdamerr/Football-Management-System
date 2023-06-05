<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SM.aspx.cs" Inherits="M3.SM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="info" runat="server" Text="View Stadium Information" OnClick="info_Click" />
            <br />
            <br />
            <asp:Button ID="request" runat="server" Text="View Requests" OnClick="request_Click" />
            <br />
            <br />
            <asp:Button ID="accept" runat="server" Text="Accept Requests" OnClick="accept_Click" />
            <br />
            <br />
            <asp:Button ID="reject" runat="server" Text="Reject Requests" OnClick="reject_Click" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
