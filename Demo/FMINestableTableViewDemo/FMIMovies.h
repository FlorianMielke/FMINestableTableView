//
//  FMIMovies.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMIMovie;

NS_ASSUME_NONNULL_BEGIN

@interface FMIMovies : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMIMovie *> *movies;

@end

NS_ASSUME_NONNULL_END