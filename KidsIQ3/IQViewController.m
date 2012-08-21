//
//  IQViewController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IQViewController.h"
#import "ResultController.h"
#import "NameViewController.h"
#import "QuitController.h"

@interface IQViewController()
@property (nonatomic, strong) NSString *nsURL;
@property (nonatomic, strong) NSString *selectedChoice;
@property (nonatomic, strong) NSString *correctChoice;
@end

@implementation IQViewController

@synthesize nsURL = _nsURL;
@synthesize responseData;
@synthesize selectedChoice = _selectedChoice;
@synthesize correctChoice = _correctChoice;
@synthesize usedNumbers;
NSInteger _id = 0;
NSInteger _score = 0;
NSInteger _noOfQuestions = 0;
int count;
NSDictionary *res;
NSString *titleText;
NSString *scoreText;
bool reset;

@synthesize name;
@synthesize maxQuestions;
@interface UIButton (ColoredBackground)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIColor *) silverColor;

@end

-(void)showLoginViewController {
    
    //NameViewController *loginView = [[NameViewController alloc] initWithNibName:@"NameViewController" bundle:nil];
    //NSLog(@"Name = ", name);
    nameLabel.text = name;
}

-(IBAction)showModalViewController {
    QuitController *tempView = [[QuitController alloc] initWithNibName:@"QuitController" bundle:nil];
    [self presentModalViewController:tempView animated:true];
}

- (IBAction)submit:(id)sender {
    
}

- (void)showbutton {
    submit.enabled = TRUE;
    [submit setTitle: @"Submit" forState: UIControlStateNormal];
    [submit setBackgroundColor:[UIColor blueColor]];
}

- (IBAction)choicea:(id)sender {
    
    [self resetAllChoices];
    choicea = (UIButton *)sender;
    [answerA setTextColor:[UIColor redColor]];
    [choicea setBackgroundColor:[UIColor redColor]];
    _selectedChoice = answerA.text;
    [self showbutton];
    
}

- (IBAction)choiceb:(id)sender {
    
    [self resetAllChoices];    
    choiceb = (UIButton *)sender;
    [answerB setTextColor:[UIColor redColor]];
    [choiceb setBackgroundColor:[UIColor redColor]];
    _selectedChoice = answerB.text;
    [self showbutton];
    
}

- (IBAction)choicec:(id)sender {
    
    [self resetAllChoices];
    choicec = (UIButton *)sender;
    [answerC setTextColor:[UIColor redColor]];
    [choicec setBackgroundColor:[UIColor redColor]];
    _selectedChoice = answerC.text;
    [self showbutton];
}

- (IBAction)choiced:(id)sender {
    
    [self resetAllChoices]; 
    choiced = (UIButton *)sender;
    [answerD setTextColor:[UIColor redColor]];
    [choiced setBackgroundColor:[UIColor redColor]];
    _selectedChoice = answerD.text;
    [self showbutton];
}

- (void)didReceiveMemoryWarning
{   
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self showLoginViewController];
  	if(_id <= maxQuestions)
	{
		submit.enabled = FALSE;
		[submit setTitle: @"Select" forState: UIControlStateNormal];
		//_id = [self generateRandomNumber];
		//NSLog(@"No of questions: %@", self.maxQuestions);

		_nsURL = [@"http://www.komagan.com/KidsIQ/index.php?format=json&quiz=1&question_id=" stringByAppendingFormat:@"%d ", _id];
    
		NSLog(_nsURL);
    
		NSError *error = nil;
		self.responseData = [NSMutableData data];
		
		NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: _nsURL]];
		NSLog(@"request established");
		NSLog(@"didReceiveResponse");
		[[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
	
	}
	else{
		[self showResults];
        return;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {        
    [self.responseData appendData:data]; 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    NSMutableArray *answers = [[NSMutableArray alloc] init];
   
    //for(NSDictionary *res1 in res) {
        
        
    //}
    
    for(NSDictionary *res1 in res) {
        question.text = [res1 objectForKey:@"question"];
        NSString *answer = [res1 objectForKey:@"choice_text"];
        [answers addObject :answer];
        
        NSString *rightChoice = [res1 objectForKey:@"is_right_choice"];
        
        if ([rightChoice isEqualToString:@"1"]) {
            _correctChoice = answer;
        }
        //NSLog(@"retrieving specific values", answer);
    }
    
    if ([res count] ==0)
    {
        [self showResults];
        return;
    }
    
    answerA.text = [answers objectAtIndex:0];
    answerB.text = [answers objectAtIndex:1];
    answerC.text = [answers objectAtIndex:2];
    answerD.text = [answers objectAtIndex:3];
    }

- (void)resetAllChoices 
{
    
    [answerA setTextColor:[UIColor blackColor]];
    [choicea setBackgroundColor:[UIColor blueColor]];
    [answerB setTextColor:[UIColor blackColor]];
    [choiceb setBackgroundColor:[UIColor blueColor]];
    [answerC setTextColor:[UIColor blackColor]];
    [choicec setBackgroundColor:[UIColor blueColor]];
    [answerD setTextColor:[UIColor blackColor]];
    [choiced setBackgroundColor:[UIColor blueColor]];
    choicea.enabled = YES;
    choiceb.enabled = YES;
    choiceb.enabled = YES;
    choiced.enabled = YES;
}

- (void)resetAll /* restart the quiz */
{
    //reset all the counters
    _id = 1;
    _score = 0;
    reset = YES;  //reset the first set of questions
    _noOfQuestions = 0;
    [self viewDidLoad];
}

- (void)disableAllChoices 
{
    
    choicea.enabled = NO;
    choiceb.enabled = NO;
    choiceb.enabled = NO;
    choiced.enabled = NO;
}

- (IBAction)checkAnswer
{
    
    if([submit.titleLabel.text isEqual:@"Submit"])
    {    
        if ([_selectedChoice isEqualToString:_correctChoice]) {
            result.text = @"Correct Answer!";
            [result setTextColor:[UIColor greenColor]];
            _score++;
        }
        else {
            result.text = @"Incorrect!";
            [result setTextColor:[UIColor redColor]];
        }
        _noOfQuestions++;
        _id++;
		[self calculatescore];
		
		
        [submit setTitle:@"Next" forState:(UIControlState)UIControlStateNormal];
        [self disableAllChoices];
        //NSDate *future = [NSDate dateWithTimeIntervalSinceNow: .50 ];
        //[NSThread sleepUntilDate:future];
        return;
    }
    
    if([submit.titleLabel.text isEqual:@"Next"]) 
        {    
            result.text = @"";
            [self resetAllChoices];
            //if(_id > 5) _id = 1;
            //NSLog([NSString stringWithFormat:@"%d", _id]);        
            [self viewDidLoad];
        }
}

- (IBAction)skipQuestion
{
    _id++;
    _noOfQuestions++;
    [self resetAllChoices];
    [self calculatescore];
    [self viewDidLoad];
}

- (void)calculatescore
{
    scoreText = [NSString stringWithFormat:@"%d",_score];
    scoreText = [scoreText stringByAppendingString:@ "/"];
    scoreText = [scoreText stringByAppendingString:[NSString stringWithFormat:@"%d",_noOfQuestions]];
    if (_noOfQuestions > 0)
    {
        int tally = _score / _noOfQuestions;
    
        if(tally >= 0.9)
        {
            titleText = @"You are practically a genius";
        }
        if((tally >= 0.7) && (tally <= 0.9))
        {
            titleText = @"That's not bad!";
        }
        if((tally >= 0.5) && (tally <= 0.7))
        {
            titleText = @"I think you can do better?!?";
        }
        if(tally <= 0.5)
        {
            titleText = @"You better start over \ue40e";
        }
        
    }
        [score setText: scoreText];
}

-(void)showResults
{
    
    ResultController *resultView = [[ResultController alloc] initWithNibName:@"ResultController" bundle:nil];
    resultView.name = [@"Hi there " stringByAppendingString:[name stringByAppendingString:@""]];
    resultView.title = titleText;
    resultView.score = scoreText;
	resultView.maxQuestions = maxQuestions;
	[self resetAll];
    resultView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:resultView animated:true];
}

-(int)generateRandomNumber
{
    if(count <= maxQuestions)
    {
    int randomNumber = (arc4random() % maxQuestions) + 1; 
    //NSLog([NSString stringWithFormat:@"%i", randomNumber]);
    
    bool myIndex = [usedNumbers containsObject:[NSNumber numberWithInt: randomNumber]];
    if (myIndex == false) 
    {        
        [usedNumbers addObject:[NSNumber numberWithInt:randomNumber]];
        NSLog(@"numberWithSet : %@ \n\n",usedNumbers);
		count++;
		return randomNumber;
    }
	else{
		[self generateRandomNumber];
		return 0; 
	}
		
	}
    //[_usedNumbers addObject:[NSNumber numberWithInt:randomNumber]];
    
    /*
    unsigned int myIndex = [_usedNumbers containsObject:[NSNumber numberWithInt: randomNumber]];
    if(myIndex != NSNotFound) {
        [_usedNumbers addObject:[NSNumber numberWithInt:randomNumber]];
        NSLog(@"Adding...", randomNumber);
        NSLog(@"size of array: %lu", [_usedNumbers count]);
        return randomNumber;
    }
    else{
        [self generateRandomNumber];
    }*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 }

- (void)viewDidAppear:(BOOL)animated
{
   // _usedNumbers = [NSMutableArray alloc];
	nameLabel.text = name;
    usedNumbers = [NSMutableSet setWithCapacity:maxQuestions];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([res count] ==0)
    {
       
    if ([[segue identifier] isEqualToString:@"ResultControllerScreen"]) { 
        IQViewController *loginView = segue.destinationViewController;
    }
    }
        
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

