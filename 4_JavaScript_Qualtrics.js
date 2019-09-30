/*  Randomization on Qualtrics Survey Platform using JavaScript */ 

/*  In this survey, which we implemented on the Qualtrics platform, we need to show each respondent 16 statements 
    (specific content of these statements is masked in this code snippet).
    These 16 statements are randomly split into two groups of equal size and then presented in two questions respectively. 
    Statements in each question are also presented in randomized order.
    
    Randomization takes place as each respondent clicks into the survey. In other words, results of random grouping and 
    random order of statements differ by respondent. The JavaScript codes below carry out these by-person randomizations.
*/


	Qualtrics.SurveyEngine.addOnReady(
	function(){
		/*Place your JavaScript here to run when the page is fully displayed*/
		/*Randomize the 16 statements into two groups*/
		var GoodQualities = ["statement 1",
		"statement 2",
		"statement 3",
		"statement 4",
		"statement 5",
		"statement 6",
		"statement 7",
		"statement 8",
		"statement 9",
		"statement 10",
		"statement 11",
		"statement 12",
		"statement 13",
		"statement 14",
		"statement 15",
		"statement 16"];
		
	    var b = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
		var a = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
	    var n;
	    var goodgroup1=[];
	    for (n=0; n<8; n++)
	    {
	      var i = Math.floor(Math.random() * (16-n));  /*generate a random number btw 0-15, 0-14, etc. */
	      goodgroup1.push(a[i]); /*Compile all randomly selected numbers into one vector*/
	      a[i] = a[15-n]; /*Replace the selected number with the number that's gonna be missed in the next iteration*/
	    }
	    
		/*Calculate diff btw two vectors*/
	    Array.prototype.diff = function (a) {
	    return this.filter(function (i) {
	        return a.indexOf(i) === -1;
	    }); 
	};
	    var goodgroup2= b.diff(goodgroup1);
		
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality1', GoodQualities[goodgroup1[0]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality2', GoodQualities[goodgroup1[1]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality3', GoodQualities[goodgroup1[2]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality4', GoodQualities[goodgroup1[3]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality5', GoodQualities[goodgroup1[4]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality6', GoodQualities[goodgroup1[5]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality7', GoodQualities[goodgroup1[6]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality8', GoodQualities[goodgroup1[7]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality9', GoodQualities[goodgroup2[0]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality10', GoodQualities[goodgroup2[1]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality11', GoodQualities[goodgroup2[2]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality12', GoodQualities[goodgroup2[3]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality13', GoodQualities[goodgroup2[4]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality14', GoodQualities[goodgroup2[5]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality15', GoodQualities[goodgroup2[6]]); 
		Qualtrics.SurveyEngine.setEmbeddedData('GoodQuality16', GoodQualities[goodgroup2[7]]); 
	});
	
