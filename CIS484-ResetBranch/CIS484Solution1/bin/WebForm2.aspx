<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="CIS484Solution1.WebForm2" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Import Namespace="System.Data" %>

<asp:Content ID="Home" ContentPlaceHolderID="HomePlaceholder" runat="server">
    <!-- John Wehner Max Vaughan -->
    <script>
        var slideIndex = 1;
        showSlides(slideIndex);
        function plusSlides(n) {
            showSlides(slideIndex += n);
        }
        function currentSlide(n) {
            showSlides(slideIndex = n);
        }
        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
        }
        var acc = document.getElementsByClassName("accordion");
        var i;
        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                /* Toggle between adding and removing the "active" class,
                to highlight the button that controls the panel */
                this.classList.toggle("active");
                /* Toggle between hiding and showing the active panel */
                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
    </script>
    <div class="container" style="width: 100%; margin-left: 20px; margin-top: 20px; margin-right: 20px;">
        <div class="form-group">
            <h2 style="text-align: center">Welcome to Shenandoah CARES! Thanks for stopping by</h2>
            <div class="slideshow-container">
                <div class="mySlides fade">
                    <div class="numbertext">1 / 2</div>
                    <img src="https://media4.s-nbcnews.com/j/newscms/2018_30/1343185/shenandoah-national-park-today-main-180601_fcac47c1cb39475c92ef15d924932360.fit-760w.jpg" style="width: 100%; max-height: 400px;">
                    <div class="text">Help make your a community a better place by getting involved with CARES</div>
                </div>

                <div class="mySlides fade">
                    <div class="numbertext">2 / 2</div>
                    <img src="https://cdn.vox-cdn.com/thumbor/WvbsmFJcBPEAnsCmjOW_U4c3CxM=/0x0:800x533/1200x800/filters:focal(336x203:464x331)/cdn.vox-cdn.com/uploads/chorus_image/image/50787565/michaels-consignment.0.jpg" style="width: 100%; max-height: 400px;">
                    <div class="text">Come with us at many of our convenient consignment stores</div>
                </div>

                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
            <br>
            <div style="text-align: center">
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
            </div>
        </div>
        <br />

        <br />
        <div id="accordion-div">
            <h3>FAQ</h3>
            <button type="button" class="accordion">What is Shenandoah CARES motto?</button>
            <div class="panel">
                <p class="answer">"Bringing Help to the Needy"</p>
            </div>

            <button type="button" class="accordion">What is a brief history of CARES?</button>
            <div class="panel">
                <p class="answer">First starting as a work-placement service for at-risk youth and those emerging from recovery and re-integration programs, CARES has since grown to provide 20+ services of various and valuable types to individuals across the social spectrum in the area.</p>
            </div>

            <button type="button" class="accordion">How long has CARES been around?</button>
            <div class="panel">
                <p class="answer">Shenandoah CARES has been in operation since 1968 in the NW part of Virginia </p>
            </div>
        </div>
    </div>
    <style>
        * {
            box-sizing: border-box
        }

        body {
            font-family: Verdana, sans-serif;
            margin: 0
        }

        .mySlides {
            display: none
        }

        img {
            vertical-align: middle;
        }
        /* Slideshow container */
        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin-top: 50px !important;
            margin: auto;
        }
        /* Next & previous buttons */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
        }
        /* Position the "next button" to the right */
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }
            /* On hover, add a black background color with a little bit see-through */
            .prev:hover, .next:hover {
                background-color: rgba(0,0,0,0.8);
            }
        /* Caption text */
        .text {
            color: #f2f2f2;
            background-color: black;
            font-size: 15px;
            padding: 8px 12px;
            position: absolute;
            bottom: 8px;
            width: 100%;
            text-align: center;
        }
        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }
        /* The dots/bullets/indicators */
        .dot {
            cursor: pointer;
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

            .active, .dot:hover {
                background-color: #717171;
            }
        /* Fading animation */
        .fade {
            -webkit-animation-name: fade;
            -webkit-animation-duration: 1.5s;
            animation-name: fade;
            animation-duration: 1.5s;
            animation-fill-mode: forwards;
        }

        @-webkit-keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }

        @keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }
        /* Style the buttons that are used to open and close the accordion panel */
        .accordion {
            background-color: #eee;
            color: #444;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            text-align: left;
            border: none;
            outline: none;
            transition: 0.4s;
        }
            /* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
            .active, .accordion:hover {
                background-color: #ccc;
            }
        /* Style the accordion panel. Note: hidden by default */
        .panel {
            padding: 0 18px;
            background-color: white;
            display: none;
            overflow: hidden;
        }

        .answer {
            margin: 20px;
            height: 100%;
        }
    </style>
    <script>
        var slideIndex = 1;
        showSlides(slideIndex);
        function plusSlides(n) {
            showSlides(slideIndex += n);
        }
        function currentSlide(n) {
            showSlides(slideIndex = n);
        }
        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
        }
        var acc = document.getElementsByClassName("accordion");
        var i;
        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                /* Toggle between adding and removing the "active" class,
                to highlight the button that controls the panel */
                this.classList.toggle("active");
                /* Toggle between hiding and showing the active panel */
                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
    </script>
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

<asp:Content ID="CordExisting" ContentPlaceHolderID="CoordinatorExistingPlaceholder" runat="server">
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
                        <img style="width: 100%; max-width: 200px; max-height: 200px;" src="<%# "ShowImage.ashx?id=" + Eval("StaffID") %>" />
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
                                    <asp:TextBox ID="txtComment" runat="server" Rows="5" Columns="20" TextMode="MultiLine" /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="commentSubmit" runat="server" CssClass="btn-secondary" Text="Submit" OnClick="commentSubmit_click" /></td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <asp:Repeater ID="RepterDetails" runat="server">
                            <HeaderTemplate>
                                <table class="table table-scroll-vertical scrollable">
                                    <tr>
                                        <td colspan="3">
                                            <b>Comments</b>
                                        </td>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>ID:
    <asp:Label ID="lblSubject" runat="server" Text='<%#Eval("CommentID") %>' Font-Bold="true" />
                                    </td>

                                    <td>
                                        <asp:Label ID="lblComment" runat="server" Text='<%#Eval("CommentContent") %>' />
                                    </td>

                                    <td>Post By:
                                        <asp:Label ID="lblUser" runat="server" Font-Bold="true" Text='<%#Eval("StaffName") %>' />
                                    </td>
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
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="NewEmployee" ContentPlaceHolderID="NewEmployeePlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="label" runat="server" Text="First Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpFirstName" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label4" CssClass="label" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox CausesValidation="false" CssClass="input--style-4" ValidationGroup="EmpInput" ID="EmpLastName" runat="server" ValidateRequestMode="Inherit" />
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
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpEmailTextBox" runat="server" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label16" CssClass="label" runat="server" Text="Password"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="EmpInput" ID="EmpPasswordTextBox" runat="server" ValidateRequestMode="Inherit" />
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
<asp:Content ID="NewLocation" ContentPlaceHolderID="NewLocationPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label7" CssClass="label" runat="server" Text="Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationNameText" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label17" CssClass="label" runat="server" Text="Address"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationAddressText" runat="server" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label20" CssClass="label" runat="server" Text="City"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationCity" runat="server" ValidateRequestMode="Inherit" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label21" CssClass="label" runat="server" Text="Zipcode"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="LocationInput" ID="LocationZip" runat="server" ValidateRequestMode="Inherit" />
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
<asp:Content ID="NewDonation" ContentPlaceHolderID="NewDonationPlaceholder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel5" runat="server">

        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="form-group">
                            <asp:Label ID="Label22" CssClass="label" runat="server" Text="Amount"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="DonationInput" ID="DonationAmount" runat="server" />
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
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="DonationInput" ID="DonatorName" runat="server" />
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
<asp:Content ID="AddEvent" ContentPlaceHolderID="AddEventView" runat="server">

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <h3>Employee can Log Hours</h3>
                <div class="container-fluid" style="display: flex;">

                    <div class="form-group">
                        <asp:Label ID="Label1" CssClass="label" runat="server" Text="Date"></asp:Label>
                        <asp:Calendar CssClass="table table-bordered table-striped" ID="EventCalendar" Height="50%" runat="server" OnSelectionChanged="EventCalendar_OnSelectionChanged"></asp:Calendar>
                    </div>

                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="Label32" CssClass="label" runat="server" Text="Location"></asp:Label>
                            <asp:SqlDataSource runat="server"
                                ID="SqlDataSourceEventLocation"
                                DataSourceMode="DataReader"
                                ConnectionString="<%$ ConnectionStrings:CARESconnection%>"
                                SelectCommand="SELECT LocationID, LocationName FROM Location" />
                            <asp:DropDownList
                                ID="EventLocationDDL"
                                DataSourceID="SqlDataSourceEventLocation"
                                OnSelectionChanged="EventCalendar_OnSelectionChanged"
                                DataTextField="LocationName"
                                DataValueField="LocationID"
                                AutoPostBack="true"
                                runat="server"
                                CssClass="js-example-basic-single" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" CssClass="label" runat="server" Text="Event Name"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="EventInput" Width="100%" ID="EventNameTextBox" runat="server" ValidateRequestMode="Inherit" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label31" CssClass="label" runat="server" Text="Event Description"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="EventInput" TextMode="MultiLine" Width="100%" ID="EventDescription" runat="server" ValidateRequestMode="Inherit" />
                        </div>
                        <div class="row">
                            <div class="form-group" style="width: 50%">
                                <asp:Button ID="SubmitEvent" OnClientClick="validTime" OnClick="AddEvent_Click" runat="server" ValidationGroup="EventInput" Text="Submit" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitEvent" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="TimeIn" ContentPlaceHolderID="BasicEmployeeView" runat="server">
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
            //alert(str);
            // alert(h);
            if (str.indexOf("PM") != -1)
                h += 12;
            var m = Number(str.match(/^\d+:(\d+)/)[1]);
            // alert(str.match(/^\d+:(\d+)/));
            return (h * 60 + m);
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <h3>Employee can Log Hours</h3>
                <div class="container-fluid" style="display: flex;">

                    <div class="form-group">
                        <asp:Label ID="Label26" CssClass="label" runat="server" Text="Date"></asp:Label>
                        <asp:Calendar CssClass="table table-bordered table-striped" ID="EmployeeHoursCalendar" Height="50%" runat="server" OnSelectionChanged="EmployeeHoursCalendar_OnSelectionChanged"></asp:Calendar>
                    </div>

                    <div class="col">
                        <div class="form-group">
                            <asp:Label ID="EmployeeInTimeLabel" CssClass="label" runat="server" Text="Time In"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="HoursInput" Width="100%" ID="EmployeeTimeIn" runat="server" TextMode="Time" ValidateRequestMode="Inherit" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label24" CssClass="label" runat="server" Text="Time Out"></asp:Label>
                            <asp:TextBox CssClass="input--style-4" ValidationGroup="HoursInput" Width="100%" ID="EmployeeTimeOut" TextMode="Time" runat="server" ValidateRequestMode="Inherit" />
                            <asp:CustomValidator runat="server" Display="Dynamic" ValidationGroup="HoursInput" Text="Nope" EnableClientScript="True" ControlToValidate="EmployeeTimeOut" ClientValidationFunction="validTime"></asp:CustomValidator>
                        </div>
                        <div class="row">
                            <div class="form-group" style="width: 50%">
                                <asp:Button ID="SubmitHours" OnClientClick="validTime" OnClick="AddHours_Click" runat="server" ValidationGroup="HoursInput" Text="Submit" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="SubmitHours" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content runat="server" ID="InventoryManagement" ContentPlaceHolderID="InventoryManagementPlaceholder">
    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <asp:Label ID="Label27" CssClass="label" runat="server" Text="Article Name"></asp:Label>
                                <asp:TextBox CssClass="input--style-4" ValidationGroup="ArticleInput" ID="ArticleNameText" runat="server" />
                            </div>
                        </div>
                        <div class="col">

                            <div class="form-group">
                                <asp:Label ID="Label25" CssClass="label" runat="server" Text="Article Type"></asp:Label>
                                <asp:DropDownList ID="ArticleTypeDDL"
                                    AutoPostBack="true"
                                    runat="server"
                                    Width="100%"
                                    CssClass="js-example-basic-single">
                                    <asp:ListItem Value="Shirt" />
                                    <asp:ListItem Value="Shorts" />
                                    <asp:ListItem Value="Pants" />
                                    <asp:ListItem Value="Shoes" />
                                    <asp:ListItem Value="Coat" />
                                    <asp:ListItem Value="Dress" />
                                    <asp:ListItem Value="Other" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">

                            <div class="form-group">
                                <asp:Label ID="Label30" CssClass="label" runat="server" Text="Description"></asp:Label>
                                <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="ArticleInput" ID="ArticleDescriptionText" TextMode="MultiLine" runat="server" ValidateRequestMode="Inherit" />
                            </div>
                        </div>
                        <div class="col">

                            <div class="form-group">
                                <asp:Label ID="Label28" CssClass="label" runat="server" Text="Price"></asp:Label>
                                <asp:TextBox CssClass="input--style-4" CausesValidation="false" ValidationGroup="ArticleInput" ID="ArticlePriceText" TextMode="Number" runat="server" ValidateRequestMode="Inherit" />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                            <div class="form-group">
                                <asp:Label ID="Label29" CssClass="label" runat="server" Text="Size"></asp:Label>
                                <asp:DropDownList ID="ArticleSizeDDL"
                                    AutoPostBack="true"
                                    runat="server"
                                    CssClass="js-example-basic-single">
                                    <asp:ListItem Value="Small" />
                                    <asp:ListItem Value="Medium" />
                                    <asp:ListItem Value="Large" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col">

                            <div class="form-group">
                                <asp:Button ID="AddDonationButton" OnClick="AddClothingDonation_Click" runat="server" ValidationGroup="ArticleInput" Text="Submit" Style="margin-left: 0%;" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="AddDonationButton" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content runat="server" ID="Content6" ContentPlaceHolderID="InventoryManagement2Placeholder">
    <style>
        table .table a {
            color: blue;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
        <ContentTemplate>
            <div style="margin-top: 40px;">
                <h3>View Inventory or Document a Sale</h3>
                <div style="width: 100%; height: 400px; overflow: scroll">
                    <asp:GridView ID="InventoryGridview" runat="server" CssClass="table table-bordered table-striped"
                        AutoGenerateColumns="false" OnSelectedIndexChanged="InventoryGridview_OnSelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="ArticleID" HeaderText="ArticleID" />
                            <asp:BoundField DataField="ArticleName" HeaderText="Name" />
                            <asp:BoundField DataField="ArticleType" HeaderText="Type" />
                            <asp:BoundField DataField="ArticleLocationID" HeaderText="LocationID" />
                            <asp:BoundField DataField="ArticleDescription" HeaderText="Description" />
                            <asp:TemplateField HeaderText="Price">
                                <ItemTemplate>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("ArticlePrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ArticleSize" HeaderText="Size" />
                            <asp:BoundField DataField="DateArrived" HeaderText="Arrived" />

                            <asp:ButtonField Text="SELL" CommandName="Select" ButtonType="Button" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="EventSignUp" ContentPlaceHolderID="EventSignUpPlaceholder" runat="server">
    <div style="margin-top: 40px;">
        <div style="margin-top: 40px;">
            <asp:Label ID="Label33" CssClass="label" runat="server" Text="Location"></asp:Label>
            <asp:SqlDataSource runat="server"
                ID="SqlDataSource1"
                DataSourceMode="DataReader"
                ConnectionString="<%$ ConnectionStrings:CARESconnection%>"
                SelectCommand="SELECT LocationID, LocationName FROM Location" />
            <asp:DropDownList
                ID="DropDownList1"
                DataSourceID="SqlDataSource1"
                DataTextField="LocationName"
                DataValueField="LocationID"
                AutoPostBack="true"
                OnSelectedIndexChanged="EventLocationDDL_SelectedIndexChanged"
                runat="server"
                CssClass="js-example-basic-single" />
        </div>

        <div class="form-group">
            <fieldset>
                <h2>Activities List</h2>
                <div class="checkbox checkboxlist">
                    <asp:CheckBoxList ID="EventCheckBoxList" CssClass="radio-container" OnSelectedIndexChanged="WorkerEventCheckBoxList_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="EmployeePayPlaceholder" runat="server">
    <div style="margin-top: 40px;">
        <div style="margin-top: 40px;">
            <div class="row">
                <div class="col">

                    <div class="form-group">
                        <asp:Label ID="Label34" CssClass="label" Font-Bold="true" runat="server" Text="Hours Worked This Week"></asp:Label>
                        <asp:Label ID="WeeklyHoursLabel" CssClass="label" runat="server" Text="Hours Worked This Week"></asp:Label>
                        <asp:Label ID="Label38" CssClass="label" runat="server" Font-Bold="true" Text="Pay This Week"></asp:Label>
                        <asp:Label ID="WeeklyPayLabel" CssClass="label" runat="server" Text="Pay This Week"></asp:Label>
                        <asp:Label ID="Label37" CssClass="label" runat="server" Font-Bold="true" Text="Worker Classification"></asp:Label>
                        <asp:Label ID="TypeLabel" CssClass="label" runat="server" Text="Pay This Week"></asp:Label>
                    </div>
                </div>
                <div class="col">

                    <div class="form-group">

                        <asp:Chart ID="Chart1" runat="server" Height="400px" Width="350px" IsYValueIndexed="true" IsXValueIndexed="false">
                            <Titles>
                                <asp:Title ShadowOffset="3" Name="Date" />
                            </Titles>
                            <Legends>
                                <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Weekly Hours"
                                    LegendStyle="Row" />
                            </Legends>
                            <Series>
                                <asp:Series Name="Hours">
                                    <EmptyPointStyle IsValueShownAsLabel="true" IsVisibleInLegend="true" />
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BusAnPlaceholder" runat="server">
    <div style="margin-top: 40px;">
        <div style="margin-top: 40px;">
            <div class="row">
                <div class="col">

                    <div class="form-group">
                        <script type='text/javascript' src='https://prod-useast-b.online.tableau.com/javascripts/api/viz_v1.js'></script>
                        <div class='tableauPlaceholder' style='width: 1000px; height: 827px;'>
                            <object class='tableauViz' width='1000' height='827' style='display: none;'>
                                <param name='host_url' value='https%3A%2F%2Fprod-useast-b.online.tableau.com%2F' />
                                <param name='embed_code_version' value='3' />
                                <param name='site_root' value='&#47;t&#47;cis484' />
                                <param name='name' value='CIS484Book&#47;CARESFinancialDashboard' />
                                <param name='tabs' value='no' />
                                <param name='toolbar' value='yes' />
                                <param name='showAppBanner' value='false' />
                            </object>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>