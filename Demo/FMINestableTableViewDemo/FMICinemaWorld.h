//
//  FMICinemaWorld.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMIMovie;
@class FMICinema;

NS_ASSUME_NONNULL_BEGIN

@interface FMICinemaWorld : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMICinema *> *cinemas;
@property (readonly, NS_NONATOMIC_IOSONLY) NSUInteger numberOfCinemas;

- (nullable FMIMovie *)movieAtIndexPath:(NSIndexPath *)indexPath;

- (void)addCinema:(FMICinema *)cinema;

- (void)removeMovieAtIndexPath:(NSIndexPath *)path;

@end

NS_ASSUME_NONNULL_END
