//
//  LoginViewController.m
//  imageTagging
//
//  Created by Evan Lee on 8/28/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"
#import "Post.h"
#import "SMLocationManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation LoginViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize client = _client;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    self.statusLabel.text = @"";
    self.client = [SMClient defaultClient];
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    //self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    //[self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)createUser:(id)sender {
    //check if name is alphanumeric
    BOOL valid = [[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]] isEqualToString:@""];
    if (valid){
        
        //check if password is too short (<5 characters)
        if (self.passwordField.text.length >= 5){
            User *newUser = [[User alloc] initIntoManagedObjectContext:[[[SMClient defaultClient] coreDataStore] contextForCurrentThread]];
            
            [newUser setValue:self.usernameField.text forKey:[newUser primaryKeyField]];
            [newUser setPassword:self.passwordField.text];
            NSDate *created = [[NSDate alloc] initWithTimeIntervalSince1970: NSTimeIntervalSince1970];
            [newUser setCreateddate:created];
            [newUser setLastmoddate:created];
            NSLog(@"%@",newUser);
            [newUser addConnection:[[NSSet alloc] initWithObjects:newUser, nil]];
            [[[[SMClient defaultClient] coreDataStore] contextForCurrentThread] saveOnSuccess:^{
                NSLog(@"You created a new user object!");
                [self login:self];
            } onFailure:^(NSError *error) {
                [[[[SMClient defaultClient] coreDataStore] contextForCurrentThread] deleteObject:newUser];
                [newUser removePassword];
                NSLog(@"There was an error! %@", error);
                [self errorCode:2];
            }];
        }
        else {
            [self errorCode:1];
        }
    }
    else{
        [self errorCode:0];
    }
}



-(void) errorCode:(NSUInteger)code{
    switch(code){
        case 0:
            NSLog(@"invalid username");
            self.statusLabel.text = @"That username is invalid!";
            break;
        case 1:
            NSLog(@"password too short");
            self.statusLabel.text = @"Your password is too short!";
            break;
        case 2:
            NSLog(@"username taken");
            self.statusLabel.text = @"Someone has that username!";
            break;
    }
}

- (IBAction)login:(id)sender {
    NSLog(@"\nUsername: %@ \nPassword: %@",self.usernameField.text,self.passwordField.text);
    [self.client loginWithUsername:self.usernameField.text password:self.passwordField.text onSuccess:^(NSDictionary *results) {
        NSLog(@"Login Success %@",results);
        //self.statusLabel.text = [NSString stringWithFormat:@"Hello, %@", [results objectForKey:@"username"]];
        
         NSFetchRequest *userFetch = [[NSFetchRequest alloc] initWithEntityName:@"User"];
         [userFetch setPredicate:[NSPredicate predicateWithFormat:@"username == %@", [results objectForKey:@"username"]]];
         NSLog(@"%@",userFetch.predicate);
         [self.managedObjectContext executeFetchRequest:userFetch onSuccess:^(NSArray *results) {
             NSLog(@"fetching");
             NSManagedObject *userObject = [results lastObject];
             NSLog(@"%@",userObject);
             self.statusLabel.text = [NSString stringWithFormat:@"Welcome %@!",[userObject valueForKey:[userObject primaryKeyField]]];
             // Store userObject somewhere for later use
             NSLog(@"Fetched user object: %@", userObject);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
             //save context
             [[[[SMClient defaultClient] coreDataStore] contextForCurrentThread] saveOnSuccess:^{
                 [[[[SMClient defaultClient] coreDataStore] contextForCurrentThread] refreshObject:userObject mergeChanges:YES];
                 NSLog(@"Saved user");
                 
             } onFailure:^(NSError *error) {
                 NSLog(@"There was an error! %@", error);
             }];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             //start tracking location on login
             [[[SMLocationManager sharedInstance] locationManager] startUpdatingLocation];
                 
                 
             //if successful, push to create post view with userObject as input
             //[self performSegueWithIdentifier:@"loggedInUser:" sender:userObject];
             self.statusLabel.text = [NSString stringWithFormat:@"Welcome %@",[userObject valueForKey:[userObject primaryKeyField]]];
             
         } onFailure:^(NSError *error) {
             NSLog(@"Error fetching user object: %@", error);
             self.statusLabel.text = @"Sorry! Just hit login again...";
         }];
        
        
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"Login Fail: %@",error);
        self.statusLabel.text = @"Username or password is incorrect";
        
    }];
}

- (IBAction)logout:(id)sender {
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        self.statusLabel.text = @"You are now logged out";
        NSLog(@"Success, you are logged out");
        //stop tracking location on logout
        [[[SMLocationManager sharedInstance] locationManager] stopUpdatingLocation];
        self.usernameField.text = nil;
        self.passwordField.text = nil;
    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];
}

@end
