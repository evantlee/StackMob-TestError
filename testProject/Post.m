//
//  Post.m
//  imageTagging
//
//  Created by Evan Lee on 9/1/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import "Post.h"
#import "User.h"


@implementation Post

@dynamic post_id;
@dynamic photocontent;
@dynamic videocontent;
@dynamic createddate;
@dynamic lastmoddate;
@dynamic geopoint;
@dynamic publicViewable;
@dynamic rating;
@dynamic canView;
@dynamic creator;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    [self setValue:[self assignObjectId] forKey:[self primaryKeyField]];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}

@end
