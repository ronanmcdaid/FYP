/ Define a logging function
out:{show string[.z.p]," - ",x};

out"Loading analysis.q";
system"l analysis.q";

/ Read in file path as the first command line argument
fileToProcess:hsym `$ .z.x 0;
out"Processing file - ",string[fileToProcess];

/ Cook book implementation from code.kx.com
/ Read in the file to process, it's tab delimited, with 2 columns, first being the tweet id, type long, second being the tweet text, type var char.
data:("J*";enlist "\t")0: fileToProcess;

/ Create a table called outputFile by processing the tweet_text through the processTweets function 
outputFile:select tweet_ID,sentiment:processTweets each tweet_text from data;

/ Log how many records have been processed
out"Processed file containing ",string[count outputFile]," records";
out"Saving results to output file - outputFile.txt";
save `:outputFile.txt;

out"Complete - Exiting";
exit 0