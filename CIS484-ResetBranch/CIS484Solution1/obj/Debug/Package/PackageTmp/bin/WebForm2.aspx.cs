using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Windows.Forms;
using System.Web.Services;
using CIS484Solution1;
using System.Windows.Media.Imaging;
using System.Text;
using System.Web.UI.DataVisualization.Charting;

namespace CIS484Solution1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        public static int StID = -1;
        private MemoryStream ms;
        public DataTable Cart;
        public DataView CartView;
        public static int CommenteeID;
        private object rblChartType;

        protected void Page_Load(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(
            //            UpdatePanel1,
            //            this.GetType(),
            //            "MyAction",
            //            "$(document).ready(function() { $('.js-example-basic-single').select2(); });",
            //            true);
            ScriptManager.RegisterStartupScript(
                UpdatePanel1,
                this.GetType(),
                "MyAction",
                "$(document).ready(function() { $('.js-example-basic-single').select2();  $('.grid').masonry({ itemSelector: '.grid-item', columnWidth: 160,  gutter: 20   }); $(document).ready(function () {$('#manBt').click(function() {$('#manPan1').slideToggle('slow');});});});",
                true);
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            //RepeterData();
            this.BindInventoryGrid();
            this.BindHoursGrid();
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
        }

        protected void MultiView_ActiveViewChanged(object sender, EventArgs e)
        {
            //Connect to DB
        }

        protected void LocationViewDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Queries Relevant to home page, fetching event info student info and more
            String sqlQuery =
                "Select * from Location where LocationID = " +
                LocationViewDDL.SelectedItem.Value;
            String sqlQuery1 =
                "SELECT StaffID, FirstName + ' ' + LastName as Name from Staff " +
                "where LocationID = " + LocationViewDDL.SelectedItem.Value;
            String sqlQuery3 =
                "select * from Event where LocationID = " +
                LocationViewDDL.SelectedItem.Value;
            String sqlQuery2 =
                "select StaffID, FirstName + ' ' + LastName as Name from Staff where Type = 'Admin' and LocationID = " +
                LocationViewDDL.SelectedItem.Value;

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);
            SqlDataAdapter sqlAdapter2 = new SqlDataAdapter(sqlQuery2, con);
            SqlDataAdapter sqlAdapter3 = new SqlDataAdapter(sqlQuery3, con);

            var items = new List<string>();

            using (SqlCommand command = new SqlCommand(sqlQuery2, con))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        //Read info into List
                        items.Add(reader.GetString(1));
                    }
                }
            }

            Repeater1.DataSource = items;
            Repeater1.DataBind();
            //Fill table with data
            DataTable dt = new DataTable();
            sqlAdapter1.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                WorkerListLabel.Text = "Employees At This Location: ";

                WorkerListBox.DataSource = dt;
                WorkerListBox.DataValueField = "StaffID";

                WorkerListBox.DataTextField = "Name";
                WorkerListBox.DataBind();
            }
            DataTable dt2 = new DataTable();
            sqlAdapter3.Fill(dt2);

            if (dt2.Rows.Count > 0)
            {
                EventListBox.DataSource = dt2;
                EventListBox.DataValueField = "EventID";
                EventListBox.DataTextField = "EventName";
                EventListBox.DataBind();
            }
            DataSet ds = new DataSet();

            sqlAdapter.Fill(ds);

            FormView2.DataSource = ds;
            FormView2.DataBind();
            con.Close();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal1();", true);
        }

        protected void EventListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            String sqlQuery = "select * from Event where EventID = " + EventListBox.SelectedItem.Value;
            String sqlQuery1 = "select S.StaffID, S.FirstName + ' ' + S.LastName as Name from Staff S inner join EventAttendees E on E.StaffID = S.StaffID where EventID = " + EventListBox.SelectedItem.Value;

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);

            DataSet ds = new DataSet();

            sqlAdapter.Fill(ds);

            FormView4.DataSource = ds;
            FormView4.DataBind();
            DataTable dt = new DataTable();
            sqlAdapter1.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                WorkerListLabel.Text = "Employees Attending Event: ";
                WorkerListBox.DataSource = dt;
                EventListBox.DataValueField = "StaffID";
                WorkerListBox.DataTextField = "Name";
                WorkerListBox.DataBind();
            }
            con.Close();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal1();", true);
        }

        protected void WorkerListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            String sqlQuery = "Select StaffID, FirstName + ' ' + LastName as Name, StartDate, Email, Type from Staff where StaffID = " + WorkerListBox.SelectedItem.Value;

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlQuery, con);

            DataSet ds = new DataSet();

            sqlAdapter.Fill(ds);

            FormView1.DataSource = ds;
            FormView1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal1();", true);

            con.Close();
        }

        protected void AddAdmin_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("Admin");
            //Inserting teacher query
            String sqlQuery = "If Not Exists (select 1 from Staff where FirstName= @FirstName and LastName= @LastName)  Insert into Staff (FirstName, LastName, Type, LocationID, Email, Password, StaffPicture) values " +
                "(@FirstName, @LastName, '" + "Admin" + "', @LocationID, @Email, @Password, @Image); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();
                if (ImageUpload.HasFile)
                {
                    ////using MemoryStream:
                    //ms = new MemoryStream();
                    //ImageUpload.Image.Save(ms, ImageFormat.Jpeg);
                    //byte[] photo_aray = new byte[ms.Length];
                    //ms.Position = 0;
                    //ms.Read(photo_aray, 0, photo_aray.Length);
                    //cmd.Parameters.AddWithValue("@photo", photo_aray);

                    int imagefilelength = ImageUpload.PostedFile.ContentLength;
                    byte[] imgarray = new byte[imagefilelength];
                    HttpPostedFile image = ImageUpload.PostedFile;
                    image.InputStream.Read(imgarray, 0, imagefilelength);
                    command.Parameters.Add("@Image", SqlDbType.Image, imgarray.Length).Value = imgarray;
                    //MessageBox.Show("Inserted image");
                }
                else
                {
                    //MessageBox.Show("Default image");
                    string fName = "..\\defaultUserIcon.jpg";
                    byte[] content = ImageToStream(fName);

                    command.Parameters.Add("@Image", SqlDbType.Image, content.Length).Value = content;
                }
                command.Parameters.Add(new SqlParameter("@FirstName", StaffFirstName.Text));
                command.Parameters.Add(new SqlParameter("@LastName", StaffLastName.Text));
                command.Parameters.Add(new SqlParameter("@LocationID", StaffLocationDDL.SelectedValue));
                command.Parameters.Add(new SqlParameter("@Email", StaffEmail.Text));
                command.Parameters.Add(new SqlParameter("@Password", PasswordHash.HashPassword(modalLRInput13.Text)));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert admin success");

                    ResetStaffButton_Click(sender, e);
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //MessageBox.Show("insert admin failure");
                }
                con.Close();
            }
        }

        private byte[] ImageToStream(string fileName)
        {
            MemoryStream stream = new MemoryStream();

            try
            {
                Bitmap image = new Bitmap(fileName);
                image.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (Exception ex)
            {
                //MessageBox.Show("No Cigar");
            }

            return stream.ToArray();
        }

        protected void ResetStaffButton_Click(object sender, EventArgs e)
        {
            //clear teacher input
            StaffFirstName.Text = string.Empty;
            StaffLastName.Text = string.Empty;
            StaffLocationDDL.SelectedIndex = 0;
            StaffEmail.Text = string.Empty;
            modalLRInput13.Text = string.Empty;
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

        protected void EventLocationDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Similar process for reacting to coordinator selection as with volunteer

            String sqlQuery1 = "Select EventID, EventName, EventName + '    ' +  convert(nvarchar, convert(nvarchar, EventDate, 0)) as EventNameTime, EventDate from Event where LocationID='" + DropDownList1.SelectedValue + "'";

            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            DataTable dtx = new DataTable();
            SqlDataAdapter sqlAdapter1 = new SqlDataAdapter(sqlQuery1, con);
            sqlAdapter1.Fill(dtx);
            DataSet ds = new DataSet();

            //Displaying events below for coordinator sign up
            if (dtx.Rows.Count > 0)
            {
                EventCheckBoxList.DataSource = dtx;
                EventCheckBoxList.DataTextField = "EventNameTime";
                EventCheckBoxList.DataValueField = "EventID";
                EventCheckBoxList.DataBind();
            }

            if (EventCheckBoxList.Items.Count > 1 && DropDownList1.SelectedItem.Value != null)
            {
                EventSignUpCheckBoxListSelect();
            }
            con.Close();
        }

        protected void EventSignUpCheckBoxListSelect()
        {
            //Determines inital boolean values for selection Coo. Event List
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            con.Open();

            if (Site1.UserLoginID != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Select EP.EventID from EventAttendees EP where EP.StaffID = '" + Site1.UserLoginID + "'", con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    for (int i = 0; i < EventCheckBoxList.Items.Count; i++)
                        EventCheckBoxList.Items[i].Selected = false;

                    while (reader.Read())
                    {
                        ListItem li = EventCheckBoxList.Items.FindByValue(reader["EventID"].ToString());
                        if (li != null)
                        {
                            li.Selected = true;
                        }
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                }
                catch (Exception)
                {
                    Response.Redirect("user.aspx", false);
                }
            }
        }

        protected void WorkerEventCheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Enables coordinator sign up interaction with DB and live modification

            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            string sqlStatement = string.Empty;
            if (Site1.UserLoginID != null)
            {
                try
                {
                    // open the Sql connection
                    connection.Open();
                    foreach (ListItem item in EventCheckBoxList.Items)
                    {
                        if (item.Selected)
                        {
                            sqlStatement = "If Not Exists (select 1 from EventAttendees where StaffID= '" + Site1.UserLoginID + "' and EventID= '" + item.Value + "') Insert into EventAttendees (EventID, StaffID) values('" + item.Value + "', '" + Site1.UserLoginID + "') ";
                            cmd = new SqlCommand(sqlStatement, connection);
                            cmd.CommandType = CommandType.Text;
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            sqlStatement = "DELETE FROM EventAttendees WHERE StaffID ='" + Site1.UserLoginID + "' and EventID ='" + item.Value + "' ";
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

        //protected void StudentUpdateButton_Click(object sender, EventArgs e)
        //{
        //    //If filled out and non duplicate it inserts into object
        //    string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        //    SqlConnection connection = new SqlConnection(strcon);
        //    SqlCommand cmd;
        //    int sub;
        //    try
        //    {
        //        // open the Sql connection
        //        connection.Open();
        //        //Check for size in Note field and insert temporarily or permanently into DB if it does not exist

        //        if (StudentNotesData.Text.Length > 20)
        //        {
        //            sub = 20;
        //        }
        //        else
        //        {
        //            sub = StudentNotesData.Text.Length;
        //        }
        //        string sqlStatement = "UPDATE Student SET Age ='" + StudentAgeEdit.SelectedValue + "', Notes = @Notes, TshirtID = (SELECT  TshirtID FROM[Lab1].[dbo].Tshirt where Size = '" + StudentSizeEdit.SelectedValue + "' and Color = '" + StudentColorEdit.SelectedValue + "')" +
        //            "Where StudentID ='" + StID + "'";
        //        cmd = new SqlCommand(sqlStatement, connection);
        //        cmd.Parameters.AddWithValue("@Notes", StudentNotesData.Text.Substring(0, sub));
        //        cmd.CommandType = CommandType.Text;
        //        cmd.ExecuteNonQuery();
        //    }
        //    //If it does not work
        //    catch (System.Data.SqlClient.SqlException ex)
        //    {
        //        string msg = "Update Error:";
        //        msg += ex.Message;
        //        throw new Exception(msg);
        //    }
        //    finally
        //    {
        //        // close the Sql Connection
        //        connection.Close();
        //    }
        //}

        protected void AddComment_Click(object sender, EventArgs e)
        {
            var imgbtn = (System.Web.UI.WebControls.Button)sender;
            var item = (DataListItem)imgbtn.NamingContainer;
            // the datasource is not available on postback, but you have all other controls
            var StaffName = (System.Web.UI.WebControls.Label)item.FindControl("StaffIdLabel");
            CommenteeID = int.Parse(StaffName.Text);
            //MessageBox.Show(CommenteeID.ToString());
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "basicExampleModal", "$('#basicExampleModal').modal();", true);
            RepeterData();
        }

        protected void commentSubmit_click(object sender, EventArgs e)
        {
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strcon);
            SqlCommand cmd;
            SqlCommand cmd1;

            try
            {
                con.Open();
                cmd = new SqlCommand("Insert into Comments (CommentContent, StaffID) values(@CommentContent, @StaffID)", con);
                cmd.Parameters.Add("@CommentContent", SqlDbType.VarChar).Value = txtComment.Text.ToString();
                cmd.Parameters.Add("@StaffID", SqlDbType.Int).Value = Site1.UserLoginID;
                //MessageBox.Show(Site1.UserLoginID.ToString());

                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                txtComment.Text = ex.Message;
            }
            try
            {
                con.Open();

                cmd1 = new SqlCommand("Insert into StaffComments (StaffID, CommentID) values (@StaffID, (select CommentID from Comments where CommentContent = @CommentContent))", con);
                cmd1.Parameters.Add("@CommentContent", SqlDbType.VarChar).Value = txtComment.Text.ToString();
                //MessageBox.Show(CommenteeID.ToString());

                cmd1.Parameters.Add("@StaffID", SqlDbType.Int).Value = CommenteeID;
                cmd1.ExecuteNonQuery();

                con.Close();
                txtComment.Text = string.Empty;
                RepeterData();
            }
            catch (Exception ex)
            {
                txtComment.Text += ex.Message;
            }
        }

        public void RepeterData()
        {
            SqlDataAdapter da;
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strcon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select C.CommentID as CommentID, C.CommentContent as CommentContent, (Select SX.FirstName + ' ' + SX.LastName as StaffName from Staff SX where StaffID = C.StaffID) as StaffName from Comments C " +
                                 " inner join StaffComments SC on SC.CommentID = C.CommentID " +
                                 " inner join Staff S on S.StaffID = SC.StaffID " +
                                 " where S.StaffID = @CommenteeID", con);
            //MessageBox.Show("CommenteeID", CommenteeID.ToString());

            cmd.Parameters.Add("@CommenteeID", SqlDbType.Int).Value = CommenteeID;

            DataSet ds = new DataSet();
            da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            RepterDetails.DataSource = ds;
            RepterDetails.DataBind();
            //MessageBox.Show("CommentsPopulated");
        }

        protected void AddEmp_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("Emp");
            //Inserting teacher query
            String sqlQuery = "If Not Exists (select 1 from Staff where FirstName= @FirstName and LastName= @LastName)  Insert into Staff (FirstName, LastName, Type, LocationID, Manager, Email, Password, StaffPicture, StartDate) values " +
                "(@FirstName, @LastName, '" + EmpTypeDropDown.SelectedValue + "', @LocationID, @Manager, @Email, @Password, @Image, CURRENT_TIMESTAMP); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();
                if (ImageUpload1.HasFile)
                {
                    int imagefilelength = ImageUpload1.PostedFile.ContentLength;
                    byte[] imgarray = new byte[imagefilelength];
                    HttpPostedFile image = ImageUpload1.PostedFile;
                    image.InputStream.Read(imgarray, 0, imagefilelength);
                    command.Parameters.Add("@Image", SqlDbType.Image, imgarray.Length).Value = imgarray;
                    //MessageBox.Show("Inserted image");
                }
                else
                {
                    //MessageBox.Show("Default image");
                    string fName = "..\\defaultUserIcon.jpg";
                    byte[] content = ImageToStream(fName);

                    command.Parameters.Add("@Image", SqlDbType.Image, content.Length).Value = content;
                }
                command.Parameters.Add(new SqlParameter("@FirstName", EmpFirstName.Text));
                command.Parameters.Add(new SqlParameter("@LastName", EmpLastName.Text));
                command.Parameters.Add(new SqlParameter("@LocationID", EmpLocationDDL.SelectedValue));
                command.Parameters.Add(new SqlParameter("@Manager", ManagerCheckBox.Checked));
                command.Parameters.Add(new SqlParameter("@Email", EmpEmailTextBox.Text));
                command.Parameters.Add(new SqlParameter("@Password", PasswordHash.HashPassword(EmpPasswordTextBox.Text)));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert emp success");

                    ResetStaffButton_Click(sender, e);
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //MessageBox.Show("insert emp failure");
                }
                con.Close();
                EmpFirstName.Text = "";
                EmpLastName.Text = "";
                EmpEmailTextBox.Text = "";
                EmpPasswordTextBox.Text = "";
            }
        }

        protected void PopulateEmp_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void ResetEmpButton_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void AddLocation_Click(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "If Not Exists (select 1 from Location where LocationName= @LocationName)  Insert into Location (LocationName, LocationAddress, LocationCity, LocationZipCode) values " +
                "(@LocationName, @LocationAddress, @LocationCity, @LocationZipCode); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();

                command.Parameters.Add(new SqlParameter("@LocationName", LocationNameText.Text));
                command.Parameters.Add(new SqlParameter("@LocationAddress", LocationAddressText.Text));
                command.Parameters.Add(new SqlParameter("@LocationCity", LocationCity.Text));
                command.Parameters.Add(new SqlParameter("@LocationZipCode", LocationZip.Text));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert Location success");
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //MessageBox.Show("insert Location failure");
                }
                con.Close();
                LocationAddressText.Text = "";
                LocationNameText.Text = "";
                LocationCity.Text = "";
                LocationZip.Text = "";
            }
        }

        protected void AddDonation_Click(object sender, EventArgs e)
        {
            Decimal Amount = Convert.ToDecimal(DonationAmount.Text);

            //Inserting teacher query
            String sqlQuery = "Insert into MonetaryDonations (Amount, DonationDate, DonatorName) values " +
                              "(@Amount, CURRENT_TIMESTAMP, @DonatorName); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();

                command.Parameters.Add(new SqlParameter("@Amount", Amount));
                command.Parameters.Add(new SqlParameter("@DonatorName", DonatorName.Text));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert Donation success");
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //MessageBox.Show("insert Location failure");
                }

                con.Close();
            }

            //Inserting teacher query
            String sqlQuery1 = "Insert into CaresBank (TransAmount, Type, Description, Date, LocationID) values " +
                               "(@Amount, 'Donation', 'Donation Inputted by Admin', CURRENT_TIMESTAMP, " + Site1.UserLoginLocation + "); ";

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con1 = new SqlConnection(strcon);
            using (SqlCommand command1 = new SqlCommand(sqlQuery1, con))
            {
                con.Open();

                command1.Parameters.Add(new SqlParameter("@Amount", Amount));

                try
                {
                    command1.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert Donation success");
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //essageBox.Show("insert Donation failure");
                }

                con1.Close();
                DonatorName.Text = "";
                DonationAmount.Text = "";
            }
        }

        private void BindEmployeeDetails()
        {
            throw new NotImplementedException();
        }

        protected void AddHours_Click(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "Insert into Hours (StaffID, TimeIn, TimeOut, Date) values " +
                              "(@StaffID, @TimeIn, @TimeOut, @Date); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();

                command.Parameters.Add(new SqlParameter("@StaffID", Site1.UserLoginID));
                command.Parameters.Add(new SqlParameter("@TimeIn", EmployeeTimeIn.Text));
                command.Parameters.Add(new SqlParameter("@TimeOut", EmployeeTimeOut.Text));
                command.Parameters.Add(new SqlParameter("@Date", EmployeeHoursCalendar.SelectedDate));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert hours successful");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Logged Hours','Success');", true);
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Couldn't Log Hours','Warning');", true);
                }
                BindHoursGrid();
                con.Close();
            }
        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            //Inserting teacher query
            //Inserting teacher query
            String sqlQuery = "Insert into Event (EventName, EventDate, EventDescription, LocationID) values " +
                              "(@EventName, @EventDate, @EventDescription, @LocationID); ";
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();

                command.Parameters.Add(new SqlParameter("@EventName", EventNameTextBox.Text));
                command.Parameters.Add(new SqlParameter("@EventDate", EventCalendar.SelectedDate));
                command.Parameters.Add(new SqlParameter("@EventDescription", EventDescription.Text));
                command.Parameters.Add(new SqlParameter("@LocationID", EventLocationDDL.SelectedValue));

                try
                {
                    command.ExecuteNonQuery();
                    Console.Write("insert hours successful");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Event Added','Success');", true);
                    EventNameTextBox.Text = "";
                    EventDescription.Text = "";
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Couldn't Add Event','Warning');", true);
                }

                con.Close();
            }
        }

        protected void EmployeeHoursCalendar_OnSelectionChanged(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "SELECT * from Hours where Date= @Date and StaffID = @StaffID";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            SqlCommand command = new SqlCommand(sqlQuery, con);
            command.Parameters.Add(new SqlParameter("@Date", EmployeeHoursCalendar.SelectedDate));
            command.Parameters.Add(new SqlParameter("@StaffID", Site1.UserLoginID));
            con.Open();
            SqlDataReader myReader = command.ExecuteReader();

            if (myReader.Read())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Hours already submitted for this date','Warning');", true);
                SubmitHours.Enabled = false;
            }
            else if (EmployeeHoursCalendar.SelectedDate > DateTime.Today)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('You cannot select a future date','Warning');", true);
                SubmitHours.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Date Selected','Success');", true);

                SubmitHours.Enabled = true;
            }
            con.Close();
        }

        protected void EventCalendar_OnSelectionChanged(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "SELECT * from Event where EventDate= @Date and LocationID = @LocationID";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            SqlCommand command = new SqlCommand(sqlQuery, con);
            command.Parameters.Add(new SqlParameter("@Date", EventCalendar.SelectedDate));
            command.Parameters.Add(new SqlParameter("@LocationID", EventLocationDDL.SelectedValue));
            con.Open();
            SqlDataReader myReader = command.ExecuteReader();

            if (myReader.Read())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Event Already Exists This Day!','Warning');", true);
                SubmitEvent.Enabled = false;
            }
            else if (EventCalendar.SelectedDate < DateTime.Today)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('You cannot select a past date','Warning');", true);
                SubmitEvent.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Date Selected','Success');", true);

                SubmitEvent.Enabled = true;
            }
            con.Close();
        }

        protected void AddClothingDonation_Click(object sender, EventArgs e)
        {
            //Inserting teacher query
            String sqlQuery = "Insert into DonationInventory (ArticleName, ArticleType, ArticleSize, ArticleLocationID, ArticleDescription, ArticlePrice, DateArrived) values " +
                              "(@ArticleName, @ArticleType, @ArticleSize, @ArticleLocationID, @ArticleDescription, @ArticlePrice, GETDATE()); ";
            //Get connection string from web.config file
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            //Inserting teacher query
            //MessageBox.Show("F");
            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con = new SqlConnection(strcon);
            using (SqlCommand command = new SqlCommand(sqlQuery, con))
            {
                con.Open();
                //MessageBox.Show("W");

                command.Parameters.Add(new SqlParameter("@ArticleName", ArticleNameText.Text));
                command.Parameters.Add(new SqlParameter("@ArticleType", ArticleTypeDDL.SelectedValue));
                command.Parameters.Add(new SqlParameter("@ArticleLocationID", Site1.UserLoginLocation));
                command.Parameters.Add(new SqlParameter("@ArticleDescription", ArticleDescriptionText.Text));
                command.Parameters.Add(new SqlParameter("@ArticlePrice", System.Decimal.Parse(ArticlePriceText.Text)));
                command.Parameters.Add(new SqlParameter("@ArticleSize", ArticleSizeDDL.SelectedValue));

                try
                {
                    //MessageBox.Show("D");

                    command.ExecuteNonQuery();
                    //MessageBox.Show("a");

                    //Console.Write("insert Donation successful");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Recorded Donation','Success');", true);
                }
                catch (SqlException ex)
                {
                    //MessageBox.Show("P");

                    Console.Write(ex.Message);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Couldn't Record Donation','Warning');", true);
                }
                BindInventoryGrid();
                ArticleNameText.Text = "";
                ArticleDescriptionText.Text = "";
                ArticlePriceText.Text = "";

                con.Close();
            }
        }

        private void BindInventoryGrid()
        {
            string sqlQuery;
            if (Site1.UserLoginType == "Admin")
            {
                sqlQuery = "Select * from DonationInventory where ArticleSold IS NULL;";
            }
            else if (Site1.UserLoginType == null)
            {
                sqlQuery = "Select * from DonationInventory where ArticleSold IS NULL;";
            }
            else
            {
                sqlQuery = "Select * from DonationInventory where ArticleLocationID = '" + Site1.UserLoginLocation + "' and ArticleSold IS NULL;";
            }

            string constr = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            InventoryGridview.DataSource = dt;
                            InventoryGridview.DataBind();
                        }
                    }
                }
            }
        }

        protected void InventoryGridview_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            //If filled out and non duplicate it inserts into object
            string strcon = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            SqlConnection connection = new SqlConnection(strcon);
            SqlCommand cmd;
            int sub;
            try
            {
                // open the Sql connection
                connection.Open();
                //Check for size in Note field and insert temporarily or permanently into DB if it does not exist

                string sqlStatement = "UPDATE DonationInventory SET ArticleSold = 1, DateSold = GETDATE()" +
                    "Where ArticleID ='" + InventoryGridview.SelectedRow.Cells[0].Text + "'";
                cmd = new SqlCommand(sqlStatement, connection);
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
            //Inserting teacher query
            String sqlQuery1 = "Insert into CaresBank (TransAmount, Type, Description, StaffID, LocationID, Date) values " +
                               "((Select ArticlePrice from DonationInventory where ArticleID ='" + InventoryGridview.SelectedRow.Cells[0].Text + "'), 'Sale', 'Clothing Sale', '" + Site1.UserLoginID + "', '" + Site1.UserLoginLocation + "', CURRENT_TIMESTAMP); ";

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            SqlConnection con1 = new SqlConnection(strcon);
            using (SqlCommand command1 = new SqlCommand(sqlQuery1, con1))
            {
                con1.Open();
                ////MessageBox.Show(Decimal.Parse(InventoryGridview.SelectedRow.Cells[5].Text).ToString());
                //MessageBox.Show(InventoryGridview.SelectedRow.Cells[0].Text);
                //MessageBox.Show(InventoryGridview.SelectedRow.Cells[1].Text);
                //MessageBox.Show(InventoryGridview.SelectedRow.Cells[2].Text);
                //MessageBox.Show(InventoryGridview.SelectedRow.Cells[3].Text);
                //MessageBox.Show(InventoryGridview.SelectedRow.Cells[4].Text);

                //command1.Parameters.Add(new SqlParameter("@Amount", Decimal.Parse(InventoryGridview.SelectedRow.Cells[5].Text)));

                try
                {
                    command1.ExecuteNonQuery();
                    Console.Write("insert successful");
                    //MessageBox.Show("insert Sale success");
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    //MessageBox.Show("insert Sale failure");
                }

                con1.Close();
            }
            //string name = InventoryGridview.SelectedRow.Cells[1].Text;

            ////Accessing TemplateField Column controls.
            //string country = (InventoryGridview.SelectedRow.FindControl("lblPrice") as System.Web.UI.WebControls.Label).Text;

            //lblValues.Text = "<b>Name:</b> " + name + " <b>Country:</b> " + country;
            BindInventoryGrid();
        }

        public void BindHoursGrid()
        {
            string query = string.Format("SELECT the_table.Last_Seven_Days_Dates, ISNULL(DATEDIFF(hour, H.TimeIn, H.TimeOut), 0) as Hour FROM (SELECT CAST(GETDATE() AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -2, GETDATE()) AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -3, GETDATE()) AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -4, GETDATE()) AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -5, GETDATE()) AS DATE) AS Last_Seven_Days_Dates UNION SELECT CAST(DATEADD(DAY, -6, GETDATE()) AS DATE) AS Last_Seven_Days_Dates) AS the_table left join (select * from Hours where StaffID = '" + Site1.UserLoginID + "') H on the_table.Last_Seven_Days_Dates = H.Date");

            DataTable dt = GetData(query);
            Chart1.DataSource = dt;
            //string[] x = new string[dt.Rows.Count];
            //int[] y = new int[dt.Rows.Count];
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    x[i] = dt.Rows[i][0].ToString();
            //    y[i] = Convert.ToInt32(dt.Rows[i][1]);
            //}

            //Chart1.Series[0].Points.DataBindXY(x, y);
            Chart1.Series[0].ChartType = SeriesChartType.Bar;
            Chart1.Legends[0].Enabled = true;
            Chart1.Series[0].XValueMember = "Last_Seven_Days_Dates";
            Chart1.Series[0].YValueMembers = "Hour";
            Chart1.DataBind();
            String sqlQuery1 = "Select SUM(DATEDIFF(hour, H.TimeIn, H.TimeOut)) as Hour, (SUM(DATEDIFF(hour, H.TimeIn, H.TimeOut)) * (select PayRate.PerHour from PayRate where StaffType='" + Site1.UserLoginType + "')) as Pay from Hours H WHERE Date >= DATEADD(day, -7, GETDATE())  and StaffID = '" + Site1.UserLoginID + "'; ";

            //Get connection string from web.config file
            //create new sqlconnection and connection to database by using connection string from web.config file
            string constr = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;

            SqlConnection con1 = new SqlConnection(constr);
            using (SqlCommand command1 = new SqlCommand(sqlQuery1, con1))
            {
                con1.Open();

                try
                {
                    SqlDataReader myReader = command1.ExecuteReader();
                    while (myReader.Read())
                    {
                        WeeklyHoursLabel.Text = (HttpUtility.HtmlEncode(myReader[0].ToString()));
                        WeeklyPayLabel.Text = (HttpUtility.HtmlEncode(myReader[1].ToString()));
                        TypeLabel.Text = Site1.UserLoginType;
                    }

                    Console.Write("Hours and Pay successful");
                    //MessageBox.Show("insert Sale success");
                }
                catch (SqlException ex)
                {
                    Console.Write(ex.Message);
                    MessageBox.Show("Hours and Pay failure");
                }
            }
            con1.Close();
        }

        private static DataTable GetData(string query)
        {
            string constr = ConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
                    {
                        sda.Fill(dt);
                    }

                    return dt;
                }
            }
        }
    }

    [Serializable]
    public class ClassToSerialize
    {
        public string name;
        public float[] fltArray;

        // constructor initializes name and creates the sample array of floats
        public ClassToSerialize(string theName)
        {
            this.name = theName;
            float[] theArray = new float[1000];
            Random rnd = new System.Random();
            for (int i = 0; i < 1000; i++)
                theArray[i] = (float)rnd.NextDouble() * 1000;
            fltArray = theArray;
        }
    }
}