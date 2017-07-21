using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Threading.Tasks;
using Tweetinvi;

namespace Dashboard
{
    public class GetTwitterInfo 
    {
       // private Entities context

        public void loadTwitterData(string searchterm)
        {
            using (var context = new Entities())
            {

              

              //  string searchterm = "belfast";

                // Set up your application credentials
                Auth.SetUserCredentials("kb4gUzm7W7822SrHGc6P6Iy4a", "UInt7OL0YNIgsmPxtlX3Vc4XUOUuIcrBm3aeWjKwIeg64VMqT5",
                    "791271802987278336-nkRVnhkzWkJjA7cb9q6frNOVCnp57Go", "c5MCXbkTgJiUdzELk0YE7YADEgjIVXYQFxqcD6hHzdQun");

                var user = User.GetAuthenticatedUser();

                var matchingTweets = Search.SearchTweets(searchterm);


                foreach (var mt in matchingTweets)
                {
                    string convertedID = mt.Id.ToString();

                    var existingTweet = (from t in context.TweetStreams
                                         where t.tweet_ID == convertedID
                                         select t).FirstOrDefault();

                    if (existingTweet == null)
                     {
                    TweetStream ts = new TweetStream();
                    ts.created_at = mt.CreatedAt;
                    ts.user_name = mt.CreatedBy.ToString();
                    ts.tweet_ID = mt.Id.ToString();
                    ts.retweet_count = mt.RetweetCount;
                    ts.tweet_followers_count = mt.CreatedBy.FollowersCount;
                    ts.tweet_text = mt.Text;
                    ts.name = mt.CreatedBy.Name;
                    ts.user_location = mt.CreatedBy.Location;
                    ts.search_term = searchterm;
                    ts.original_post_user_name = "";

                    context.TweetStreams.Add(ts);
                       

                    }
                    context.SaveChanges();
                }
               


            }
        }

    }
}