//
//  FMICinemaWorld.m
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "FMICinemaWorld.h"
#import "FMIMovie.h"
#import "FMIActor.h"
#import "FMICinema.h"
#import "NSArray+FMIValidation.h"

@interface FMICinemaWorld ()

@property (NS_NONATOMIC_IOSONLY) NSMutableArray <FMICinema *> *cinemaContainer;

@end

@implementation FMICinemaWorld

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cinemaContainer = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)numberOfCinemas {
    return self.cinemaContainer.count;
}

- (FMICinema *)cinemaAtIndex:(NSInteger)index {
    if (![self.cinemaContainer fmi_validateIndex:index]) {
        return nil;
    }
    return self.cinemaContainer[index];
}

- (FMIMovie *)movieAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.cinemaContainer fmi_validateIndex:index]) {
        return nil;
    }
    FMICinema *cinema = self.cinemaContainer[(NSUInteger) indexPath.section];
    return cinema.movies[indexPath.row];
}

- (void)addCinema:(FMICinema *)cinema {
    [self.cinemaContainer addObject:cinema];
}

- (void)removeMovieAtIndexPath:(NSIndexPath *)indexPath {
    FMICinema *cinema = self.cinemaContainer[(NSUInteger) indexPath.section];
    [cinema removeMovieAtIndex:indexPath.row];
}


@end
