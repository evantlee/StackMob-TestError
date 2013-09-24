//
//  User.h
//  imageTagging
//
//  Created by Evan Lee on 9/17/13.
//  Copyright (c) 2013 devStudio.evan.lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@class Post, User;

@interface User : SMUserManagedObject

@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *connection;
@property (nonatomic, retain) NSSet *post;
@property (nonatomic, retain) NSSet *viewable;
@property (nonatomic, retain) NSSet *sentrequest;
@property (nonatomic, retain) NSSet *receivedrequest;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addConnectionObject:(User *)value;
- (void)removeConnectionObject:(User *)value;
- (void)addConnection:(NSSet *)values;
- (void)removeConnection:(NSSet *)values;

- (void)addPostObject:(Post *)value;
- (void)removePostObject:(Post *)value;
- (void)addPost:(NSSet *)values;
- (void)removePost:(NSSet *)values;

- (void)addViewableObject:(Post *)value;
- (void)removeViewableObject:(Post *)value;
- (void)addViewable:(NSSet *)values;
- (void)removeViewable:(NSSet *)values;

- (void)addSentrequestObject:(User *)value;
- (void)removeSentrequestObject:(User *)value;
- (void)addSentrequest:(NSSet *)values;
- (void)removeSentrequest:(NSSet *)values;

- (void)addReceivedrequestObject:(User *)value;
- (void)removeReceivedrequestObject:(User *)value;
- (void)addReceivedrequest:(NSSet *)values;
- (void)removeReceivedrequest:(NSSet *)values;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context ;

@end
