/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javatwitter1;

import java.util.List;
import twitter4j.Status;
import twitter4j.TwitterException;
import twitter4j.conf.ConfigurationBuilder;
import twitter4j.TwitterFactory;
//import twitter4j.SavedSearch;
import twitter4j.Trends;
/**
 *
 * @author Ronan
 */
public class JavaTwitter1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws TwitterException {
        ConfigurationBuilder cf = new ConfigurationBuilder();
        
       cf.setDebugEnabled(true)
               .setOAuthConsumerKey("njPT8OB12bxkbDQJ0d4VOAZ2d")
               .setOAuthConsumerSecret("B4Xe2RvXImgmUKKzH0e4FnpT9ZjzXY5lbDTAouwZKbJoW8aeID")
               .setOAuthAccessToken("791271802987278336-DLhD2cuKCIrx9iCgEIJNOwa9UMIqmfu")
               .setOAuthAccessTokenSecret("rnkWe2CDYwdrefPNTIZBZBDMlMM8qTEjvCNflxVrXUrKW");
       
       
       TwitterFactory tf = new TwitterFactory(cf.build());
       twitter4j.Twitter twitter = tf.getInstance();
       
       //get username, status
//       List<Status> status = twitter.getHomeTimeline();
//       for(Status st : status)
//       {
//           System.out.println(st.getCreatedAt()+"------"+st.getUser().getName()+"------"+st.getText());
//       }
       
       //local trends
        Trends trends = twitter.getPlaceTrends(44544);
        //for(int i=0; i<10; i++)
        {
            System.out.println(trends.getClass().getName() + "/n");
        }

//       //get username, status
//       List<SavedSearch> savedsearch = (List<SavedSearch>) twitter.savedSearches();
//       //List<Status> status = twitter.savedSearches();
//       for(Status st : status)
//       {
//           System.out.println(st.getCreatedAt()+"------"+st.getUser().getName()+"------"+st.getText());
//       }
    }
    
}
