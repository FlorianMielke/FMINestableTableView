//
//  FMIMovie.m
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "FMIMovie.h"
#import "FMIActor.h"

@implementation FMIMovie

- (instancetype)initWithTitle:(NSString *)title releaseYear:(NSNumber *)releaseYear cast:(NSArray<FMIActor *> *)cast {
    self = [super init];
    if (self) {
        _title = [title copy];
        _cast = cast;
        _releaseYear = releaseYear;
    }
    return self;
}

@end
