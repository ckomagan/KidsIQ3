//
//  QuitController.h
//  KidsIQ3
//
//  Created by Chan Komagan on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuitController : UIViewController {
    IBOutlet UIButton *dismissYes;
    IBOutlet UIButton *dismissNo;
}

-(IBAction)dismissView;
-(IBAction)loginScreen;

@end
