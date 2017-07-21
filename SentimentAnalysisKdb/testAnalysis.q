/ Test code
/ This will be run every time the script is loaded to make sure no bugs have been introduced.

/ Out will be used as a logging function;
out:{show string[.z.p]," - ",x};

/ Define a list of sample tweets
tweets:(
        "I love this";
        "this is a problem";
        "this is not a problem! no problem at all";
        "no problem";
        "I really like this";
        "I really hate this";
        "I really really hate this";
        "hate - it's not a good thing, is it?"
        );


expectedResult:1 -1 2 1 2 -2 -3 -2;

testPass:expectedResult ~ processTweets each tweets;
$[testPass;
        out"Tested passed successfully";
        out"ERROR - TESTS FAILED - PLEASE CHECK BEFORE RUNNING ANALYSIS"
        ];
