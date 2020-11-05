<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="CIS484Solution1.WebForm1" %>
    <!-- John Wehner, Max Vaughan Lab 3-->


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"lang="en">

<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="Wehner"/>
    <meta name="author" content="Wehner"/>
    <meta name="keywords" content="Wehner"/>

    <title >Event Registration Page: John Paul Wehner</title>

    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet"/>
    <!-- Main CSS-->
    <link href="main.css" rel="stylesheet" media="all"/>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
    <!-- Main JS-->
    <script src="jquery.js"></script>
    <script src="global.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"  ></script>

</head>

<body>
    <script type="text/javascript">
        //Implementing select2 api in order to modernize and stylize the selections
    $(document).ready(function() {
    $(".js-example-basic-single").select2();
    });
    </script>
  <div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins">
   <div class="wrapper wrapper--w680">
    <div class="card card-4">
      <div class="card-body">
        <!-- My Heading and my Name included in the Title and in the body-->

       <h2 class="title" >Field Trip Program Adventure: John Paul Wehner </h2>
         <form id="LabForm" runat="server">
             <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
               </asp:ScriptManager>
                 <!-- Macro Menu for overarching personnel type selection-->

             <asp:Menu  
                ID="MasterMenu"  
                CssClass="navc"
                Orientation="Horizontal"  
                Width="100%"  
                Text-Align="center"
                runat="server"  
                OnMenuItemClick="MasterMenu_MenuItemClick"  NavigateUrl="javascript:  needToConfirm = false;" StaticMenuItemStyle-CssClass="menuItems" OnClientClick="javascript: needToConfirm = false;"  StaticMenuStyle-CssClass="navb" StaticSelectedStyle-CssClass="menuItems" ClientIDMode="Static">
                <Items  >  
                    <asp:MenuItem Text="Home" Value="0" Selected="true"/>  
                    <asp:MenuItem  Text="Student" Value="1" />  
                    <asp:MenuItem Text="Teacher" Value="2" />  
                    <asp:MenuItem Text="Volunteer" Value="3" /> 
                    <asp:MenuItem Text="Coordinator" Value="4" />  

                </Items>  
            </asp:Menu>
            <!-- Used Multiview to enable static page load at the beginning in order to boost responsiveness during user interaction-->

            <asp:MultiView ID="MasterMultiView" runat="server"  OnActiveViewChanged="MultiView_ActiveViewChanged" ActiveViewIndex="0">  
               <asp:View runat="server">  
                   <div style="width: 100%; margin-left: 20px; margin-top: 20px; margin-right: 20px;"> 
                       <div class="row row-space">
                          <div class="col-2">
                             <!--Implements home page and dynamic dropdown and viewbox based on event you select -->
                               <div class="input-group">
                                 <asp:Label ID="Label20" CssClass="label" runat="server" Text="Event"></asp:Label>
                                   <asp:SqlDataSource runat="server" 
                                     ID="dtasrcEventList"
                                     DataSourceMode="DataReader"
                                     ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                     SelectCommand="SELECT EventID, EventName FROM Event" />
                                   <asp:DropDownList 
                                     ID="EventList"
                                     DataSourceID="dtasrcEventList" 
                                     DataTextField="EventName" 
                                     DataValueField="EventID" 
                                     AutoPostBack="true" 
                                     OnSelectedIndexChanged="EventList_SelectedIndexChanged"
                                     runat="server"
                                     OnClientClick="javascript: needToConfirm = false;"
                                     CssClass="js-example-basic-single"
                                     Width="50%" />
                                   </div>
                              </div>
                              <div class="col-2">
                                   <!-- Info Display -->
                                   <div class="input-group">
                                      <asp:Label ID="Label22" CssClass="label" runat="server" Text="Event Details"></asp:Label>
                                      <asp:FormView CssClass="container" ID="FormView1" EmptyDataText=" " runat="server"> 

                                        <ItemTemplate>  
                                            <table class="table table-bordered table-striped">  
                                                <tr>  
                                                    <td>Event Name: </td>  
                                                    <td><%#Eval("EventName") %></td>  
                                                </tr>
                                                <tr>  
                                                    <td>Date: </td>  
                                                    <td><%#Eval("Date") %></td>  
                                                </tr>  
                                                <tr>  
                                                    <td>Time: </td>  
                                                    <td><%#Eval("Time") %></td>  
                                                </tr>  
                                                <tr>  
                                                    <td>Room Number: </td>  
                                                    <td><%#Eval("RoomNbr") %></td>  
                                                </tr>  
                                            </table>  
                                        </ItemTemplate>  
                                    </asp:FormView>  

                                    <asp:Repeater ID="CoordinatorRepeater" runat="server">
                                        <ItemTemplate>
                                            <table>
                                                <tr>  
                                                    <td>Coordinator: </td>  
                                                    <td><%# Container.DataItem %></td>  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:Repeater> 

                                    <!-- Repeater Displays all Volunteers-->

                                    <asp:Repeater ID="rep1" runat="server">
                                        <ItemTemplate>
                                            <table>
                                                <tr>  
                                                    <td>Volunteer: </td>  
                                                    <td><%# Container.DataItem %></td>  
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:Repeater>                                
                                   </div>
                                 </div>
                           </div>
                         <!--Displays Students attending event-->
                        <div class="row row-space">
                             <div class="col-2">
                                <div class="input-group">
                                    <asp:Label ID="Label23" CssClass="label" runat="server" Text="Students Attending Event"></asp:Label>
                                    <asp:ListBox ID="ListBox1" CssClass="custom-select" runat="server">
                                    </asp:ListBox>
                                    </div>
                                </div>
                        </div>
                    </div>
               </asp:View>
               <asp:View runat="server"> 
                   <!--New and Existing Student Sub Menus-->
                   <div style="width: 100%; margin-left: 20px; margin-top: 20px; margin-right: 20px;"> 
                    <asp:Menu  
                        ID="menuTabsCurrent"  
                        CssClass="navb"
                        Orientation="Horizontal"  
                        Width="100%"  
                        Text-Align="center"
                        runat="server"  
                        OnMenuItemClick="menuTabsCurrent_MenuItemClick" StaticMenuItemStyle-CssClass="menuItems" StaticMenuStyle-CssClass="navb" StaticSelectedStyle-CssClass="menuItemsg" ClientIDMode="Static">
                        <Items >  
                            <asp:MenuItem  Text="New" Value="0"  Selected="true" />  
                            <asp:MenuItem Text="Existing" Value="1" />  
                        </Items>  
                    </asp:Menu>  
                    <!--Validating and Populable Student input with responsive list selection-->
                    <asp:MultiView ID="multiviewStudent" OnActiveViewChanged="MultiView_ActiveViewChanged" runat="server" ActiveViewIndex="0">  
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;">  
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="FirstName" CssClass="label" runat="server" Text="First Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ValidationGroup="StudentInput" ID="FirstNameTextBox" runat="server" required="true" />
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="LastName" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ValidationGroup="StudentInput" ID="LastNameTextBox" runat="server" required="true" ValidateRequestMode="Inherit" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="Age" CssClass="label" runat="server" Text="Age"></asp:Label>
                                            <asp:DropDownList 
                                                ID="StudentAgeList" 
                                                runat="server"
                                                CssClass="js-example-basic-single"
                                                Width="50%">
                                                <asp:ListItem Value="6" />
                                                <asp:ListItem Value="7" />
                                                <asp:ListItem Value="8" />
                                                <asp:ListItem Value="9" />
                                                <asp:ListItem Value="10" />
                                                <asp:ListItem Value="11" />
                                            </asp:DropDownList>
                                            </div>
                                        </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                         <asp:Label ID="SchoolLabel" CssClass="label" runat="server" Text="School"></asp:Label>
                                            <asp:SqlDataSource runat="server" 
                                               ID="StudentSchoolDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT SchoolID, SchoolName FROM School" />
                                            <asp:DropDownList 
                                                ID="StudentSchoolDropDownList" 
                                                DataSourceID="StudentSchoolDataSource" 
                                                DataTextField="SchoolName" 
                                                DataValueField="SchoolID" 
                                                AutoPostBack="true" 
                                                OnSelectedIndexChanged="StudentSchool_SelectedIndexChanged"
                                                CssClass="js-example-basic-single"
                                                Width="50%"
                                                runat="server"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                         <asp:Label ID="TeacherLabel" CssClass="label" runat="server" Text="Teacher"></asp:Label>
                                            <!--Generated Dynamically in C# code based on school selection-->
                                            <asp:DropDownList 
                                                ID="StudentTeacherDropDownList" 
                                                AutoPostBack="true" 
                                                CssClass="js-example-basic-single"
                                                Width="50%"
                                                runat="server"/>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                             <asp:Label ID="TshirtLabel" CssClass="label" runat="server" Text="T-shirt Size"></asp:Label>
                                        <asp:DropDownList 
                                            ID="TshirtList" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Small" />
                                            <asp:ListItem Value="Medium" />
                                            <asp:ListItem Value="Large" />
                                        </asp:DropDownList>
                                    </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="TshirtColor" CssClass="label" runat="server" Text="T-shirt Color"></asp:Label>
                                                <asp:DropDownList 
                                                    ID="TshirtColorList" 
                                                    runat="server"
                                                    CssClass="js-example-basic-single"
                                                    Width="50%">
                                                    <asp:ListItem Value="Green" />
                                                    <asp:ListItem Value="Blue" />
                                                    <asp:ListItem Value="Red" />
                                                </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="NotesLable" CssClass="label" runat="server" Text="Notes"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="NotesTextBox" runat="server" required="true" ValidationGroup="StudentInput" />
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            <!--Button options for Submit, Commit Populate and Reset Distinguishable-->
                            <div class="p-t-15">
                                    <asp:Button ID="SubmitButton" runat="server" OnClick="AddStudent_Click" Text="Submit" CssClass="btn btn--radius-2 btn--blue"/>
                                </div> 
                            <div class="p-t-15">
                                    <asp:Button ID="PopulateButton" runat="server" OnClick="PopulateText_Click" ValidationGroup="StudentInput" CausesValidation="False" Text="Populate" CssClass="btn btn--radius-2 btn--green" ValidateRequestMode="Inherit" UseSubmitBehavior="False" />
                                </div> 
                            <div class="p-t-15">
                                    <asp:Button ID="ResetButton" runat="server" OnClick="ResetButton_Click"  ValidationGroup="StudentInput" CausesValidation="False" Text="Reset" UseSubmitBehavior="False" CssClass="btn btn--radius-2 btn--red"/>
                                </div> 
                        </asp:View>  
                        <asp:View runat="server"> 
                            <script type="text/javascript">
                                            $(document).ready(function() {
                                              $(".js-example-basic-single").select2();
                                            });
                            </script>
                            <div style="margin-top: 40px;">  
                                <div class="input-group">
                                    <!--Student Dropdown allows for profile data viewing-->
                                    <asp:Label ID="StudentNameLabel" CssClass="label" runat="server" Text="Student Name"></asp:Label>
                                    <asp:SqlDataSource runat="server" 
                                               ID="StudentNameDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT StudentID, FirstName +' ' + LastName as StudentName FROM Student" />
                                        <asp:DropDownList ID="StudentNameDDL"
                                            DataSourceID="StudentNameDataSource" 
                                            DataTextField="StudentName" 
                                            DataValueField="StudentID" 
                                            AutoPostBack="true" 
                                            OnSelectedIndexChanged="StudentNameDDL_SelectedIndexChanged"
                                            runat="server"
                                            Width="50%" 
                                            CssClass="js-example-basic-single" />
                                </div>
                                <div class="input-group">
                                    <asp:FormView ID="StudentFormView" runat="server">
                                         <ItemTemplate>  
                                            <table >  
                                                <tr>  
                                                    <td>Student Name:    </td>  
                                                    <td><%#Eval("StudentName") %></td>  
                                                </tr>
                                                <tr>  
                                                    <td>Age: </td>  
                                                    <td><%#Eval("Age") %></td>  
                                                </tr>  
                                                <tr>  
                                                    <td>Notes: </td>
                                                    <td><%#Eval("Notes") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>School: </td>  
                                                    <td><%#Eval("SchoolName") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Teacher: </td>
                                                    <td><%#Eval("TeacherName") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Tshirt Color: </td>  
                                                    <td><%#Eval("Color") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Tshirt Size: </td>
                                                    <td><%#Eval("Size") %></td>  

                                                </tr> 
                                            </table>  
                                        </ItemTemplate>  
                                    </asp:FormView>
                                </div>
                            </div>  
                        </asp:View>  
                    </asp:MultiView>  
                   </div>  
               </asp:View>
               <asp:View runat="server">
                   <div style="width: 100%; margin-left: 20px; margin-top: 50px; margin-right: 20px;"> 
                    <asp:Menu  
                        ID="TeacherMenu"  
                        CssClass="navb"
                        Orientation="Horizontal"  
                        Width="100%"  
                        Text-Align="center"
                        runat="server"  
                        OnMenuItemClick="TeacherMenu_MenuItemClick" StaticMenuItemStyle-CssClass="menuItems" StaticMenuStyle-CssClass="navb" StaticSelectedStyle-CssClass="menuItems" ClientIDMode="Static">
                        <Items >  
                            <asp:MenuItem  Text="New" Value="0"  Selected="true" />  
                            <asp:MenuItem Text="Existing" Value="1" />  
                        </Items>  
                    </asp:Menu> 
                    <!--Teacher Input Extra Functionality-->
                    <asp:MultiView ID="TeacherView" runat="server" ActiveViewIndex="0">  
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;">  
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="TeacherFirstName" CssClass="label" runat="server" Text="First Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TeacherFirstNameText" required="true" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="TeacherLastName" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TeacherLastNameInput" required="true" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    
                                    <div class="col-2">
                                        <div class="input-group">
                                         <asp:Label ID="TeacherSchoolLabel" CssClass="label" runat="server" Text="School"></asp:Label>

                                            <asp:DropDownList 
                                                ID="TeacherSchoolList" 
                                                 DataSourceID="StudentSchoolDataSource" 
                                                DataTextField="SchoolName" 
                                                DataValueField="SchoolID" 
                                                AutoPostBack="true" 
                                                runat="server"
                                                CssClass="js-example-basic-single"
                                                Width="50%" />
                                          </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                             <asp:Label ID="Label6" CssClass="label" runat="server" Text="T-shirt Size"></asp:Label>
                                        <asp:DropDownList 
                                            ID="TeacherTshirtSize" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Small" />
                                            <asp:ListItem Value="Medium" />
                                            <asp:ListItem Value="Large" />
                                        </asp:DropDownList>
                                    </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                <div class="input-group">
                                    <asp:Label ID="Label7" CssClass="label" runat="server" Text="T-shirt Color"></asp:Label>
                                        <asp:DropDownList 
                                            ID="TeacherTshirtColor" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Green" />
                                            <asp:ListItem Value="Blue" />
                                            <asp:ListItem Value="Red" />
                                        </asp:DropDownList>
                                </div>
                                </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="TeacherNoteLabel" CssClass="label" runat="server" Text="Notes"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TeacherNoteTextBox" required="true" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="Label24" CssClass="label" runat="server" Text="Email"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="EmailTextBox" runat="server" required="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Same button functions outside of commit in order to streamline process-->
                                <div class="p-t-15">
                                    <asp:Button ID="SubmitTeacher" runat="server" OnClick="AddTeacher_Click" Text="Submit" CssClass="btn btn--radius-2 btn--blue"/>
                                </div> 
                            <div class="p-t-15">
                                    <asp:Button ID="PopulateTeacher" runat="server" OnClick="PopulateTextTeacher_Click"  CausesValidation="False" Text="Populate" CssClass="btn btn--radius-2 btn--green"  UseSubmitBehavior="False" />
                                </div> 
                            <div class="p-t-15">
                                    <asp:Button ID="ResetTeacher" runat="server" OnClick="ResetTeacherButton_Click"   CausesValidation="False" Text="Reset" UseSubmitBehavior="False" CssClass="btn btn--radius-2 btn--red"/>
                                </div> 
                        </asp:View>  
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;"> 
                               <div style="margin-top: 40px;">  
                                <div class="input-group">
                                    <asp:Label ID="Label1" CssClass="label" runat="server" Text="Teacher Name"></asp:Label>
                                    <!--Existing Teacher Selection Menu and Info Display-->
                                    <asp:SqlDataSource runat="server" 
                                               ID="SqlTeacherDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT TeacherID, FirstName +' ' + LastName as TeacherName FROM Teacher" />
                                        <asp:DropDownList ID="TeacherNameDDL"
                                            DataSourceID="SqlTeacherDataSource" 
                                            DataTextField="TeacherName" 
                                            DataValueField="TeacherID" 
                                            AutoPostBack="true" 
                                            OnSelectedIndexChanged="TeacherNameDDL_SelectedIndexChanged"
                                            runat="server"
                                            Width="50%" 
                                            CssClass="js-example-basic-single" />
                                </div>
                                <div class="input-group">
                                    <asp:FormView ID="TeacherFormView" runat="server">
                                         <ItemTemplate>  
                                            <table >  
                                                <tr>  
                                                    <td>Teacher Name:    </td>  
                                                    <td><%#Eval("TeacherName") %></td>  
                                                </tr>
                                                <tr>  
                                                    <td>Email: </td>  
                                                    <td><%#Eval("Email") %></td>  
                                                </tr>  
                                                <tr>  
                                                    <td>Notes: </td>
                                                    <td><%#Eval("Notes") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>School: </td>  
                                                    <td><%#Eval("SchoolName") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Tshirt Color: </td>
                                                    <td><%#Eval("Color") %></td>  
                                                </tr> 
                                                <tr>  
                                                    <td>Tshirt Size: </td>
                                                    <td><%#Eval("Size") %></td>  
                                                </tr>  
                                            </table>  
                                        </ItemTemplate>  
                                    </asp:FormView>
                                </div>
                            </div> 
                                <div class="input-group">
                                    <!--Interacts with backend allows DB and user interaction in a straightforward user friendly manner-->
                                    <h2>Event List</h2>
                                        <asp:SqlDataSource runat="server" 
                                               ID="EventDateDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT FORMAT(Date,'yyyy-MM-dd') as Date FROM Event group by Date" />
                                        <asp:DropDownList ID="EventDateDDL"
                                            DataSourceID="EventDateDataSource" 
                                            DataTextField="Date" 
                                            DataValueField="Date" 
                                            OnSelectedIndexChanged="EventDateDDL_SelectedIndexChanged"
                                            AutoPostBack="true" 
                                            runat="server"
                                            Width="50%"
                                            CssClass="js-example-basic-single"
                                            AppendDataBoundItems="true"
                                             >
                                            <asp:ListItem Text="select " Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                </div>
                                <div class="input-group">
                                <fieldset>
                                    <h2>Activities List</h2>
	                                    <div class="checkbox checkboxlist">
                                            <asp:CheckBoxList ID="CheckBoxList1" CssClass="radio-container" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" />
                                        </div>
                                 </fieldset>
                                 </div>
                            </div>  
                        </asp:View>  
                    </asp:MultiView>  
                  </div>
               </asp:View>
                <asp:View runat="server">
                   <div style="width: 100%; margin-left: 20px; margin-top: 50px; margin-right: 20px;">
                       <!--Input Template for Volunteer generation not connected to back end DB-->
                    <asp:Menu  
                        ID="VolunteerMenu"  
                        CssClass="navb"
                        Orientation="Horizontal"  
                        Width="100%"  
                        Text-Align="center"
                        runat="server"  
                        OnMenuItemClick="VolunteerMenu_MenuItemClick" StaticMenuItemStyle-CssClass="menuItems" StaticMenuStyle-CssClass="navb" StaticSelectedStyle-CssClass="menuItems" ClientIDMode="Static">
                        <Items >  
                            <asp:MenuItem  Text="New" Value="0"  Selected="true" />  
                            <asp:MenuItem Text="Existing" Value="1" />  
                        </Items>  
                    </asp:Menu> 
                    <asp:MultiView ID="VolunteerMultiview" runat="server" ActiveViewIndex="0">  
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;">  
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="VolunteerFirstName" CssClass="label" runat="server" Text="First Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TextBox1" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="VolunteerLastName" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TextBox2" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                                <asp:Label ID="Label10" CssClass="label" runat="server" Text="T-shirt Size"></asp:Label>
                                                <asp:DropDownList 
                                                    ID="VolunteerTshirtList" 
                                                    runat="server"
                                                    CssClass="js-example-basic-single"
                                                    Width="50%">
                                                    <asp:ListItem Value="Small" />
                                                    <asp:ListItem Value="Medium" />
                                                    <asp:ListItem Value="Large" />
                                                </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                <div class="input-group">
                                    <asp:Label ID="VolunteerTshirtColorLabel" CssClass="label" runat="server" Text="T-shirt Color"></asp:Label>
                                        <asp:DropDownList 
                                            ID="VolunteerTshirtColor" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Green" />
                                            <asp:ListItem Value="Blue" />
                                            <asp:ListItem Value="Red" />
                                        </asp:DropDownList>
                                         </div>
                                </div>
                                </div>
                            </div>
                                <div class="p-t-15">
                                    <asp:Button ID="VolunteerSubmit" runat="server" Text="Submit" CssClass="btn btn--radius-2 btn--blue"/>
                                </div> 
                        </asp:View>  
                        <!--Volunteer Selection and Info Display-->
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;"> 
                                <asp:Label ID="Label2" CssClass="label" runat="server" Text="Volunteer Name"></asp:Label>
                                    <asp:SqlDataSource runat="server" 
                                               ID="VolunteerListDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT VolunteerID, FirstName +' ' + LastName as VolunteerName FROM EventPersonnel where PersonnelType='Volunteer'" />
                                        <asp:DropDownList ID="VolunteerNameDDL"
                                            DataSourceID="VolunteerListDataSource" 
                                            DataTextField="VolunteerName" 
                                            DataValueField="VolunteerID" 
                                            AutoPostBack="true" 
                                            OnSelectedIndexChanged="VolunteerNameDDL_SelectedIndexChanged"
                                            runat="server"
                                            Width="50%" 
                                            CssClass="js-example-basic-single" />
                                </div>
                                <div class="input-group">
                                    <asp:FormView ID="VolunteerFormView" runat="server">
                                         <ItemTemplate>  
                                            <table >  
                                                <tr>  
                                                    <td>Volunteer Name:    </td>  
                                                    <td><%#Eval("VolunteerName") %></td>  
                                                </tr>
                                                <tr>  
                                                    <td>Notes: </td>
                                                    <td><%#Eval("Notes") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Tshirt Color: </td>
                                                    <td><%#Eval("Color") %></td>  
                                                </tr> 
                                                <tr>  
                                                    <td>Tshirt Size: </td>
                                                    <td><%#Eval("Size") %></td>  
                                                </tr>  
                                            </table>  
                                        </ItemTemplate>  
                                    </asp:FormView>
                                </div>
                               <div class="input-group">
                                <fieldset>
                                <!--Javascript sign up recommended cap implemented as User interacts with the system-->
                                <script>
                                    // javascript to add to your aspx page
                                        function ValidateModuleList(source, args)
                                        {
                                          var tot = 0;
                                          var chkListModules= document.getElementById('<%=VolunteerEventCheckBoxList.ClientID %>');
                                          var chkListinputs = chkListModules.getElementsByTagName("input");
                                          for (var i=0; i< chkListinputs.length; i++)
                                          {
                                            if (chkListinputs[i].checked)
                                            {
                                                ++tot;
                                                if (tot == 2) {
                                                    $('input[id~=chkList]:checkbox').attr('disabled', 'disabled');
                                                }
                                                if (tot > 2) {
                                                    args.IsValid = false;
                                                    return false;
                                                }
                                              
                                            }
                                          }
                                          args.IsValid = true;
                                    }
                                  </script>
                                    <!--Activity Check box list generated from backend-->
                                     <h2>Activities List</h2>
	                                    <div class="checkbox checkboxlist">
                                            <asp:CheckBoxList ID="VolunteerEventCheckBoxList"  CssClass="radio-container" OnSelectedIndexChanged="VolunteerEventCheckBoxList_SelectedIndexChanged" onClientClick="javascript: CheckCheck();" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" CausesValidation="True" ValidationGroup="JScript" />
                                        </div>
                                    <asp:CustomValidator ID="VolunteerValidator" runat="server" ErrorMessage="It is recommended select a maximum of 2 options" ClientValidationFunction="ValidateModuleList" ValidationGroup="JScript" SetFocusOnError="True" Font-Bold="True"></asp:CustomValidator>
                                 </fieldset>
                                </div> 
                        </asp:View>  
                    </asp:MultiView>  
                  </div>
               </asp:View>
            <asp:View runat="server">
                   <div style="width: 100%; margin-left: 20px; margin-top: 50px; margin-right: 20px;"> 
                    <asp:Menu  
                        ID="CoordinatorMenu"  
                        CssClass="navb"
                        Orientation="Horizontal"  
                        Width="100%"  
                        Text-Align="center"
                        runat="server"  
                        OnMenuItemClick="CoordinatorMenu_MenuItemClick" StaticMenuItemStyle-CssClass="menuItems" StaticMenuStyle-CssClass="navb" StaticSelectedStyle-CssClass="menuItems" ClientIDMode="Static">
                        <Items >  
                            <asp:MenuItem  Text="New" Value="0"  Selected="true" />  
                            <asp:MenuItem Text="Existing" Value="1" />  
                        </Items>  
                    </asp:Menu> 
                    <!--Coordinator Menu and stand alone insert template-->
                    <asp:MultiView ID="CoordinatorMultiView" runat="server" ActiveViewIndex="0">  
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;">  
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="Label5" CssClass="label" runat="server" Text="First Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TextBox3" runat="server" />
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <div class="input-group">
                                            <asp:Label ID="Label8" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                                            <asp:TextBox CssClass="input--style-4" ID="TextBox4" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-space">
                                    <div class="col-2">
                                        <div class="input-group">
                                             <asp:Label ID="Label11" CssClass="label" runat="server" Text="T-shirt Size"></asp:Label>
                                        <asp:DropDownList 
                                            ID="DropDownList4" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Small" />
                                            <asp:ListItem Value="Medium" />
                                            <asp:ListItem Value="Large" />
                                        </asp:DropDownList>
                                        </div>
                                    </div>
                                <div class="col-2">

                                <div class="input-group">
                                    <asp:Label ID="Label15" CssClass="label" runat="server" Text="T-shirt Color"></asp:Label>
                                        <asp:DropDownList 
                                            ID="DropDownList5" 
                                            runat="server"
                                            CssClass="js-example-basic-single"
                                            Width="50%">
                                            <asp:ListItem Value="Green" />
                                            <asp:ListItem Value="Blue" />
                                            <asp:ListItem Value="Red" />
                                        </asp:DropDownList>

                                </div>
                            </div>
                            </div>
                            </div>
                                <div class="p-t-15">
                                    <asp:Button ID="CoordinatorSubmit" runat="server" Text="Submit" CssClass="btn btn--radius-2 btn--blue"/>
                                </div> 
                        </asp:View>  
                        <!--Coordinator info and activity sign up interacts with DB-->
                        <asp:View runat="server">  
                            <div style="margin-top: 40px;"> 
                                <div style="margin-top: 40px;"> 
                                <asp:Label ID="CoordinatorNameLabel" CssClass="label" runat="server" Text="Coordinator Name"></asp:Label>
                                    <asp:SqlDataSource runat="server" 
                                               ID="CoordinatorListDataSource"
                                               DataSourceMode="DataReader"
                                               ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                               SelectCommand="SELECT VolunteerID, FirstName +' ' + LastName as CoordinatorName FROM EventPersonnel where PersonnelType='Coordinator'" />
                                        <asp:DropDownList ID="CoordinatorNameDDL"
                                            DataSourceID="CoordinatorListDataSource" 
                                            DataTextField="CoordinatorName" 
                                            DataValueField="VolunteerID" 
                                            AutoPostBack="true" 
                                            OnSelectedIndexChanged="CoordinatorNameDDL_SelectedIndexChanged"
                                            runat="server"
                                            Width="50%" 
                                            CssClass="js-example-basic-single" />
                                </div>
                                <div class="input-group">
                                    <asp:FormView ID="CoordinatorFormView" runat="server">
                                         <ItemTemplate>  
                                            <table >  
                                                <tr>  
                                                    <td>Coordinator Name:    </td>  
                                                    <td><%#Eval("CoordinatorName") %></td>  
                                                </tr>
                                                <tr>  
                                                    <td>Notes: </td>
                                                    <td><%#Eval("Notes") %></td>  

                                                </tr>  
                                                <tr>  
                                                    <td>Tshirt Color: </td>
                                                    <td><%#Eval("Color") %></td>  
                                                </tr> 
                                                <tr>  
                                                    <td>Tshirt Size: </td>
                                                    <td><%#Eval("Size") %></td>  
                                                </tr>  
                                            </table>  
                                        </ItemTemplate>  
                                    </asp:FormView>
                                </div>
                                <div class="input-group">
                                <fieldset>
                                     <h2>Activities List</h2>
	                                    <div class="checkbox checkboxlist">
                                            <asp:CheckBoxList ID="CoordinatorCheckBoxList"  CssClass="radio-container" OnSelectedIndexChanged="CoordinatorEventCheckBoxList_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" />
                                        </div>
                                 </fieldset>
                                </div> 
                                <!--Event Creation Functionality UI hidden until it is connected to back end-->
                                <div class="input-group" hidden="hidden">
                                    <h2>Event Creation</h2>
                                        <asp:Label ID="EventNameLabel" CssClass="label"  runat="server" Text="Event Name"></asp:Label>
                                        <asp:TextBox ID="EventName"  CssClass="input--style-4" runat="server"></asp:TextBox>
                                        <asp:Label ID="EventDateLabel" CssClass="label" runat="server" Text="Event Date"></asp:Label>
                                        <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                                </div>
                                <div class="input-group" hidden="hidden">
                                    <div class="p-t-10">
                                    <asp:Label ID="EventTimeLabel" runat="server" CssClass="label" Text="Event Time"></asp:Label>
                                    <asp:RadioButtonList ID="EventTime" CssClass="radio-container"  runat="server">
                                        <asp:ListItem Text="9am" />
                                        <asp:ListItem Text="10am" />
                                        <asp:ListItem Text="11am" />
                                        <asp:ListItem Text="12pm" />
                                        <asp:ListItem Text="1pm" />
                                        <asp:ListItem Text="2pm" />
                                        <asp:ListItem Text="3pm" />
                                        <asp:ListItem Text="4pm" />
                                    </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>  
                        </asp:View>  
                    </asp:MultiView>  
                  </div>
               </asp:View>
            </asp:MultiView>
          </form>
         </div>
    </div>
   </div>
  </div>




</body>

</html>
