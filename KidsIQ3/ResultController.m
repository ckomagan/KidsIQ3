//
//  ResultController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultController.h"
#import "IQViewController.h"
#import "NameViewController.h"

@interface ResultController()
@end

@implementation ResultController

//@synthesize answer = _answer;
@synthesize name;
@synthesize title;
@synthesize score;
bool reset = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //responseText.text = _answer;
    nameLabel.text = name;
    titleLabel.text = title;
    scoreLabel.text = [@"Your score is: " stringByAppendingString:score];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)dismissView {
    
    //IQViewController *resultView = [[IQViewController alloc] initWithNibName:@"ResultController" bundle:nil];
    //[self dismissModalViewControllerAnimated:YES];
    NameViewController *nameView = [[NameViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    nameView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:nameView animated:false];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
