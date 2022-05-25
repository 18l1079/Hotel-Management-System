<%@ Page Title="" Language="C#" MasterPageFile="~/mas.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Stylesheets" runat="server">
             <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />  

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
    <div>
        <asp:Image ID="Image1" ImageURL="https://www.iequippers.org/wp-content/uploads/2012/09/login-now-yellow.png" runat="server" Height="84px" style="margin-bottom: 0px" Width="491px" />;
       
    </div>
        <div class="container">
             <br />
             <asp:TextBox ID="TextBox1" runat="server" Text="Enter email address" Height="22px" Width="390px" style="margin-left: 1px" BorderColor="Yellow"></asp:TextBox>
             <br />
             <br />
            <asp:TextBox ID="TextBox2" runat="server"  type="password" value="FakePSW"  Text="Enter password" Height="24px" Width="391px" style="margin-left: 2px" BorderColor="Yellow"></asp:TextBox>
             <br />
             <br />
            <asp:Button ID="Button1" runat="server" OnClick="Login_Button_Click" Text="LOGIN" Width="398px" style="margin-left: 2px" BackColor="#0099CC" BorderColor="#3399FF" ForeColor="Black" />
             <br />
             <br />
            <asp:Button ID="Button2" runat="server" Text="CANCEL" Width="401px" style="margin-left: 0px" BackColor="Yellow" />
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label1" runat="server" Text="Don't have an account?"></asp:Label>
             <br />
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Register.aspx">Register</asp:HyperLink>
        </div>
    <div class="loader" runat="server"></div>
    <div id="message" runat="server">
        </div>




</asp:Content>
