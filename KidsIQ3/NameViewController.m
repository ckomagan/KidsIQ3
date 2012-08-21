//
//  NameViewController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NameViewController.h"
#import "IQViewController.h"

@interface NameViewController()
@end

@implementation NameViewController
NSString *levelSelection;
int level;
@synthesize levelpicker;
@synthesize levelPickerView;
@synthesize maxQuestions;
int noOfQuestions = 0;

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

- (void)viewDidLoad
{
    [super viewDidLoad];    
    noOfQuestions = maxQuestions;
    levelpicker = [NSArray arrayWithObjects:@"60", @"40",@"20",nil];
    levelPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    levelPickerView.delegate = self;
    levelPickerView.showsSelectionIndicator = YES;
    [levelPickerView selectRow:1 inComponent:0 animated:YES];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.2, 1.4);
    [self.levelPickerView setTransform:rotate];
    [self.view addSubview:levelPickerView];
    self.levelPickerView.center = CGPointMake(160,230);  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [nameOK setEnabled:NO];

}

-(IBAction)validateTextFields:(id)sender
{
    // make sure all fields are have something in them
    if (nameText.text.length  > 0) {
        nameOK.enabled = YES;
    }
    else {
        nameOK.enabled = NO;
    }
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showQuiz"]) {
        IQViewController *quizView = segue.destinationViewController;
        if ([nameText.text isEqualToString:@""]) {
            errorStatus.text = @"Please enter the name.";
            return;
        }
        
        quizView.name = nameText.text;  
        
        quizView.maxQuestions = noOfQuestions;
        
        [quizView resetAll];
    }
    NSLog(@"%i", noOfQuestions);
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 3;
    noOfQuestions = 0;
    return numRows;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    levelSelection = [levelpicker objectAtIndex:row];
    NSLog(@"You selected: %@", levelSelection);
    noOfQuestions = [levelSelection intValue];
}

-(IBAction)selectedRow {

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [levelpicker objectAtIndex:row];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect rect = CGRectMake(0, 0, 200, 100);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.5);
    [label setTransform:rotate];
    label.text = [levelpicker objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:50.0];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 2;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.backgroundColor = [UIColor clearColor];
    label.clipsToBounds = YES;
    noOfQuestions = 40;
    return label ;
}

@end
