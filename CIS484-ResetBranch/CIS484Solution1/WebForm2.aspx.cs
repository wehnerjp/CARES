using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Configuration;
using System.Windows.Forms;
using System.Web.Services;

namespace CIS484Solution1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        public static int StID = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(
                        UpdatePanel1,
                        this.GetType(),
                        "MyAction",
                        "$(document).ready(function() { $('.js-example-basic-single').select2(); });",
                        true);
            ScriptManager.RegisterStartupScript(
                        UpdatePanel2,
                        this.GetType(),
                        "MyAction",
                        "$(document).ready(function() { $('.js-example-basic-single').select2();  $('.grid').masonry({ itemSelector: '.grid-item', columnWidth: 160,  gutter: 20   }); $(document).ready(function () {$('#manBt').click(function() {$('#manPan1').slideToggle('slow');});});});",
                        true);
        }

        protected void MultiView_ActiveViewChanged(object sender, EventArgs e)
        {
            //Connect to DB
        }

        protected void EventList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Queries Relevant to home page, fetching event info student info and more
            String sqlQuery = "Select EventName, Time, FORMAT(Date,'dd/MM/yyyy') as Date,  RoomNbr from Event where EventID = " + EventList.SelectedItem.Value;
            String sqlQuery1 = "SELECT Student.FirstName +' ' + Student.LastName as StudentName, Student.TeacherID from Student " +
                "inner join Teacher on Student.TeacherID = Teacher.TeacherID " +
                "inner join EventAttendanceList on EventAttendanceList.TeacherID = Teacher.TeacherID " +
                "where EventAttendanceList.EventID = " + EventList.SelectedItem.Value;
            String sqlQuery2 = "select EventPersonnel.FirstName +' ' + EventPersonnel.LastName as VolunteerName, EventPersonnel.PersonnelType from EventPresenters " +
                "inner join EventPersonnel on EventPersonnel.VolunteerID = EventPresenters.PersonnelID where EventPresenters.Role = 'Volunteer' and EventPresenters.EventID = " + EventList.SelectedItem.Value;
            String sqlQuery3 = "select EventPersonnel.FirstName + ' ' + EventPersonnel.LastName as CoordinatorName from EventPresenters " +
                "inner join EventPersonnel on EventPersonnel.VolunteerID = EventPresenters.PersonnelID where EventPresenters.Role = 'Coordinator' and EventPresenters.EventID = " + EventList.SelectedItem.Value;

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);
            SqlDataAdapter sqlAdapter2 = new SqlDataAdapter(sqlQuery2, con);

            var items = new List<string>();

            using (SqlCommand command = new SqlCommand(sqlQuery2, con))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        //Read info into List
                        items.Add(reader.GetString(0));
                    }
                }
            }
            rep1.DataSource = items;
            rep1.DataBind();
            //Fill table with data
            DataTable dt = new DataTable();
            sqlAdapter1.Fill(dt);

            var items1 = new List<string>();

            using (SqlCommand command = new SqlCommand(sqlQuery3, con))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        //Read info into List
                        items1.Add(reader.GetString(0));
                    }
                }
            }
            CoordinatorRepeater.DataSource = items1;
            CoordinatorRepeater.DataBind();
            //Fill table with data
            DataTable dt2 = new DataTable();
            sqlAdapter2.Fill(dt2);

            if (dt.Rows.Count > 0)
            {
                ListBox1.DataSource = dt;
                ListBox1.DataTextField = "StudentName";
                ListBox1.DataBind();
            }

            DataSet ds = new DataSet();

            sqlAdapter.Fill(ds);

            FormView1.DataSource = ds;
            FormView1.DataBind();
            con.Close();
        }

        protected void StudentSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Make Teacher selection DDL conditional based on what school they selected
            String sqlQuery = "Select TeacherID, FirstName +' ' + LastName as TeacherName from Teacher where SchoolID = " + StudentSchoolDropDownList.SelectedItem.Value;
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            sqlAdapter.Fill(dt);
            //same procedure to create DDL
            if (dt.Rows.Count > 0)
            {
                StudentTeacherDropDownList.DataSource = dt;
                StudentTeacherDropDownList.DataTextField = "TeacherName";
                StudentTeacherDropDownList.DataValueField = "TeacherID";
                StudentTeacherDropDownList.DataBind();
            }
            con.Close();
        }

        protected void StudentNameDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Student Selection information for user display
            String sqlQuery = "Select Student.StudentID, TRIM(Student.FirstName) + ' ' + TRIM(Student.LastName) as StudentName, Student.Age, Student.Notes, TRIM(Teacher.FirstName) + ' ' + TRIM(Teacher.LastName) as TeacherName, Tshirt.Size, Tshirt.Color, TRIM(School.SchoolName) from Student " +
                 "inner join Tshirt on Tshirt.TshirtID = Student.TshirtID " +
                "inner join Teacher on Student.TeacherID = Teacher.TeacherID " +
                "inner join School on School.SchoolID = Student.SchoolID " +
                "where Student.StudentID = " + StudentNameDDL.SelectedItem.Value + " and Student.SchoolID = (select SchoolID from student where StudentID= " + StudentNameDDL.SelectedItem.Value + ") " +
                " and Student.TeacherID = (select TeacherID from student where StudentID = " + StudentNameDDL.SelectedItem.Value + ") " +
               " and Tshirt.TshirtID = (select TshirtID from Student where StudentID = " + StudentNameDDL.SelectedItem.Value + ")";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file

            SqlConnection con = new SqlConnection(strcon);
            SqlConnection con1 = new SqlConnection(strcon);
            con1.Open();
            SqlCommand myCommand = new SqlCommand(sqlQuery, con1);
            SqlDataReader myReader = myCommand.ExecuteReader();
            con.Open();
            while (myReader.Read())
            {
                StID = Int32.Parse(myReader[0].ToString());
                StudentNameData.Text = (HttpUtility.HtmlEncode(myReader[1].ToString()));
                StudentAgeEdit.SelectedValue = (myReader[2].ToString());
                StudentNotesData.Text = (HttpUtility.HtmlEncode(myReader[3].ToString()));
                StudentSchoolData.Text = (HttpUtility.HtmlEncode(myReader[7].ToString()));
                StudentTeacherData.Text = (HttpUtility.HtmlEncode(myReader[4].ToString()));
                StudentColorEdit.SelectedValue = (myReader[6].ToString());
                StudentSizeEdit.SelectedValue = (myReader[5].ToString());
            }

            //Filling out data for display
            // SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            // DataSet ds = new DataSet();
            // sqlAdapter.Fill(ds);
            // StudentFormView.DataSource = ds;
            // StudentFormView.DataBind();
            con.Close();
        }

        protected void AddStudent_Click(object sender, EventArgs e)
        {
            Boolean dup = false;

            if (dup == false && FirstNameTextBox.Text != "" && LastNameTextBox.Text != "" && StudentAgeList.SelectedIndex > -1 && NotesTextBox.Text != "" && TshirtList.SelectedIndex > -1 && TshirtColorList.SelectedIndex > -1 && StudentSchoolDropDownList.SelectedIndex > -1 && StudentTeacherDropDownList.SelectedIndex > -1)
            {
                //If filled out and non duplicate it inserts into object
                string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
                SqlConnection connection = new SqlConnection(strcon);
                SqlCommand cmd;
                int sub;
                try
                {
                    // open the Sql connection
                    connection.Open();
                    //Check for size in Note field and insert temporarily or permanently into DB if it does not exist

                    if (NotesTextBox.Text.Length > 20)
                    {
                        sub = 20;
                    }
                    else
                    {
                        sub = NotesTextBox.Text.Length;
                    }
                    string sqlStatement = "If Not Exists (select 1 from Student where FirstName= @FirstName and LastName= @LastName) Insert into Student (FirstName, LastName, Age, Notes, TshirtID, SchoolID, TeacherID) values(@FirstName, @LastName, '" + StudentAgeList.SelectedValue + "', @Notes, " +
                           "(SELECT  TshirtID FROM[Lab1].[dbo].Tshirt where Size = '" + TshirtList.SelectedValue + "' and Color = '" + TshirtColorList.SelectedValue + "'), '" + StudentSchoolDropDownList.SelectedValue + "', '" + StudentTeacherDropDownList.SelectedValue + "'); ";
                    cmd = new SqlCommand(sqlStatement, connection);
                    cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text);
                    cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text);
                    cmd.Parameters.AddWithValue("@Notes", NotesTextBox.Text.Substring(0, sub));

                    cmd.CommandType = CommandType.Text;
                    cmd.ExecuteNonQuery();
                    ResetButton_Click(sender, e);
                }
                //If it does not work
                catch (System.Data.SqlClient.SqlException ex)
                {
                    string msg = "Insert/Update Error:";
                    msg += ex.Message;
                    throw new Exception(msg);
                }
                finally
                {
                    // close the Sql Connection
                    connection.Close();
                }
            }
            //Failure alternatives
            else if (dup == true)
            {
                MessageBox.Show("Try Again", "Duplicate");
            }
            else
            {
                MessageBox.Show("Oops", "All fields must be filled");
            }
        }

        //
        // protected void AddTeacher_Click1(object sender, EventArgs e)
        // {
        //     ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + PasswordHash.HashPassword("1111") + "','Warning');", true);
        //     MessageBox.Show(PasswordHash.HashPassword("1111"));
        // }

        protected void AddTeacher_Click(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "If Not Exists (select 1 from Teacher where FirstName= @FirstName and LastName= @LastName)  Insert into Teacher (FirstName, LastName, Notes, TshirtID, SchoolID, Email, Grade) values " +
                "(@FirstName, @LastName, @Notes, " +
                "(SELECT  TshirtID FROM Tshirt where Size = '" + TeacherTshirtSize.SelectedItem.Value + "' and Color = '" + TeacherTshirtColor.SelectedItem.Value + "'), '" + TeacherSchoolList.SelectedItem.Value + "', '" + EmailTextBox.Text + "', '" + GradeDDL.SelectedItem.Value + "'); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //Inserting teacher query
            String sqlQuery1 = "  Insert into UserInfo (Email, Password, Role) values " +
                "(@Email, '" + PasswordHash.HashPassword(modalLRInput13.Text) + "', 'Teacher');";            //Get connection string from web.config file
            string strcon1 = ConfigurationManager.ConnectionStrings["authconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            SqlConnection con1 = new SqlConnection(strcon1);
            SqlCommand cmd = new SqlCommand(sqlQuery1, con1);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();
                command.Parameters.Add(new SqlParameter("@FirstName", TeacherFirstNameText.Text));
                command.Parameters.Add(new SqlParameter("@LastName", TeacherLastNameInput.Text));
                command.Parameters.Add(new SqlParameter("@Notes", TeacherNoteTextBox.Text));

                con1.Open();
                cmd.Parameters.Add(new SqlParameter("@Email", EmailTextBox.Text));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert teacher success");
                    cmd.CommandType = CommandType.Text;
                    cmd.ExecuteNonQuery();
                    ResetTeacherButton_Click(sender, e);
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                }
                con.Close();
                con1.Close();
            }
        }

        protected void TeacherNameDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Listing teachers and summoning teacher info
            String sqlQuery = "Select Teacher.TeacherID, Teacher.FirstName + ' ' + Teacher.LastName as TeacherName, Teacher.Email, Teacher.Notes, School.SchoolName, Tshirt.Size, Tshirt.Color from Teacher " +
                "inner join School on School.SchoolID = Teacher.SchoolID " +
                "inner join Tshirt on Tshirt.TshirtID = Teacher.TshirtID " +
                "where Teacher.TeacherID = " + TeacherNameDDL.SelectedItem.Value + " " +
                "and School.SchoolID = (select SchoolID from Teacher where TeacherID= " + TeacherNameDDL.SelectedItem.Value + ") " +
               " and Tshirt.TshirtID = (select TshirtID from Teacher where TeacherID = " + TeacherNameDDL.SelectedItem.Value + ")";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            DataSet ds = new DataSet();
            sqlAdapter.Fill(ds);
            TeacherFormView.DataSource = ds;
            TeacherFormView.DataBind();
            //If everything is kosher then the checkbox db interaction function is called
            if (CheckBoxList1.Items.Count > 1 && TeacherNameDDL.SelectedItem.Value != null)
            {
                CheckBoxListSelect();
            }
            con.Close();
        }

        protected void EventDateDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Selection for event date when displaying activities
            Console.WriteLine(EventDateDDL.SelectedValue);
            String sqlQuery = "Select EventID, EventName, EventName + '    ' +  convert(nvarchar, convert(nvarchar, Time, 0)) as EventNameTime, Date from Event where Date  = '" + EventDateDDL.SelectedValue + "'";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();

            DataTable dtx = new DataTable();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            sqlAdapter.Fill(dtx);

            if (dtx.Rows.Count > 0)
            {
                CheckBoxList1.DataSource = dtx;
                CheckBoxList1.DataTextField = "EventNameTime";
                CheckBoxList1.DataValueField = "EventID";
                CheckBoxList1.DataBind();
            }

            CheckBoxListSelect();
            con.Close();
        }

        protected void CheckBoxListSelect()
        {
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            //Determining which boxes to start checked and unchecked based on DB info

            if (EventDateDDL.SelectedItem.Value != null && TeacherNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Select EAL.EventID from EventAttendanceList EAL where EAL.TeacherID = '" + TeacherNameDDL.SelectedValue + "'", con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    for (int i = 0; i < CheckBoxList1.Items.Count; i++)
                        CheckBoxList1.Items[i].Selected = false;

                    while (reader.Read())
                    {
                        ListItem li = CheckBoxList1.Items.FindByValue(reader["EventID"].ToString());
                        if (li != null)
                        {
                            li.Selected = true;
                        }
                        else
                        {
                            li.Selected = false;
                        }
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("user.aspx", false);
                }
            }
        }

        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            string sqlStatement = string.Empty;
            //Making DB changes when user alters event signup schedule, inserting if checked, deleting if unchecked
            if (EventDateDDL.SelectedItem.Value != null && TeacherNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    // open the Sql connection
                    connection.Open();
                    foreach (ListItem item in CheckBoxList1.Items)
                    {
                        if (item.Selected)
                        {
                            sqlStatement = "If Not Exists (select 1 from EventAttendanceList where TeacherID= '" + TeacherNameDDL.SelectedValue + "' and EventID= '" + item.Value + "') Insert into EventAttendanceList (TeacherID, EventID) values('" + TeacherNameDDL.SelectedValue + "','" + item.Value + "') ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlStatement = "DELETE FROM EventAttendanceList WHERE TeacherID ='" + TeacherNameDDL.SelectedValue + "' and EventID ='" + item.Value + "' ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    string msg = "Insert/Update Error:";
                    msg += ex.Message;
                    throw new Exception(msg);
                }
                finally
                {
                    // close the Sql Connection
                    connection.Close();
                }
            }
        }

        protected void PopulateText_Click(object sender, EventArgs e)
        {
            //Using faker api to generate random names en masse for students so it doesn't get repetitive, randomly selecting DDL options, meeting conditional needs
            Random rnd = new Random();
            StudentAgeList.SelectedIndex = rnd.Next(0, StudentAgeList.Items.Count - 1);
            StudentSchoolDropDownList.SelectedIndex = rnd.Next(0, StudentSchoolDropDownList.Items.Count - 1);
            StudentSchool_SelectedIndexChanged(sender, e);
            StudentTeacherDropDownList.SelectedIndex = rnd.Next(0, StudentTeacherDropDownList.Items.Count - 1);
            TshirtList.SelectedIndex = rnd.Next(0, TshirtList.Items.Count - 1);
            TshirtColorList.SelectedIndex = rnd.Next(0, TshirtColorList.Items.Count - 1);
        }

        protected void ResetButton_Click(object sender, EventArgs e)
        {
            //Clear all student input selections
            FirstNameTextBox.Text = string.Empty;
            LastNameTextBox.Text = string.Empty;
            StudentAgeList.SelectedIndex = 0;
            StudentSchoolDropDownList.SelectedIndex = 0;
            StudentTeacherDropDownList.SelectedIndex = 0;
            TshirtList.SelectedIndex = 0;
            TshirtColorList.SelectedIndex = 0;
            NotesTextBox.Text = string.Empty;
        }

        protected void PopulateTextTeacher_Click(object sender, EventArgs e)
        {
            //Using faker api to generate random names en masse for teachers so it doesn't get repetitive, randomly selecting DDL options, meeting conditional needs

            Random rnd = new Random();
            TeacherSchoolList.SelectedIndex = rnd.Next(0, TeacherSchoolList.Items.Count - 1);
            TeacherTshirtSize.SelectedIndex = rnd.Next(0, TeacherTshirtSize.Items.Count - 1);
            TeacherTshirtColor.SelectedIndex = rnd.Next(0, TshirtColorList.Items.Count - 1);
            modalLRInput13.Text = "1111";
        }

        protected void ResetTeacherButton_Click(object sender, EventArgs e)
        {
            //clear teacher input
            TeacherFirstNameText.Text = string.Empty;
            TeacherLastNameInput.Text = string.Empty;
            TeacherSchoolList.SelectedIndex = 0;
            TeacherTshirtSize.SelectedIndex = 0;
            TeacherTshirtColor.SelectedIndex = 0;
            TeacherNoteTextBox.Text = string.Empty;
            EmailTextBox.Text = string.Empty;
            modalLRInput13.Text = string.Empty;
        }

        protected void VolunteerNameDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Reacting to selections for Existing volunteer ddl dropdown, filling out info below
            String sqlQuery = "Select EventPersonnel.VolunteerID, EventPersonnel.FirstName + ' ' + EventPersonnel.LastName as VolunteerName, EventPersonnel.Notes, Tshirt.Size, Tshirt.Color, EventPersonnel.PersonnelType from EventPersonnel " +
                "inner join Tshirt on Tshirt.TshirtID = EventPersonnel.TshirtID " +
                "where EventPersonnel.VolunteerID = '" + VolunteerNameDDL.SelectedItem.Value + "' and Tshirt.TshirtID = (select TshirtID from EventPersonnel where VolunteerID = " + VolunteerNameDDL.SelectedItem.Value + ")";
            String sqlQuery1 = "Select EventID, EventName, EventName + '    ' +  convert(nvarchar, convert(nvarchar, Time, 0)) as EventNameTime, Date from Event";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            DataTable dtx = new DataTable();
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);
            sqlAdapter1.Fill(dtx);
            DataSet ds = new DataSet();
            sqlAdapter.Fill(ds);
            VolunteerFormView.DataSource = ds;
            VolunteerFormView.DataBind();
            //Allow for event sign ups and association, interaction
            if (dtx.Rows.Count > 0)
            {
                VolunteerEventCheckBoxList.DataSource = dtx;
                VolunteerEventCheckBoxList.DataTextField = "EventNameTime";
                VolunteerEventCheckBoxList.DataValueField = "EventID";
                VolunteerEventCheckBoxList.DataBind();
            }

            if (VolunteerEventCheckBoxList.Items.Count > 1 && VolunteerNameDDL.SelectedItem.Value != null)
            {
                VolunteerCheckBoxListSelect();
            }
            con.Close();
        }

        protected void VolunteerCheckBoxListSelect()
        {
            //This determines where to check and uncheck initially based on DB values
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            if (VolunteerNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Select EP.EventID from EventPresenters EP where EP.PersonnelID = '" + VolunteerNameDDL.SelectedValue + "'", con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    for (int i = 0; i < VolunteerEventCheckBoxList.Items.Count; i++)
                        VolunteerEventCheckBoxList.Items[i].Selected = false;

                    while (reader.Read())
                    {
                        ListItem li = VolunteerEventCheckBoxList.Items.FindByValue(reader["EventID"].ToString());
                        if (li != null)
                        {
                            li.Selected = true;
                        }
                        else
                        {
                            li.Selected = false;
                        }
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("user.aspx", false);
                }
            }
        }

        protected void VolunteerEventCheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Enables volunteer checkbox interaction live with DB, only inserting if not exists and deleting if unchecked
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            string sqlStatement = string.Empty;
            if (VolunteerNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    // open the Sql connection
                    connection.Open();
                    foreach (ListItem item in VolunteerEventCheckBoxList.Items)
                    {
                        if (item.Selected)
                        {
                            sqlStatement = "If Not Exists (select 1 from EventPresenters where PersonnelID= '" + VolunteerNameDDL.SelectedValue + "' and EventID= '" + item.Value + "') Insert into EventPresenters (PersonnelID, EventID, Role) values('" + VolunteerNameDDL.SelectedValue + "','" + item.Value + "',(select PersonnelType from EventPersonnel where VolunteerID=" + VolunteerNameDDL.SelectedItem.Value + ")) ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlStatement = "DELETE FROM EventPresenters WHERE PersonnelID ='" + VolunteerNameDDL.SelectedValue + "' and EventID ='" + item.Value + "' ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    string msg = "Insert/Update Error:";
                    msg += ex.Message;
                    throw new Exception(msg);
                }
                finally
                {
                    // close the Sql Connection
                    connection.Close();
                }
            }
        }

        protected void CoordinatorNameDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Similar process for reacting to coordinator selection as with volunteer
            String sqlQuery = "Select EventPersonnel.VolunteerID, EventPersonnel.FirstName + ' ' + EventPersonnel.LastName as CoordinatorName, EventPersonnel.Notes, Tshirt.Size, Tshirt.Color, EventPersonnel.PersonnelType from EventPersonnel " +
                "inner join Tshirt on Tshirt.TshirtID = EventPersonnel.TshirtID " +
                "where EventPersonnel.VolunteerID = '" + CoordinatorNameDDL.SelectedItem.Value + "' and Tshirt.TshirtID = (select TshirtID from EventPersonnel where VolunteerID = " + CoordinatorNameDDL.SelectedItem.Value + ")";
            String sqlQuery1 = "Select EventID, EventName, EventName + '    ' +  convert(nvarchar, convert(nvarchar, Time, 0)) as EventNameTime, Date from Event";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            DataTable dtx = new DataTable();
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);
            sqlAdapter1.Fill(dtx);
            DataSet ds = new DataSet();
            sqlAdapter.Fill(ds);
            CoordinatorFormView.DataSource = ds;
            CoordinatorFormView.DataBind();
            //Displaying events below for coordinator sign up
            if (dtx.Rows.Count > 0)
            {
                CoordinatorCheckBoxList.DataSource = dtx;
                CoordinatorCheckBoxList.DataTextField = "EventNameTime";
                CoordinatorCheckBoxList.DataValueField = "EventID";
                CoordinatorCheckBoxList.DataBind();
            }

            if (CoordinatorCheckBoxList.Items.Count > 1 && CoordinatorNameDDL.SelectedItem.Value != null)
            {
                CoordinatorCheckBoxListSelect();
            }
            con.Close();
        }

        protected void CoordinatorCheckBoxListSelect()
        {
            //Determines inital boolean values for selection Coo. Event List
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();

            if (CoordinatorNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Select EP.EventID from EventPresenters EP where EP.PersonnelID = '" + CoordinatorNameDDL.SelectedValue + "'", con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    for (int i = 0; i < CoordinatorCheckBoxList.Items.Count; i++)
                        CoordinatorCheckBoxList.Items[i].Selected = false;

                    while (reader.Read())
                    {
                        ListItem li = CoordinatorCheckBoxList.Items.FindByValue(reader["EventID"].ToString());
                        if (li != null)
                        {
                            li.Selected = true;
                        }
                        else
                        {
                            li.Selected = false;
                        }
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("user.aspx", false);
                }
            }
        }

        protected void CoordinatorEventCheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Enables coordinator sign up interaction with DB and live modification

            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            string sqlStatement = string.Empty;
            if (CoordinatorNameDDL.SelectedItem.Value != null)
            {
                try
                {
                    // open the Sql connection
                    connection.Open();
                    foreach (ListItem item in CoordinatorCheckBoxList.Items)
                    {
                        if (item.Selected)
                        {
                            sqlStatement = "If Not Exists (select 1 from EventPresenters where PersonnelID= '" + CoordinatorNameDDL.SelectedValue + "' and EventID= '" + item.Value + "') Insert into EventPresenters (PersonnelID, EventID, Role) values('" + CoordinatorNameDDL.SelectedValue + "','" + item.Value + "',(select PersonnelType from EventPersonnel where VolunteerID=" + CoordinatorNameDDL.SelectedItem.Value + ")) ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlStatement = "DELETE FROM EventPresenters WHERE PersonnelID ='" + CoordinatorNameDDL.SelectedValue + "' and EventID ='" + item.Value + "' ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    string msg = "Insert/Update Error:";
                    msg += ex.Message;
                    throw new Exception(msg);
                }
                finally
                {
                    // close the Sql Connection
                    connection.Close();
                }
            }
        }

        protected void menuTabsCurrent_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu menuTabsCurrent = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("multiviewStudent") as MultiView;
            multiTabs.ActiveViewIndex = Int32.Parse(menuTabsCurrent.SelectedValue);
        }

        protected void TeacherMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu TeacherMenu = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("TeacherView") as MultiView;
            multiTabs.ActiveViewIndex = Int32.Parse(TeacherMenu.SelectedValue);
        }

        protected void VolunteerMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu VolunteerMenu = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("VolunteerMultiView") as MultiView;
            multiTabs.ActiveViewIndex = Int32.Parse(VolunteerMenu.SelectedValue);
        }

        protected void CoordinatorMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu CoordinatorMenu = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("CoordinatorMultiView") as MultiView;
            multiTabs.ActiveViewIndex = Int32.Parse(CoordinatorMenu.SelectedValue);
        }

        protected void StudentUpdateButton_Click(object sender, EventArgs e)
        {
            //If filled out and non duplicate it inserts into object
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            int sub;
            try
            {
                // open the Sql connection
                connection.Open();
                //Check for size in Note field and insert temporarily or permanently into DB if it does not exist

                if (StudentNotesData.Text.Length > 20)
                {
                    sub = 20;
                }
                else
                {
                    sub = StudentNotesData.Text.Length;
                }
                string sqlStatement = "UPDATE Student SET Age ='" + StudentAgeEdit.SelectedValue + "', Notes = @Notes, TshirtID = (SELECT  TshirtID FROM[Lab1].[dbo].Tshirt where Size = '" + StudentSizeEdit.SelectedValue + "' and Color = '" + StudentColorEdit.SelectedValue + "')" +
                    "Where StudentID ='" + StID + "'";
                cmd = new SqlCommand(sqlStatement, connection);
                cmd.Parameters.AddWithValue("@Notes", NotesTextBox.Text.Substring(0, sub));
                cmd.CommandType = CommandType.Text;
                cmd.ExecuteNonQuery();
            }
            //If it does not work
            catch (System.Data.SqlClient.SqlException ex)
            {
                string msg = "Update Error:";
                msg += ex.Message;
                throw new Exception(msg);
            }
            finally
            {
                // close the Sql Connection
                connection.Close();
            }
        }
    }
}