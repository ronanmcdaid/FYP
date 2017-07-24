using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tweetinvi;

namespace Dashboard
{
    public class Auth_Stream
    {
        static void Main(string[] args)
        {
            //API credentials
            Auth.SetUserCredentials("kb4gUzm7W7822SrHGc6P6Iy4a", "UInt7OL0YNIgsmPxtlX3Vc4XUOUuIcrBm3aeWjKwIeg64VMqT5",
                "791271802987278336-nkRVnhkzWkJjA7cb9q6frNOVCnp57Go", "c5MCXbkTgJiUdzELk0YE7YADEgjIVXYQFxqcD6hHzdQun");

            //var tweets = Search.SearchTweets("Belfast");


            var stream = Stream.CreateFilteredStream();
            stream.AddTrack("Belfast");
            stream.MatchingTweetReceived += (sender, argss) =>
            {
                Console.WriteLine("A tweet containing 'Belfast' has been found: " + argss.Tweet + "'");
            };
            stream.StartStreamMatchingAllConditions();
        }
    }
}

