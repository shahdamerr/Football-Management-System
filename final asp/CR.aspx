<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CR.aspx.cs" Inherits="M3.CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="CRinfo" runat="server" Text="View club information" OnClick="CRinfo_Click" />
            <br />
            <br />
            <asp:Button ID="CRavailable" runat="server" Text="View available stadiums" OnClick="CRavailable_Click" />
            <br />
            <br />
            <asp:Button ID="CRupcoming" runat="server" Text="View upcoming matches" OnClick="CRupcoming_Click" />
            <br />
            <br />
            <asp:Button ID="CRrequest" runat="server" Text="Send request to Stadium Manager" OnClick="CRrequest_Click" />
        </div>
    </form>
</body>
</html>
