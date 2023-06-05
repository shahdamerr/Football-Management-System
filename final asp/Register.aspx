<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="M3.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="SAMregister" runat="server" OnClick="Button1_Click" Text="Sports Association Manager Registration" />
            <br />
            <br />
            <asp:Button ID="CRregister" runat="server" Text="Club Representative Registration" OnClick="CRregister_Click" />
            <br />
            <br />
            <asp:Button ID="SMregister" runat="server" Text="Stadium Manager Registration" OnClick="SMregister_Click" />
            <br />
            <br />
            <asp:Button ID="FANregister" runat="server" Text="Fan Registration" OnClick="FANregister_Click" />
            <br />
        </div>
    </form>
</body>
</html>
