<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="CIS484Solution1.WebForm2" %>

<%@ Import Namespace="System.Data" %>

<asp:Content ID="Home" ContentPlaceHolderID="HomePlaceholder" runat="server">
    <!-- John Wehner Max Vaughan -->
    <div class="container" style="width: 100%; margin-left: 20px; margin-top: 20px; margin-right: 20px;">
        <!-- Card -->
        <div class="card map-card">

            <!--Google map-->
            <div id="map-container-google-1" class="z-depth-1-half map-container" style="height: 500px">
                <iframe src="https://maps.google.com/maps?q=manhatan&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0"
                    style="border: 0" allowfullscreen></iframe>
            </div>

            <!-- Card content -->
            <div class="card-body closed px-0">

                <div class="button px-2 mt-3">
                    <a class="btn-floating btn-lg living-coral float-right"><i class="fas fa-bicycle"></i></a>
                </div>

                <div class="white px-4 pb-4 pt-3-5">

                    <!-- Title -->
                    <h5 class="card-title h5 living-coral-text">Harrisonburg CARES</h5>

                    <div class="d-flex justify-content-between living-coral-text">
                        <h6 class="card-subtitle font-weight-light">A place to relax</h6>
                        <h6 class="font-small font-weight-light mt-n1">25 min</h6>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between pt-2 mt-1 text-center text-uppercase living-coral-text">
                        <div>
                            <i class="fas fa-phone fa-lg mb-3"></i>
                            <p class="mb-0">Call</p>
                        </div>
                        <div>
                            <i class="fas fa-cat fa-lg mb-3"></i>
                            <p class="mb-0">Love</p>
                        </div>
                        <div>
                            <i class="far fa-grin-beam-sweat fa-lg mb-3"></i>
                            <p class="mb-0">Smile</p>
                        </div>
                    </div>

                    <hr>

                    <table class="table table-borderless">
                        <tbody>
                            <tr>
                                <th scope="row" class="px-0 pb-3 pt-2">
                                    <i class="fas fa-map-marker-alt living-coral-text"></i>
                                </th>
                                <td class="pb-3 pt-2">East 64th Street, Harrisonburg, VA 10021, US</td>
                            </tr>
                            <tr class="mt-2">
                                <th scope="row" class="px-0 pb-3 pt-2">
                                    <i class="far fa-clock living-coral-text"></i>
                                </th>
                                <td class="pb-3 pt-2"><span class="deep-purple-text mr-2">Closed</span> Opens 10 AM</td>
                            </tr>
                            <tr class="mt-2">
                                <th scope="row" class="px-0 pb-3 pt-2">
                                    <i class="fas fa-cloud-moon living-coral-text"></i>
                                </th>
                                <td class="pb-3 pt-2">Sunny weather tomorrow</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="NewStudent" ContentPlaceHolderID="NewStudentPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="FirstName" CssClass="label" runat="server" Text="First Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="StudentInput" ID="FirstNameTextBox" runat="server" required="true" />
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="LastName" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="StudentInput" ID="LastNameTextBox" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="w-100"></div>
                    <div class="col">
                        <div class="form-group">
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
                    <div class="col">
                        <div class="form-group">
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
                                runat="server" />
                        </div>
                    </div>
                    <div class="w-100"></div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="TeacherLabel" CssClass="label" runat="server" Text="Teacher"></asp:Label>
                            <!--Generated Dynamically in C# code based on school selection-->
                            <asp:DropDownList
                                ID="StudentTeacherDropDownList"
                                AutoPostBack="true"
                                CssClass="js-example-basic-single"
                                Width="50%"
                                runat="server" />
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
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
                    <div class="w-100"></div>
                    <div class="col">
                        <div class="form-group">
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
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="NotesLable" CssClass="label" runat="server" Text="Notes"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="NotesTextBox" runat="server" required="true" ValidationGroup="StudentInput" />
                        </div>
                    </div>
                </div>
            </div>
            <!--Button options for Submit, Commit Populate and Reset Distinguishable-->
            <div class="container">
                <div class="row">
                    <div class="col-sm text-left">
                        <asp:Button ID="SubmitButton" runat="server" OnClick="AddStudent_Click" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                    </div>
                    <div class="col-sm text-center">
                        <asp:Button ID="PopulateButton" runat="server" OnClick="PopulateText_Click" ValidationGroup="StudentInput" CausesValidation="False" Text=" Fill " CssClass="btn btn-success" ValidateRequestMode="Inherit" UseSubmitBehavior="False" />
                    </div>
                    <div class="col-sm text-right">
                        <asp:Button ID="ResetButton" runat="server" OnClick="ResetButton_Click" ValidationGroup="StudentInput" CausesValidation="False" Text="Reset" UseSubmitBehavior="False" CssClass="btn btn-danger" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="StudentExisting" ContentPlaceHolderID="StudentExistingPlaceholder" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".js-example-basic-single").select2();
        });
    </script>
    <div style="margin-top: 40px;">
        <div class="container-fluid">
            <div class="grid">

                <div class="grid-item">
                    <div class="form-group">
                        <asp:Label ID="Label5" CssClass="label" runat="server" Text="Event"></asp:Label>
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
                            CssClass="js-example-basic-single" />
                    </div>
                </div>
                <div class="grid-item grid-item--width2 grid-item--height3">
                    <!-- Info Display -->
                    <div class="form-group">
                        <asp:Label ID="Label8" CssClass="label" runat="server" Text="Event Details"></asp:Label>
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
                    </div>
                </div>
                <div class="grid-item grid-item--height2">
                    <h4>Coordinator: </h4>
                    <asp:Repeater ID="CoordinatorRepeater" runat="server">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td><%# Container.DataItem %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                    <!-- Repeater Displays all Volunteers-->
                    <h4>Volunteer: </h4>
                    <asp:Repeater ID="rep1" runat="server">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td><%# Container.DataItem %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="grid-item grid-item--width2 grid-item--height2 ">
                    <div class="form-group">
                        <asp:Label ID="Label9" CssClass="label" runat="server" Text="Students Attending Event"></asp:Label>
                        <asp:ListBox ID="ListBox1" CssClass="custom-select" runat="server"></asp:ListBox>
                    </div>
                </div>

                <div class="grid-item">
                    <div class="form-group">
                        <!--Student Dropdown allows for profile data viewing-->
                        <asp:Label ID="StudentNameLabel" CssClass="label" runat="server" Text="Student Name"></asp:Label>
                        <asp:SqlDataSource runat="server"
                            ID="StudentNameDataSource"
                            DataSourceMode="DataReader"
                            ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                            SelectCommand="SELECT StudentID, TRIM(FirstName +' ' + LastName) as StudentName FROM Student" />
                        <asp:DropDownList ID="StudentNameDDL"
                            DataSourceID="StudentNameDataSource"
                            DataTextField="StudentName"
                            DataValueField="StudentID"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="StudentNameDDL_SelectedIndexChanged"
                            runat="server"
                            Width="100%"
                            CssClass="js-example-basic-single" />
                    </div>
                </div>
                <div class="grid-item grid-item--height2 grid-item--width2" style="align-items: flex-end">
                    <div class="form-group">
                        <table class="table table-bordered table-striped" style="margin-left: 5px">
                            <tr>
                                <td>Name:    </td>
                                <td>
                                    <asp:Label ID="StudentNameData" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Age: </td>
                                <td>
                                    <asp:DropDownList
                                        ID="StudentAgeEdit"
                                        runat="server"
                                        CssClass="js-example-basic-single"
                                        Width="50%">
                                        <asp:ListItem Value="6" />
                                        <asp:ListItem Value="7" />
                                        <asp:ListItem Value="8" />
                                        <asp:ListItem Value="9" />
                                        <asp:ListItem Value="10" />
                                        <asp:ListItem Value="11" />
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td>Notes: </td>
                                <td>
                                    <asp:TextBox ID="StudentNotesData" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>School: </td>
                                <td>
                                    <asp:Label ID="StudentSchoolData" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Teacher: </td>
                                <td>
                                    <asp:Label ID="StudentTeacherData" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Tshirt Color: </td>
                                <td>
                                    <asp:DropDownList
                                        ID="StudentColorEdit"
                                        runat="server"
                                        CssClass="js-example-basic-single"
                                        Width="50%">
                                        <asp:ListItem Value="Green" />
                                        <asp:ListItem Value="Blue" />
                                        <asp:ListItem Value="Red" />
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td>Tshirt Size: </td>
                                <td>
                                    <asp:DropDownList
                                        ID="StudentSizeEdit"
                                        runat="server"
                                        CssClass="js-example-basic-single"
                                        Width="50%">
                                        <asp:ListItem Value="Small" />
                                        <asp:ListItem Value="Medium" />
                                        <asp:ListItem Value="Large" />
                                    </asp:DropDownList></td>
                            </tr>
                        </table>
                        <asp:FormView ID="StudentFormView" runat="server">
                            <ItemTemplate>
                                <table class="table table-bordered table-striped" style="margin-left: 5px">
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

                <div class="grid-item">
                    <asp:Button ID="StudentUpdateButton" runat="server" OnClick="StudentUpdateButton_Click" Style="padding-top: 0%; padding-bottom: 0%;" CssClass="btn btn-primary btn-sm" Text="Update" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<%--<asp:Content ID="TeacherNew" ContentPlaceHolderID="TeacherNewPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="TeacherFirstName" CssClass="label" runat="server" Text="First Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="TeacherFirstNameText" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                ControlToValidate="TeacherFirstNameText"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Name."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="TeacherLastName" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="TeacherLastNameInput" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                ControlToValidate="TeacherLastNameInput"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Name."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">

                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="TeacherSchoolLabel" CssClass="label" runat="server" Text="School"></asp:Label>
                            <asp:SqlDataSource runat="server"
                                ID="TeacherSchoolDataSource"
                                DataSourceMode="DataReader"
                                ConnectionString="<%$ ConnectionStrings:dbconnection%>"
                                SelectCommand="SELECT SchoolID, SchoolName FROM School" />
                            <asp:DropDownList
                                ID="TeacherSchoolList"
                                DataSourceID="TeacherSchoolDataSource"
                                DataTextField="SchoolName"
                                DataValueField="SchoolID"
                                AutoPostBack="true"
                                runat="server"
                                CssClass="js-example-basic-single"
                                Width="50%" />
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
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
                <div class="row">
                    <div class="col">
                        <div class="form-group">
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
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="TeacherNoteLabel" CssClass="label" runat="server" Text="Notes"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="TeacherNoteTextBox" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                ControlToValidate="TeacherNoteTextBox"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Notes."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label24" CssClass="label" runat="server" Text="Email"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="EmailTextBox" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                                ControlToValidate="EmailTextBox"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Email."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="label" runat="server" Text="Grade"></asp:Label>
                            <asp:DropDownList
                                ID="GradeDDL"
                                runat="server"
                                CssClass="js-example-basic-single"
                                Width="50%">
                                <asp:ListItem Value="6" />
                                <asp:ListItem Value="7" />
                                <asp:ListItem Value="8" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="md-form form-sm mb-5">
                        <i class="fas fa-lock prefix"></i>
                        <asp:Label ID="Label4" CssClass="label" runat="server" Text="Password" AssociatedControlID="modalLRInput14" />
                        <asp:TextBox CssClass="form-control form-control-sm validate" type="password" ID="modalLRInput14" CausesValidation="false" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                            ControlToValidate="modalLRInput14"
                            ValidationGroup="SignUpGroup"
                            ErrorMessage="Enter Email."
                            runat="Server">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <!--Same button functions outside of commit in order to streamline process-->
            <div class="container">
                <div class="row text-center form-sm">
                    <asp:Button ID="SubmitTeacher" runat="server" OnClick="AddTeacher_Click" ValidationGroup="SignUpGroup" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-info" />
                </div>
                <div class="row text-center form-sm">
                    <asp:Button ID="PopulateTeacher" runat="server" OnClick="PopulateTextTeacher_Click" CausesValidation="False" Text=" Fill " CssClass="btn btn-success" UseSubmitBehavior="False" />
                </div>
                <div class="row text-center form-sm">
                    <asp:Button ID="ResetTeacher" runat="server" OnClick="ResetTeacherButton_Click" CausesValidation="False" Text="Reset" UseSubmitBehavior="False" CssClass="btn btn-danger" />
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TeacherSchoolList" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>--%>
<asp:Content ID="NewStaff" ContentPlaceHolderID="NewStaffPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label10" CssClass="label" runat="server" Text="First Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="StaffFirstName" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                                ControlToValidate="StaffFirstName"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Name."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label11" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="StaffLastName" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7"
                                ControlToValidate="StaffLastName"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Name."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label12" CssClass="label" runat="server" Text="Location"></asp:Label>
                            <asp:SqlDataSource runat="server"
                                ID="StaffLocationDataSource"
                                DataSourceMode="DataReader"
                                ConnectionString="<%$ ConnectionStrings:CARESconnection%>"
                                SelectCommand="SELECT LocationID, LocationName FROM Location" />
                            <asp:DropDownList
                                ID="StaffLocationDDL"
                                DataSourceID="StaffLocationDataSource"
                                DataTextField="LocationName"
                                DataValueField="LocationID"
                                AutoPostBack="true"
                                runat="server"
                                CssClass="js-example-basic-single"
                                Width="50%" />
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label14" CssClass="label" runat="server" Text="Email"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ID="StaffEmail" runat="server" CausesValidation="false" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11"
                                ControlToValidate="StaffEmail"
                                ValidationGroup="SignUpGroup"
                                ErrorMessage="Enter Email."
                                runat="Server">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <asp:Image ID="Image1" runat="server" />
                            <asp:FileUpload ID="ImageUpload" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="md-form form-sm mb-5">
                        <i class="fas fa-lock prefix"></i>
                        <asp:Label ID="Label18" CssClass="label" runat="server" Text="Password" AssociatedControlID="modalLRInput13" />
                        <asp:TextBox CssClass="form-control form-control-sm validate" type="password" ID="modalLRInput13" CausesValidation="false" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10"
                            ControlToValidate="modalLRInput13"
                            ValidationGroup="SignUpGroup"
                            ErrorMessage="Enter Password."
                            runat="Server">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <!--Same button functions outside of commit in order to streamline process-->
            <div class="container">
                <div class="row text-center form-sm">
                    <asp:Button ID="SubmitAdmin" runat="server" OnClick="AddAdmin_Click" ValidationGroup="SignUpGroup" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-info" />
                </div>
                <div class="row text-center form-sm">
                    <%--<asp:Button ID="PopulateAdmin" runat="server" OnClick="PopulateTextTeacher_Click" CausesValidation="False" Text=" Fill " CssClass="btn btn-success" UseSubmitBehavior="False" />--%>
                </div>
                <div class="row text-center form-sm">
                    <%--<asp:Button ID="ResetAdmin" runat="server" OnClick="ResetTeacherButton_Click" CausesValidation="False" Text="Reset" UseSubmitBehavior="False" CssClass="btn btn-danger" />--%>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitAdmin" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="TeacherExisting" ContentPlaceHolderID="TeacherExistingPlaceholder" runat="server">
    <div style="margin-top: 40px;">
        <div style="margin-top: 40px;">
            <div class="form-group">
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
            <div class="form-group">
                <asp:FormView ID="TeacherFormView" runat="server">
                    <ItemTemplate>
                        <table>
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
        <div class="form-group">
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
                AppendDataBoundItems="true">
                <asp:ListItem Text="select " Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <fieldset>
                <h2>Activities List</h2>
                <div class="checkbox checkboxlist">
                    <asp:CheckBoxList ID="CheckBoxList1" CssClass="radio-container" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>

<asp:Content ID="VolunteerExisting" ContentPlaceHolderID="VolunteerExistingPlaceholder" runat="server">

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
    <div class="form-group">
        <asp:FormView ID="VolunteerFormView" runat="server">
            <ItemTemplate>
                <table>
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
    <div class="form-group">
        <fieldset>
            <!--Javascript sign up recommended cap implemented as User interacts with the system-->
            <script>
                // javascript to add to your aspx page
                function ValidateModuleList(source, args) {
                    var tot = 0;
                    var chkListModules = document.getElementById('<%=VolunteerEventCheckBoxList.ClientID %>');
                    var chkListinputs = chkListModules.getElementsByTagName("input");
                    for (var i = 0; i < chkListinputs.length; i++) {
                        if (chkListinputs[i].checked) {
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
                <asp:CheckBoxList ID="VolunteerEventCheckBoxList" CssClass="radio-container" OnSelectedIndexChanged="VolunteerEventCheckBoxList_SelectedIndexChanged" onClientClick="javascript: CheckCheck();" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" CausesValidation="True" ValidationGroup="JScript" />
            </div>
            <asp:CustomValidator ID="VolunteerValidator" runat="server" ErrorMessage="It is recommended select a maximum of 2 options" ClientValidationFunction="ValidateModuleList" ValidationGroup="JScript" SetFocusOnError="True" Font-Bold="True"></asp:CustomValidator>
        </fieldset>
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="CoordinatorExistingPlaceholder" runat="server">
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
        <div class="form-group">
            <asp:FormView ID="CoordinatorFormView" runat="server">
                <ItemTemplate>
                    <table>
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
        <div class="form-group">
            <fieldset>
                <h2>Activities List</h2>
                <div class="checkbox checkboxlist">
                    <asp:CheckBoxList ID="CoordinatorCheckBoxList" CssClass="radio-container" OnSelectedIndexChanged="CoordinatorEventCheckBoxList_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>

<asp:Content runat="server" ID="CommendationPage" ContentPlaceHolderID="CommedationPlaceholder">
    <asp:SqlDataSource runat="server"
        ID="CommendationDataSource"
        DataSourceMode="DataReader"
        ConnectionString="<%$ ConnectionStrings:CARESconnection%>"
        SelectCommand="select StaffID, FirstName + ' ' + LastName as Name, Type, StaffPicture from Staff" />
    <asp:DataList ID="CommendationList" DataSourceID="CommendationDataSource" runat="server" RepeatColumns="4">
        <SelectedItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False"
            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Right"
            VerticalAlign="Middle" />
        <ItemTemplate>
            <table class="table table-bordered table-striped" style="margin-left: 5px; margin-right: 5px;">
                <tr>
                    <td>
                        <img style="width: 100%; max-width: 200px; max-height: 230px;" src="<%# "ShowImage.ashx?id=" + Eval("StaffID") %>" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="StaffNameLabel" runat="server" Text='<%# Eval("Name") %>'><%#Eval("Name") %></asp:Label>
                        <asp:Label ID="StaffIdLabel" runat="server" Visible="False" Text='<%# Eval("StaffID") %>'><%#Eval("StaffID") %></asp:Label>
                    </td>
                </tr>
                <tr>
                </tr>

                <tr>
                    <td>
                        <%--                        <asp:TextBox Text="<%#Eval("StaffID") %>" Visible="True" runat="server"></asp:TextBox>--%>
                        <asp:Button ID="AddCommentButton" runat="server" OnClick="AddComment_Click" Text="Comment" Style="margin-left: 0%;" CssClass="btn btn-info" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#basicExampleModal">
        Launch demo modal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="basicExampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h3>Add a Commendation</h3>
                    <div>
                        <table>
                            <tr>
                                <td>Enter Comments:</td>
                                <td>
                                    <asp:TextBox ID="txtComment" runat="server" Rows="5" Columns="20" TextMode="MultiLine"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="commentSubmit" runat="server" Text="Submit" OnClick="commentSubmit_click" /></td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <asp:Repeater ID="RepterDetails" runat="server">
                            <HeaderTemplate>
                                <table>
                                    <tr>
                                        <td colspan="2">
                                            <b>Comments</b>
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="background-color: #EBEFF0">
                                    <td>
                                        <table style="background-color: #EBEFF0; border-top: 1px dotted #df5015; width: 500px">
                                            <tr>
                                                <td>ID:
    <asp:Label ID="lblSubject" runat="server" Text='<%#Eval("CommentID") %>' Font-Bold="true" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblComment" runat="server" Text='<%#Eval("CommentContent") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="background-color: #EBEFF0; border-top: 1px dotted #df5015; border-bottom: 1px solid #df5015; width: 500px">
                                            <tr>
                                                <td>Post By:
                                                    <asp:Label ID="lblUser" runat="server" Font-Bold="true" Text='<%#Eval("StaffName") %>' /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="NewEmployeePlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="label" runat="server" Text="First Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpFirstName" runat="server" required="true" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label4" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox CausesValidation="false" CssClass="input--style-4" ValidationGroup="EmpInput" ID="EmpLastName" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label6" CssClass="label" runat="server" Text="Type"></asp:Label>
                            <asp:DropDownList
                                ID="EmpTypeDropDown"
                                runat="server"
                                CssClass="js-example-basic-single">
                                <asp:ListItem Value="Employee" />
                                <asp:ListItem Value="Volunteer" />
                                <asp:ListItem Value="VolunHelper" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label19" CssClass="label" runat="server" Text="Location"></asp:Label>
                            <asp:SqlDataSource runat="server"
                                ID="LocationDataSource"
                                DataSourceMode="DataReader"
                                ConnectionString="<%$ ConnectionStrings:CARESconnection%>"
                                SelectCommand="SELECT LocationID, LocationName FROM Location" />
                            <asp:DropDownList
                                ID="EmpLocationDDL"
                                DataSourceID="LocationDataSource"
                                DataTextField="LocationName"
                                DataValueField="LocationID"
                                AutoPostBack="true"
                                runat="server"
                                CssClass="js-example-basic-single" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label13" CssClass="label" runat="server" Text="Manager" />
                            <!--Generated Dynamically in C# code based on school selection-->
                            <asp:CheckBox ID="ManagerCheckBox" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label15" CssClass="label" runat="server" Text="Email"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpEmailTextBox" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label16" CssClass="label" runat="server" Text="Password"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpPasswordTextBox" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Image ID="Image2" runat="server" />
                            <asp:FileUpload ID="ImageUpload1" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <asp:Button ID="SubmitEmp" runat="server" OnClick="AddEmp_Click" Text="Submit" Style="margin-left: 0%;" CausesValidation="False" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitEmp" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="NewLocationPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label7" CssClass="label" runat="server" Text="Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationNameText" runat="server" required="true" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label17" CssClass="label" runat="server" Text="Address"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationAddressText" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label20" CssClass="label" runat="server" Text="City"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationCity" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label21" CssClass="label" runat="server" Text="Zipcode"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationZip" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Button ID="SubmitLocation" runat="server" OnClick="AddLocation_Click" ValidationGroup="LocationInput" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitLocation" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewDonationPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label22" CssClass="label" runat="server" Text="Amount"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="DonationInput" ID="DonationAmount" runat="server" required="true" />
                            <asp:RequiredFieldValidator ID="RVF1" runat="server" ControlToValidate="DonationAmount" ValidationGroup="DonationInput"
                                ErrorMessage="Required" Display="Dynamic" />
                            <asp:CompareValidator ID="CheckFormat1" ValidationGroup="DonationInput" runat="server" ControlToValidate="DonationAmount" Operator="DataTypeCheck"
                                Type="Currency" Display="Dynamic" ErrorMessage="Illegal format for currency" />
                            <asp:RangeValidator ValidationGroup="DonationInput" ID="RangeCheck1" runat="server" ControlToValidate="DonationAmount"
                                Type="Double" Minimum="1.00" Maximum="999.99" ErrorMessage="Out of range" Display="Dynamic" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label23" CssClass="label" runat="server" Text="Donator"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="DonationInput" ID="DonatorName" runat="server" required="true" ValidateRequestMode="Inherit" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group">
                            <asp:Button ID="SubmitDonation" OnClick="AddDonation_Click" runat="server" ValidationGroup="DonationInput" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitDonation" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BasicEmployeeView" runat="server">
    <script>
        function validTime(source, args) {
            var TimeIn = document.getElementById('<%=EmployeeTimeIn.ClientID %>').value;
            var TimeOut = document.getElementById('<%=EmployeeTimeOut.ClientID %>').value;
            if (timeToSec(TimeIn) >= timeToSec(TimeOut)) {
                alert("Your time out needs to be later than your time in!");
                document.getElementById('<%=SubmitHours.ClientID %>').disabled = true;
                return false;
            }
            else {

                document.getElementById('<%=SubmitHours.ClientID %>').disabled = false;
                return true;

            }
        }
        function timeToSec(str) {
            var h = Number(str.match(/^\d+/));
            alert(str);
            alert(h);
            if (str.indexOf("PM") != -1)
                h += 12;
            var m = Number(str.match(/^\d+:(\d+)/)[1]);
            alert(str.match(/^\d+:(\d+)/));
            return (h * 60 + m);
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <h3>Employee can Log Hours</h3>
            </div>
            <div class="form-group">
                <asp:Label ID="lblresult" runat="server" Text='x' />
            </div>
            <div class="col">
                <div class="row">
                    <div class="form-group">
                        <asp:Label ID="Label26" CssClass="label" runat="server" Text="Date"></asp:Label>
                        <asp:Calendar CssClass="table table-bordered table-striped" ID="EmployeeHoursCalendar" runat="server" OnSelectionChanged="EmployeeHoursCalendar_OnSelectionChanged"></asp:Calendar>
                    </div>
                </div>
            </div>
            <div class="col">

                <div class="row">
                    <div class="form-group">
                        <asp:Label ID="EmployeeInTimeLabel" CssClass="label" runat="server" Text="Time In"></asp:Label>
                        <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="HoursInput" ID="EmployeeTimeIn" runat="server" required="true" TextMode="Time" ValidateRequestMode="Inherit" />
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <asp:Label ID="Label24" CssClass="label" runat="server" Text="Time Out"></asp:Label>
                        <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="HoursInput" ID="EmployeeTimeOut" TextMode="Time" runat="server" required="true" ValidateRequestMode="Inherit" />
                        <asp:CustomValidator runat="server" Display="Dynamic" ValidationGroup="HoursInput" Text="Nope" EnableClientScript="True" ControlToValidate="EmployeeTimeOut" ClientValidationFunction="validTime"></asp:CustomValidator>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <asp:Button ID="SubmitHours" OnClientClick="validTime" OnClick="AddHours_Click" runat="server" ValidationGroup="HoursInput" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
            <%--            <asp:CompareValidator runat="server" ID="cmpNumbers" ControlToValidate="EmployeeTimeIn" Display="Dynamic" ValidationGroup="HoursInput" ControlToCompare="EmployeeTimeOut" Operator="LessThan" Type="Date" ErrorMessage="The first time should be smaller than the second time!" /><br />--%>
            <h3>Employee can view inventory mark item as sold </h3>
            <h3>Employee can add item</h3>
            <div class="col">
                <div class="row">
                    <div class="form-group">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <asp:Label ID="Label25" CssClass="label" runat="server" Text="Donator"></asp:Label>
                        <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="DonationInput" ID="TextBox2" runat="server" required="true" ValidateRequestMode="Inherit" />
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <asp:Button ID="Button1" OnClick="AddDonation_Click" runat="server" ValidationGroup="DonationInput" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="Button1" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>