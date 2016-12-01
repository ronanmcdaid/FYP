/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package streamtests;

/**
 *
 * @author Ronan
 */
import java.util.Scanner;
import twitter4j.FilterQuery;
import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.User;
import twitter4j.conf.ConfigurationBuilder;

public class Streamtests {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       // TODO code application logic here
       ConfigurationBuilder cb = new ConfigurationBuilder();
       cb.setDebugEnabled(true);
       cb.setOAuthConsumerKey("njPT8OB12bxkbDQJ0d4VOAZ2d");
       cb.setOAuthConsumerSecret("B4Xe2RvXImgmUKKzH0e4FnpT9ZjzXY5lbDTAouwZKbJoW8aeID");
       cb.setOAuthAccessToken("791271802987278336-DLhD2cuKCIrx9iCgEIJNOwa9UMIqmfu");
       cb.setOAuthAccessTokenSecret("rnkWe2CDYwdrefPNTIZBZBDMlMM8qTEjvCNflxVrXUrKW");
       
       TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
       
       StatusListener listener = new StatusListener(){
           @Override
           public void onException(Exception arg0){
               //TODO Auto-generated method stub
           }
           @Override
           public void onDeletionNotice(StatusDeletionNotice arg0){
               //TODO Auto-generated method stub
           }
            @Override
            public void onScrubGeo(long arg0, long arg1){
                //TODO Auto-generated method stub
            }
           @Override
           public void onStatus(Status status){
               User user = status.getUser();
               
               //gets username
               String username = status.getUser().getScreenName();
               System.out.println(username);
               String profileLocation = user.getLocation();
               System.out.println(profileLocation);
               long tweetId = status.getId();
               System.out.println(tweetId);
               String content = status.getText();
               System.out.println(content +"/n");
           }
           
           @Override
           public void onTrackLimitationNotice(int arg0){
               //TODO Auto-generated method stub
           }

           @Override
           public void onStallWarning(StallWarning sw) {
               throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
           }
       };
       
       FilterQuery fq = new FilterQuery();
       
       Scanner scanner = new Scanner (System.in);
       System.out.print("Enter Search term: ");
       String kword = scanner.next();
       
       String keywords[] = {kword};
       
       fq.track(keywords);
       
       twitterStream.addListener(listener);
       twitterStream.filter(fq);
           }
}
