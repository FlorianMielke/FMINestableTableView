//
//  FMIMovie.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMIActor;

NS_ASSUME_NONNULL_BEGIN

@interface FMIMovie : NSObject

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *title;
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMIActor *> *cast;
@property (readonly, NS_NONATOMIC_IOSONLY) NSUInteger numberOfCast;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTitle:(NSString *)title;

- (void)addActor:(FMIActor *)actor;

- (void)removeActorAtIndex:(NSUInteger)index;

- (nullable FMIActor *)actorAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END