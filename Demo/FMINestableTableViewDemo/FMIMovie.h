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
@property (readonly, NS_NONATOMIC_IOSONLY) NSNumber *releaseYear;
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMIActor *> *cast;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTitle:(NSString *)title releaseYear:(NSNumber *)releaseYear cast:(NSArray<FMIActor *> *)cast;

@end

NS_ASSUME_NONNULL_END