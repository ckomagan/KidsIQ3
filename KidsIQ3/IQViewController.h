//
//  IQViewController.h
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IQViewController : UIViewController 
{
    IBOutlet UILabel *question;
    IBOutlet UILabel *answerA;
    IBOutlet UILabel *answerB;
    IBOutlet UILabel *answerC;
    IBOutlet UILabel *answerD;
    IBOutlet UIButton *choicea;
    IBOutlet UIButton *choiceb;
    IBOutlet UIButton *choicec;
    IBOutlet UIButton *choiced;
    IBOutlet UIButton *submit;
    IBOutlet UILabel *score;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *result;
    IBOutlet UIButton *test;
    NSMutableData *responseData;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSMutableSet *usedNumbers;
@property int maxQuestions;

-(IBAction)showModalViewController;

-(IBAction)showLoginViewController;

-(IBAction)submit:(id)sender;

-(void)resetAllChoices;

-(void)resetAll;

- (void)disableAllChoices;

-(IBAction)checkAnswer;

-(IBAction)skipQuestion;

-(void)calculatescore;

-(void)showResults;

-(int)generateRandomNumber;

-(IBAction)dismissView;

@end
