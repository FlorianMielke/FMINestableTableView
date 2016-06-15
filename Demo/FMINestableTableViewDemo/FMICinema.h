//
//  FMICinema.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMIMovie;

NS_ASSUME_NONNULL_BEGIN

@interface FMICinema : NSObject

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *title;
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMIMovie *> *movies;
@property (readonly, NS_NONATOMIC_IOSONLY) NSUInteger numberOfMovies;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTitle:(NSString *)title;

- (void)addMovie:(FMIMovie *)movie;

- (void)removeMovieAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END