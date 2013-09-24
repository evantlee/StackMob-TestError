//
//  User.m
//  imageTagging
//
//  Created by Evan Lee on 9/17/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import "User.h"
#import "Post.h"


@implementation User

@dynamic createddate;
@dynamic lastmoddate;
@dynamic username;
@dynamic connection;
@dynamic post;
@dynamic viewable;
@dynamic sentrequest;
@dynamic receivedrequest;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}
@end
