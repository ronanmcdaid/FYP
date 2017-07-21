/ Read in file, cast to datatype symbol for fast comparison and lower case it
getFile:{lower `$'read0 x};
/ Read in 4 files 
positiveWords:getFile `:positiveWords.txt;
negativeWords:getFile`:negativeWords.txt;
switchers:getFile`:switchers.txt;
intensifiers:getFile`:intensifierWords.txt;


/ Clean the msgs so we only have lower case letters and spaces - no puncutation
/ todo - handle words with ' in them i.e. don't - currently they will be ignored
cleanAndSplitTweet:{
	/ Ensure tweet is lower case
	x:lower x;
	/ Work out which chars aren't lower case letters or spaces
	nonLettersOrSpaces:where not x in .Q.a," ";
	/ replace them with spaces
	x:@[x;nonLettersOrSpaces;:;" "];
	/ split the tweet into individual words
	`$'" " vs x
	};

/ This is the main function which cleans the tweet, checks for +ve / -ve words, then splits the tweet into sub sentences
/ and analyses each for sentiment
processTweets:{[x]	
	/ Clean up the message for puncutation / get to lower case
	x:cleanAndSplitTweet[x];
	positive:x in positiveWords;
	negative:x in negativeWords;
	/ If there are no identified words in the tweet, return analysis value of 0
	/ this acts as a fast exit 
	if[0=sum raze (positive;negative);:0];
	
	/ slit tweet into substructures and evaluate - this handles sub sentences within each sentence
	substructureIndices:1 + where any(positive;negative);
	/ Add on 0 index so we always start at the start of the list
	substructureIndices:0,substructureIndices;
	split_tweet:substructureIndices cut x;
	
	/Calculate and return sentiment
	sum analyseSubstructure each split_tweet
	};

/ Each tweet may contain many sentences / sub structures, this is called for them one at a time to analyse each sub structure
analyseSubstructure:{[x]
	signal:$[any x in positiveWords;1;any x in negativeWords;-1;0];
	/ if signal is 0 - we've picked up a trailing neutral word - return 0
	if[signal=0;:0];
	/ If we have a switching word, swap the negative to positive
	switcher:any x in switchers;
	if[switcher;
		signal:signal * -1];
	/ count how many intensifier words we have, use this as a multiple of the sentiment
	/ we always have a base of 1 intensity
	intensity:1 + sum x in intensifiers;
	signal * intensity
	};

/ Load the test code to test this script before use
system"l testAnalysis.q";


/ Add some web handling code
/ Have a wrapper which calls processTweets, and then returns the original tweet and the calculted sentiment
webWrapper:{[x]
	stringToEvaluate:"processTweets ",x;
	sentiment:value stringToEvaluate;
	`tweet`sentiment!(`$x;sentiment)
	};

/ Set the web handler to call the webWrapper
.z.ws:{neg[.z.w].Q.s webWrapper x}
