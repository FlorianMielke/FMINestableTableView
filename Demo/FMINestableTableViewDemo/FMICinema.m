//
//  FMICinema.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "FMICinema.h"
#import "FMIMovie.h"
#import "NSArray+FMIValidation.h"

@interface FMICinema ()

@property (nonatomic, strong) NSMutableArray <FMIMovie *> *moviesContainer;

@end

@implementation FMICinema

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = [title copy];
        self.moviesContainer = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)numberOfMovies {
    return self.moviesContainer.count;
}

- (NSArray <FMIMovie *> *)movies {
    return [self.moviesContainer copy];
}

- (void)addMovie:(FMIMovie *)movie {
    [self.moviesContainer addObject:movie];
}

- (void)removeMovieAtIndex:(NSUInteger)index {
    if (![self.moviesContainer fmi_validateIndex:index]) {
        return;
    }
    [self.moviesContainer removeObjectAtIndex:index];
}

@end
