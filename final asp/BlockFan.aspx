<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BlockFan.aspx.cs" Inherits="M3.BlockFan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please fill in the textbox:<br />
            <br />
            Fan National ID:<br />
            <asp:TextBox ID="national_ID" runat="server" required="True" ></asp:TextBox>
            <br />
            <br />
        </div>
        <asp:Button ID="block" runat="server" Text="Block Fan" OnClick="block_Click" />
    </form>
</body>
</html>
