//
//  LoginViewController.h
//  imageTagging
//
//  Created by Evan Lee on 8/28/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMClient;

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) SMClient *client;

- (IBAction)createUser:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *logout;


@end
