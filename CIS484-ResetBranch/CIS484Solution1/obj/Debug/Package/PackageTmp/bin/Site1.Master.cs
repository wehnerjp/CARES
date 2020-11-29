using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIS484Solution1
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        public static int UserLoginID;
        public static string UserLoginName = null;
        public static string UserLoginEmail = null;
        public static string UserLoginType = null;
        public static int UserLoginLocation;

        public enum MessageType { Success, Error, Info, Warning };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (LoginDiv.Style["display"] != "none")
            {
                UserLoginType = null;
                UserLoginID = -1;
                UserLoginLocation = -1;
                UserLoginName = null;
                UserLoginEmail = null;
            }
        }

        protected void MasterMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu MasterMenu = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("MasterMultiView") as MultiView;
            //MessageBox.Show(UserLoginType + Int32.Parse(MasterMenu.SelectedValue));
            if (UserLoginType != null)
            {
                multiTabs.ActiveViewIndex = Int32.Parse(MasterMenu.SelectedValue);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Not Authorized to Access this page!','Warning');", true);
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalLoginForm", "$('#modalLoginForm').modal();", true);
            }
        }

        protected void menuTabsCurrent_MenuItemClick(object sender, MenuEventArgs e)
        {
            System.Web.UI.WebControls.Menu menuTabsCurrent = sender as System.Web.UI.WebControls.Menu;
            MultiView multiTabs = this.FindControl("multiviewStudent") as MultiView;
            multiTabs.ActiveViewIndex = Int32.Parse(menuTabsCurrent.SelectedValue);
        }

        protected void ShowMessage(string Message, MessageType type)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
        }

        protected void LoginForm_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("IT WORKS");
            if (UserLoginType != null)
            {
                UserLoginType = null;
                UserLoginID = -1;
                UserLoginLocation = -1;

                UserLoginName = null;
                UserLoginEmail = null;
                //LoginForm.InnerHtml = "Launch Login Form";
                MasterMenu.Items[4].Text = "User: None";
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string email = HttpUtility.HtmlEncode(defaultFormEmail.Text);
            string pass = HttpUtility.HtmlEncode(defaultFormPass.Text);
            string type = "Select Type from Staff where Email = " + email;
            SqlConnection authConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString);
            SqlConnection dbConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["CARESconnection"].ConnectionString);
            SqlCommand loginCommand = new SqlCommand();
            loginCommand.Connection = authConnection;
            loginCommand.Parameters.AddWithValue("@Email", email);
            loginCommand.Parameters.AddWithValue("@Password", pass);
            dbConnection.Open();
            authConnection.Open();
            System.Data.SqlClient.SqlCommand findPass = new System.Data.SqlClient.SqlCommand();
            findPass.Connection = authConnection;
            findPass.CommandText = "Select * from Staff where Email = @Email";
            findPass.Parameters.Add(new SqlParameter("@Email", email));

            SqlDataReader reader = findPass.ExecuteReader();
            try
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        string storedHash = reader["Password"].ToString();
                        if (PasswordHash.ValidatePassword(defaultFormPass.Text, storedHash))
                        {
                            UserLoginEmail = email;
                            UserLoginType = reader.GetString(3).Trim();
                            UserLoginID = reader.GetInt32(0);
                            UserLoginLocation = reader.GetInt32(4);

                            string qry1 = "select * from Staff where Email='" + email + "'";
                            SqlCommand cmd1 = new SqlCommand(qry1, dbConnection);
                            SqlDataReader sdr1 = cmd1.ExecuteReader();
                            while (sdr1.Read())
                            {
                                UserLoginID = sdr1.GetInt32(0);
                                UserLoginName = (sdr1.GetString(1).Substring(0, 1) + ". " + sdr1.GetString(2));
                            }

                            ShowMessage("Logged in successfully as " + UserLoginName.Trim() + " Role: " + UserLoginType, MessageType.Success);
                            if (UserLoginEmail != null)
                            {
                                MasterMenu.Items[4].Text = HttpUtility.HtmlEncode((UserLoginName.Trim()).Trim());
                            }
                            else
                            {
                                ShowMessage("Still Null!" + reader.GetString(2), MessageType.Warning);
                            }
                            // LoginForm.InnerHtml = "LogOut";
                            LoginDiv.Style.Add("display", "none");
                            LogoutDiv.Style.Add("display", "block");
                            if (UserLoginType != "Admin")
                            {
                                MasterMenu.Items[3].Enabled = false;
                            }
                            else
                            {
                                MasterMenu.Items[3].Enabled = true;
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Wrong Password!','Warning');", true);
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Couldn't Find That Email!','Warning');", true);
                }
            }
            finally
            {
                dbConnection.Close();
                authConnection.Close();
            }

            // MessageBox.Show("IT WORKS");
            //ShowMessage("Heard! " + email + pass, MessageType.Info);
        }
    }
}