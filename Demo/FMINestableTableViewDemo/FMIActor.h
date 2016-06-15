//
//  FMIActor.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIActor : NSObject

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *name;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END