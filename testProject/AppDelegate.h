//
//  AppDelegate.h
//  testProject
//
//  Created by Evan Lee on 9/24/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SMClient;
@class SMCoreDataStore;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) SMClient *client;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;

- (void)saveContext;


@end
