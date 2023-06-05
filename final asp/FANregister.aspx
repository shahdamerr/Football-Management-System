<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FANregister.aspx.cs" Inherits="M3.FANregister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name:<br />
            <asp:TextBox ID="name" runat="server" required = "true"></asp:TextBox> 
            <br />
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server" required = "true"></asp:TextBox>
            <br />
            <br />
            Password:<br />
            <asp:TextBox ID="password" runat="server" required = "true" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            National ID:<br />
            <asp:TextBox ID="nationalID" runat="server" required = "true"></asp:TextBox>
            <br />
            <br />
            Phone Number:<br />
            <asp:TextBox ID="phonenumber" runat="server" required = "true"></asp:TextBox>
            <br />
            <br />
            Birth Date:<br />
            <asp:TextBox ID="birthdate" runat="server" required = "true" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            Address:<br />
            <asp:TextBox ID="address" runat="server" required = "true"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="Done" runat="server" OnClick="Done_Click" Text="Done" />
            <br />
        </div>
    </form>
</body>
</html>
