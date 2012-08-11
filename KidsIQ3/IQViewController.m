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
NSInteger _id = 3;
NSInteger _score = 0;
NSInteger _noOfQuestions = 0;
NSInteger maxQuestions;
NSDictionary *res;
NSString *titleText;
NSString *scoreText;

@synthesize name;

@interface UIButton (ColoredBackground)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIColor *) silverColor;

@end

-(void)showLoginViewController {
    
    NameViewController *loginView = [[NameViewController alloc] initWithNibName:@"NameViewController" bundle:nil];
    // loginView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // [self presentModalViewController:loginView animated:true]; 
    NSLog(@"Name = ");
    NSLog(name);
    nameLabel.text = name;
}

-(IBAction)showModalViewController {
    /*
    NSLog(_selectedChoice);
    
    ResultController *tempView = [[ResultController alloc] initWithNibName:@"ResultController" bundle:nil];
    
    if ([_selectedChoice isEqualToString:_correctChoice]) {
        tempView.answer = @"Correct Answer kiddo!";
        _score++;
    }
    else {
        tempView.answer = [@"Oops. That was incorrect. The correct answer is " stringByAppendingString:_correctChoice];
    }
    _noOfQuestions++;
    tempView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:tempView animated:true];
    _id++;
    
    [self resetAllChoices];
    
    if(_id > 5) _id = 1;
        
        NSLog([NSString stringWithFormat:@"%d", _id]);        
        [self viewDidLoad];
     */
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
    [self showLoginViewController];
    [self calculatescore];
    
    submit.enabled = FALSE;
    [submit setTitle: @"Select" forState: UIControlStateNormal];
    _nsURL = [@"http://www.komagan.com/KidsIQ/index.php?format=json&quiz=1&question_id=" stringByAppendingFormat:@"%d ", _id];
    
    NSLog(_nsURL);
    
    NSError *error = nil;
    self.responseData = [NSMutableData data];
    
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: _nsURL]];
    NSLog(@"request established");
    
    //NSData *aResponse = [NSURLConnection sendSynchronousRequest:aRequest returningResponse:nil error:nil];
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
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
    
    for(NSDictionary *res1 in res) {
        
        question.text = [res1 objectForKey:@"question"];
    }
    
    for(NSDictionary *res1 in res) {
        
        NSString *answer = [res1 objectForKey:@"choice_text"];
        [answers addObject :answer];
        
        NSString *rightChoice = [res1 objectForKey:@"is_right_choice"];
        
        if ([rightChoice isEqualToString:@"1"]) {
            _correctChoice = answer;
        }
        NSLog(@"retrieving specific values", answer);
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
            NSLog([NSString stringWithFormat:@"%d", _id]);        
            [self viewDidLoad];
        }
}

- (IBAction)skipQuestion
{
    _id++;
    _noOfQuestions++;
    [self resetAllChoices];
    
    if(_id > 5) _id = 1;
        
    NSLog([NSString stringWithFormat:@"%d", _id]);        

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
        if((tally >= 0.6) && (tally <= 0.9))
        {
            titleText = @"You are practically a genius \ue415";
        }
        if((tally >= 0.35) && (tally <= 0.6))
        {
            titleText = @"I think you can do better?!?";
        }
        if(tally <= 0.3)
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
    resultView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:resultView animated:true];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self performSegueWithIdentifier: @"NameViewController" sender:self]; 
    //[self showLoginViewController];
    
}

- (void)viewDidAppear:(BOOL)animated
{
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
       
    if ([[segue identifier] isEqualToString:@"ResultController"]) {
        IQViewController *loginView = segue.destinationViewController;
    }
    }
        
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

