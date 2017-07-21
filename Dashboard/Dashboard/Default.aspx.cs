using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Drawing;
using Tweetinvi;

namespace Dashboard
{
    public partial class Default : System.Web.UI.Page
    {
        private Entities context;
        protected void Page_Load(object sender, EventArgs e)
        {

            //// Use this method for anything you want to initialise on page load
            // var Twitter = (from t in context.TweetDatas
            //               select t);

            //Top_Tweets t = new Top_Tweets();

            //var Twitter = (from t in context.Tweets
            //               select t);

            //Most_Retweets t = new Most_Retweets();

            //context.Tweets.Add(t);
            //context.SaveChanges();

            //var Most_Retweets = (from re in context.most_retweets_numbered)
            GetMostRetweetsText();
            GetTopTweetsText();
            
        }
  
        /// <summary>
        /// This method is used to pull the data from the database and return the data into a list of the relevant object which
        /// which is then used on the aspx page.  You will need a method for each Panel of data
        /// 
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static List<Top_Tweets> GetTopTweets()
        {
            //Could use linq queries if connection to the DB is set up using using Entity Framework
            //Code provides read only access
            
            //Open Database Connections
            SqlConnection obj_Conn = new SqlConnection();
            SqlCommand obj_Cmd = new SqlCommand();
            SqlDataAdapter obj_DA = new SqlDataAdapter(obj_Cmd);

            obj_Conn.ConnectionString = ConfigurationManager.ConnectionStrings["Azure_Connection"].ToString();
            obj_Cmd.Connection = obj_Conn;
            obj_Conn.Open();

            //Execute Stored Procedure - Easiest way to pull data when it's not being modified (avoids sql injection)
            //Can also use linq queries if DB context is set up

            using (SqlCommand cmd = new SqlCommand("dbo.sp_top_tweets_numbered", obj_Conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();

                obj_DA.SelectCommand = cmd;
                //Create a datatable to fill with the info 
                DataTable dt_Top_Tweets = new DataTable();
                obj_DA.Fill(dt_Top_Tweets);


                //Create a list of the object typpe
                List<Top_Tweets> dataList = new List<Top_Tweets>();

                //Loop through the DB and create a new object  
                foreach (DataRow dr_Top_Tweets in dt_Top_Tweets.Rows)
                {
                    Top_Tweets details = new Top_Tweets();
                    details.user_name = dr_Top_Tweets[0].ToString();
                    details.tweet_followers_count = Convert.ToInt32(dr_Top_Tweets[1]);

                    //Add this object to the list
                    dataList.Add(details);
                }

                //Close Database Connections
                if (obj_Conn.State == ConnectionState.Open)
                {
                    obj_Conn.Close();
                }
                obj_Cmd.Dispose();
                obj_Cmd.Dispose();
                obj_Conn.Dispose();

                return dataList;
            }

        }
       
        
        /// <summary>
        /// This is the object class. 
        /// </summary>
        public class Top_Tweets
        {
            public string user_name { get; set; }
            public int tweet_followers_count { get; set; }

        }


        [WebMethod]
        public static List<Most_Retweets> GetMostRetweets()
        {
            //Could use linq queries if connection to the DB is set up using using Entity Framework
            //Code provides read only access

            //Open Database Connections
            SqlConnection obj_Conn = new SqlConnection();
            SqlCommand obj_Cmd = new SqlCommand();
            SqlDataAdapter obj_DA = new SqlDataAdapter(obj_Cmd);

            obj_Conn.ConnectionString = ConfigurationManager.ConnectionStrings["Azure_Connection"].ToString();
            obj_Cmd.Connection = obj_Conn;
            obj_Conn.Open();

            //Execute Stored Procedure - Easiest way to pull data when it's not being modified (avoids sql injection)
            //Can also use linq queries if DB context is set up

            using (SqlCommand cmd = new SqlCommand("dbo.sp_most_retweets_numbered", obj_Conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();

                obj_DA.SelectCommand = cmd;
                //Create a datatable to fill with the info 
                DataTable dt_Most_Retweets = new DataTable();
                obj_DA.Fill(dt_Most_Retweets);


                //Create a list of the object typpe
                List<Most_Retweets> dataList = new List<Most_Retweets>();

                //Loop through the database and create a new object.  
                foreach (DataRow dr_Most_Retweets in dt_Most_Retweets.Rows)
                {
                    Most_Retweets details = new Most_Retweets();
                    details.user_name = dr_Most_Retweets[0].ToString();
                    details.retweet_count = Convert.ToInt32(dr_Most_Retweets[1]);

                    //Add this object to the list
                    dataList.Add(details);
                }

                //Close Database Connections
                if (obj_Conn.State == ConnectionState.Open)
                {
                    obj_Conn.Close();
                }
                obj_Cmd.Dispose();
                obj_Cmd.Dispose();
                obj_Conn.Dispose();

                return dataList;
            }
        }
        /// <summary>
        /// This is the object class. 
        /// </summary>
        public class Most_Retweets
        {
            public string user_name { get; set; }
            public int retweet_count { get; set; }

        }

        [WebMethod]
        public static List<Time_Series> GetTimeSeries()
        {
            //Could use linq queries if connection to the DB is set up using using Entity Framework
            //Code provides read only access

            //Open Database Connections
            SqlConnection obj_Conn = new SqlConnection();
            SqlCommand obj_Cmd = new SqlCommand();
            SqlDataAdapter obj_DA = new SqlDataAdapter(obj_Cmd);

            obj_Conn.ConnectionString = ConfigurationManager.ConnectionStrings["Azure_Connection"].ToString();
            obj_Cmd.Connection = obj_Conn;
            obj_Conn.Open();

            ///Execute Stored Procedure - Easiest way to pull data when it's not being modified (avoids sql injection)
            //Can also use linq queries if DB context is set up

            using (SqlCommand cmd = new SqlCommand("dbo.sp_time_series_data_3_day", obj_Conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();

                obj_DA.SelectCommand = cmd;
                //Create a datatable to fill with the info 
                DataTable dt_Time_Series = new DataTable();
                obj_DA.Fill(dt_Time_Series);


                //Create a list of the object type
                List<Time_Series> dataList = new List<Time_Series>();

                //Loop through the DB and create a new object  
                foreach (DataRow dr_Time_Series in dt_Time_Series.Rows)
                {
                    Time_Series details = new Time_Series();
                    details.bucket_time = Convert.ToDateTime(dr_Time_Series[0]);
                    details.tweets_this_hour = Convert.ToInt32(dr_Time_Series[1]);

                    //Add this object to the list
                    dataList.Add(details);
                }

                //Close Database Connections
                if (obj_Conn.State == ConnectionState.Open)
                {
                    obj_Conn.Close();
                }
                obj_Cmd.Dispose();
                obj_Cmd.Dispose();
                obj_Conn.Dispose();

                return dataList;
            }
        }
        /// <summary>
        /// This is the object class. 
        /// </summary>
        public class Time_Series
        {
            public DateTime bucket_time { get; set; }
            public int tweets_this_hour { get; set; }

        }

        protected void GetTopTweetsText()
        {
            //Could use linq queries if connection to the DB is set up using using Entity Framework
            //Code provides read only access

            //Open Database Connections
            SqlConnection obj_Conn = new SqlConnection();
            SqlCommand obj_Cmd = new SqlCommand();
            SqlDataAdapter obj_DA = new SqlDataAdapter(obj_Cmd);

            obj_Conn.ConnectionString = ConfigurationManager.ConnectionStrings["Azure_Connection"].ToString();
            obj_Cmd.Connection = obj_Conn;
            obj_Conn.Open();

            //Execute Stored Procedure - Easiest way to pull data when it's not being modified (avoids sql injection)
            //Can also use linq queries if DB context is set up

            using (SqlCommand cmd = new SqlCommand("dbo.sp_top_tweets_with_text", obj_Conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();

                obj_DA.SelectCommand = cmd;
                //Create a datatable to fill with the info 
                DataTable dt_Top_Tweets_Text = new DataTable();
                obj_DA.Fill(dt_Top_Tweets_Text);


                //Create a list of the object typpe
                List<Top_Tweets_Text> dataList = new List<Top_Tweets_Text>();

                //Loop through the DB and create a new object  
                foreach (DataRow dr_Top_Tweets_Text in dt_Top_Tweets_Text.Rows)
                {
                    Top_Tweets_Text details = new Top_Tweets_Text();
                    details.user_name = dr_Top_Tweets_Text[0].ToString();
                    details.tweet_followers_count = Convert.ToInt32(dr_Top_Tweets_Text[1]);
                    details.tweet_text = dr_Top_Tweets_Text[2].ToString();

                    //Add this object to the list
                    dataList.Add(details);
                }

                //Close Database Connections
                if (obj_Conn.State == ConnectionState.Open)
                {
                    obj_Conn.Close();
                }
                obj_Cmd.Dispose();
                obj_Cmd.Dispose();
                obj_Conn.Dispose();



                gvTopTweets.DataSource = dataList;
                gvTopTweets.DataBind();


            }
                        
        }
        /// <summary>
        /// This is the object class. 
        /// </summary>
        public class Top_Tweets_Text
        {
            public string user_name { get; set; }
            public int tweet_followers_count { get; set; }
            public string tweet_text { get; set; }

        }

        protected void GetMostRetweetsText()
        {
            //Could use linq queries if connection to the DB is set up using using Entity Framework
            //Code provides read only access

            //Open Database Connections
            SqlConnection obj_Conn = new SqlConnection();
            SqlCommand obj_Cmd = new SqlCommand();
            SqlDataAdapter obj_DA = new SqlDataAdapter(obj_Cmd);

            obj_Conn.ConnectionString = ConfigurationManager.ConnectionStrings["Azure_Connection"].ToString();
            obj_Cmd.Connection = obj_Conn;
            obj_Conn.Open();

            //Execute Stored Procedure - Easiest way to pull data when it's not being modified (avoids sql injection)
            //Can also use linq queries if DB context is set up

            using (SqlCommand cmd = new SqlCommand("dbo.sp_most_retweets_with_text", obj_Conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();

                obj_DA.SelectCommand = cmd;
                //Create a datatable to fill with the info
                DataTable dt_Most_Retweets_Text = new DataTable();
                obj_DA.Fill(dt_Most_Retweets_Text);


                //Create a list of the object type
                List<Most_Retweets_Text> dataList = new List<Most_Retweets_Text>();

                //Loop through the DB and create a new object  
                foreach (DataRow dr_Most_Retweets_Text in dt_Most_Retweets_Text.Rows)
                {
                    Most_Retweets_Text details = new Most_Retweets_Text();
                    details.user_name = dr_Most_Retweets_Text[0].ToString();
                    details.retweet_count = Convert.ToInt32(dr_Most_Retweets_Text[1]);
                    details.tweet_text = dr_Most_Retweets_Text[2].ToString();

                    //Add this object to the list
                    dataList.Add(details);
                }

                //Close Database Connections
                if (obj_Conn.State == ConnectionState.Open)
                {
                    obj_Conn.Close();
                }
                obj_Cmd.Dispose();
                obj_Cmd.Dispose();
                obj_Conn.Dispose();



                gvMostRetweets.DataSource = dataList;
                gvMostRetweets.DataBind();


            }




        }



        /// <summary>
        /// This is the object class. 
        /// </summary>
        public class Most_Retweets_Text
        {
            public string user_name { get; set; }
            public int retweet_count { get; set; }
            public string tweet_text { get; set; }

        }

        public static void getTwitterData()
        {
            // Authenicate app with Twitter access keys/tokens in order to stream tweets
            // TODO add to webconfig
            Auth.SetUserCredentials("kb4gUzm7W7822SrHGc6P6Iy4a", "UInt7OL0YNIgsmPxtlX3Vc4XUOUuIcrBm3aeWjKwIeg64VMqT5",
                "791271802987278336-nkRVnhkzWkJjA7cb9q6frNOVCnp57Go", "c5MCXbkTgJiUdzELk0YE7YADEgjIVXYQFxqcD6hHzdQun");

            

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchValue = txtSearch.Text;

            GetTwitterInfo gti = new GetTwitterInfo();
            gti.loadTwitterData(searchValue);

        }
    }
}