//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Dashboard
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tweet
    {
        public string tweet_ID { get; set; }
        public Nullable<System.DateTime> created_at { get; set; }
        public string user_name { get; set; }
        public Nullable<int> retweet_count { get; set; }
        public Nullable<int> tweet_followers_count { get; set; }
        public string user_location { get; set; }
        public string tweet_text { get; set; }
        public string name { get; set; }
        public string search_term { get; set; }
        public string original_post_user_name { get; set; }
    }
}