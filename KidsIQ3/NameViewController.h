//
//  NameViewController.h
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
 {
    IBOutlet UITextField *nameText;
    IBOutlet UILabel *errorStatus;
    IBOutlet UIButton *nameOK;
    IBOutlet UIPickerView *levelPickerView;
}

@property (nonatomic, retain) NSArray *levelpicker;

@property (nonatomic, retain) UIPickerView *levelPickerView;

-(IBAction)validateTextFields:(id)sender;
-(IBAction)dismissView;
-(IBAction)selectedRow;
-(IBAction)textFieldReturn:(id)sender;

@end