//
//  Post.h
//  imageTagging
//
//  Created by Evan Lee on 9/1/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@class User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * post_id;
@property (nonatomic, retain) NSString * photocontent;
@property (nonatomic, retain) NSString * videocontent;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
@property (nonatomic, retain) id geopoint;
@property (nonatomic, retain) NSNumber * publicViewable;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *canView;
@property (nonatomic, retain) User *creator;
@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addCanViewObject:(User *)value;
- (void)removeCanViewObject:(User *)value;
- (void)addCanView:(NSSet *)values;
- (void)removeCanView:(NSSet *)values;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
