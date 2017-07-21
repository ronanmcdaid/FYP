<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Dashboard.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Twitter Analysis Dashboard</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
     <meta http-equiv="refresh" content="300" />

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="Assets/favicon.png"/>

    <!-- Auto Refresh -->
    <meta http-equiv="refresh" content="300;url=Default.aspx" />

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="Css/Custom.css" />

    <!-- Custom Fonts - Font Awesome -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Scripts -->
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript">
        // Global variable to hold data
        // Load the Visualization API and the Piechart Package.
        google.load('visualization', '1', { packages: ['corechart'] });
    </script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".loader").fadeOut("slow");
        })

        jQuery(function ($) {
            var windowWidth = $(window).width();

            $(window).resize(function () {
                if (windowWidth != $(window).width()) {
                    location.reload();
                    return;
                }
            });
        });
    </script>
</head>
<body>
    <div class="loader">Loading Dashboard...</div>
    <form id="frmCustomerContactsDashboard" runat="server">
        <div id="dashboard" _dashboard-border="">
            <div class="container" _dashboard-border="">
                <%--Start of row1--%> 
                <div class="row" _dashboard-border="">  
                  
                     <div class="col-md-4 col-lg-4 col-xs-4 col-sm-4" >
                        <div class="panel panel-default">
                           <div class="panel-heading panel-heading-custom">
                           </div>
                           <div class="panel-body">
                                <asp:Label ID="lbTextBox" runat="server" Text="Search Field" ForeColor="#ffffff"></asp:Label>
                                <asp:TextBox ID ="txtSearch" runat="server"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="search" onclick="btnSearch_Click" />        
                           </div>

                            
                       <div class="panel-footer-custom"> 
                                                             <hr/>
                           <div>
                           <a style="text-align:center; " href="file:///C:\q\SentimentAnalysisKdb\ws.htm" >Sentiment Analysis</a>
                           </div>
                      </div>
                      </div>
                    </div>

                    <div class="col-md-8 col-lg-8 col-xs-8 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-custom">
                                <i class="fa fa-twitter fa-3x"></i>                                
                                <h3>Time Series</h3>
                            </div>
                                                        
                             <div class="panel-body panel-body-custom">
                                 <div id="lineTimeSeries">
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>  
                <%--End of row 1--%> 
                
                <%--Start of row 2--%>
                <div class="row" _dashboard-border="">  
                    <div class="col-md-4 col-lg-4 col-xs-4 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-custom">
                                <i class="fa fa-twitter fa-3x"></i>                                
                                <h3>Most Retweets By Account</h3>
                            </div>
                            <div id ="barMostRetweets">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 col-lg-8 col-xs-8 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-custom">
                                <i class="fa fa-twitter fa-3x"></i>                                
                              <h3>Most Retweeted Tweets</h3>
                               
                            </div>
                            <div style="width:100%; height:220px; overflow:scroll;">                            
                            <asp:GridView ID="gvMostRetweets" runat="server" CssClass="table table-hover table-striped" GridLines ="None" AutoGenerateColumns="false">
                             <columns>
                                 <asp:BoundField DataField="user_name" HeaderText="Username" />
                                 <asp:BoundField DataField="retweet_count" HeaderText="Retweets" />
                                 <asp:BoundField DataField="tweet_text" HeaderText="Tweet" />
                             </columns>
                                <RowStyle CssClass="cursor-pointer" />
                            </asp:GridView>
                            </div>
                        </div>
                    </div>                
                
                </div>  
                <%--End of row 2 --%> 
                
                <%--Start of row 3--%>
                <div class="row" _dashboard-border="">   
                     <div class="col-md-4 col-lg-4 col-xs-4 col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-custom">
                                <i class="fa fa-twitter fa-3x"></i>                                
                                <h3>Most Followed Tweets By Account</h3>
                            </div>
                            <div id ="barTopTweets">
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8 col-lg-8 col-xs-8 col-sm-8">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-custom">
                                <i class="fa fa-twitter fa-3x"></i>                                
                                <h3>Most Followed Tweets</h3>
                            </div>
                            <div style="width:100%; height:220px; overflow:scroll;">                            
                                <asp:GridView ID="gvTopTweets" runat="server" CssClass="table table-hover table-striped" GridLines ="None" AutoGenerateColumns="false">
                                <columns>
                                    <asp:BoundField DataField="user_name" HeaderText="Username" />
                                    <asp:BoundField DataField="tweet_followers_count" HeaderText="Tweet Followers" />
                                    <asp:BoundField DataField="tweet_text" HeaderText="Tweet" />
                                </columns>
                                <RowStyle CssClass="cursor-pointer" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>  
                <%--End of row 3--%> 
             </div>  <%--End of container--%> 
        </div>
        </div>
    </div>
         
    </form>
</body>


  
<script type="text/javascript">
    //Top Tweets


  
    //Get top 10 tweets
    $(function () {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Default.aspx/GetTopTweets',
            data: '{}',
            success: function (response) {
               drawchartTopTweets(response.d); // calling method
                
            },

            error: function () {
                alert("Error Loading - Top Tweets");
            }
        });
    })
  
    function drawchartTopTweets(dataValues) {
        // Callback that creates and populates a data table,
        // instantiates the bar chart, passes in the data and
        // draws it.
        var data = new google.visualization.DataTable();

        data.addColumn('string', 'user_name');
        data.addColumn('number', 'tweet_followers_count');

        for (var i = 0; i < dataValues.length; i++) {
            data.addRow([dataValues[i].user_name, dataValues[i].tweet_followers_count]);
        }

        // Instantiate and draw our chart, passing in some options
        var chart = new google.visualization.BarChart(document.getElementById('barTopTweets'));
        chart.draw(data,
          {
              //title: "Top Tweets",
              position: "top",
              fontsize: "18px",
              chartArea: { left: '10%', top: '5%', bottom: '10%', width: "80%" },
              backgroundColor: '#02234b',
              legend: { position: 'none' },
              titleTextStyle: { color: '#ffffff' },
              annotations: { highContrast: true },

              hAxis: { format: '0', title: 'Followers', maxValue: 4, baseline: 0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: 'transparent' }, textPosition: 'in' }, //using Format - keeps the Intervals as whole numbers 
              vAxis: { format: '0', title: 'User', maxValue: 4, baseline: 0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: '#transparent' }, textPosition: 'in' } //using Format - keeps the Intervals as whole numbers                  

          });

    }
   

    //Get Most Reweets
    $(function () {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Default.aspx/GetMostRetweets',
            data: '{}',
            success: function (response) {
                drawchartMostReweets(response.d); // calling method
            },

            error: function () {
                alert("Error Loading - Most Reweets");
            }
        });
    })


    function drawchartMostReweets(dataValues) {
        // Callback that creates and populates a data table,
        // instantiates the bar chart, passes in the data and
        // draws it.
        var data = new google.visualization.DataTable();

        data.addColumn('string', 'user_name');
        data.addColumn('number', 'retweet_count');

        for (var i = 0; i < dataValues.length; i++) {
            data.addRow([dataValues[i].user_name, dataValues[i].retweet_count]);
        }

        // Instantiate and draw our chart, passing in some options
        var chart = new google.visualization.BarChart(document.getElementById('barMostRetweets'));
        chart.draw(data,
          {
              //title: "MostReweets",
              position: "top",
              fontsize: "18px",
              chartArea: { left: '10%', top: '5%', bottom: '10%', width: "80%" },
              backgroundColor: '#02234b',
              legend: { position: 'none' },
              titleTextStyle: { color: '#ffffff' },
              annotations: { highContrast: true },

              hAxis: { format: '0', title: 'Retweets', maxValue: 4, baseline: 0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: 'transparent' }, textPosition: 'in' }, //using Format - keeps the Intervals as whole numbers 
              vAxis: { format: '0', title: 'User', maxValue: 4, baseline: 0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: 'transparent' }, textPosition: 'in' } //using Format - keeps the Intervals as whole numbers                  

          });

    }
    //Get Time Series
    $(function () {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Default.aspx/GetTimeSeries',
            data: '{}',
            success: function (response) {
                drawchartTimeSeries(response.d); // calling method
            },

            error: function () {
                alert("Error Loading - Time Series");
            }
        });
    })

    function drawchartTimeSeries(dataValues) {
        // Callback that creates and populates a data table,
        // instantiates the bar chart, passes in the data and
        // draws it.
        console.table(dataValues);
        var data = new google.visualization.DataTable();

        data.addColumn('string', 'bucket_time');
        data.addColumn('number', 'tweets_this_hour');

        for (var i = 0; i < dataValues.length; i++) {
            data.addRow([dataValues[i].bucket_time, dataValues[i].tweets_this_hour]);
            // data.addRow([new Date(parseInt(dataValues[i].bucket_time.replace(/[^0-9]/g,))), dataValues[i].tweets_this_hour]);
        }

        // Instantiate and draw our chart, passing in some options
        var chart = new google.visualization.LineChart(document.getElementById('lineTimeSeries'));
        chart.draw(data,
          {
              //title: "TimeSeries",
              position: "top",
              fontsize: "18px",
              chartArea: { left: '10%', top: '5%', bottom: '10%', width: "80%" },
              backgroundColor: '#02234b',
              legend: { position: 'none' },
              titleTextStyle: { color: '#ffffff' },
              annotations: { highContrast: true },

              hAxis: { format: '0', title: 'Time', maxValue: 4, baseline: 0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: 'transparent' }, textPosition: 'out' }, //using Format - keeps the Intervals as whole numbers 
              vAxis: { format: '0', title: 'Hourly Tweet Volume', maxValue: 4, baseline:0, baselineColor: '#ffffff', textStyle: { color: '#ffffff' }, titleTextStyle: { color: '#ffffff' }, gridlines: { color: '#ffffff' }, textPosition: 'in' } //using Format - keeps the Intervals as whole numbers                  

          });

    }
    
    

   
</script>


</html>
