<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteStadium.aspx.cs" Inherits="M3.DeleteStadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="form2" runat="server">
        <div>
            Please fill in the textboxes:<br />
            <br />
            Stadium Name:</div>
        <asp:TextBox ID="name" runat="server" required="True" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="delete_stadium" runat="server" Text="Delete Stadium" OnClick="delete_stadium_Click" />
    </form>
</body>
</html>
