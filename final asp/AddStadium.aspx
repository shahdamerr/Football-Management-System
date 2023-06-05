<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddStadium.aspx.cs" Inherits="M3.AddStadium" %>

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
        <p>
            Stadium Location:</p>
        <asp:TextBox ID="location" runat="server" required="True" ></asp:TextBox>
        <br />
        <br />
        Stadium Capacity:<br />
        <asp:TextBox ID="capacity" runat="server" required="True" TextMode="Number" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="add_stadium" runat="server" Text="Add Stadium" OnClick="add_stadium_Click" />
    </form>
</body>
</html>
