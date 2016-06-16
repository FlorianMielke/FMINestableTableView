//
//  FMIMovie.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//


#import "FMIMovie.h"
#import "NSArray+FMIValidation.h"

@interface FMIMovie ()

@property (NS_NONATOMIC_IOSONLY) NSMutableArray *actorsContainer;

@end

@implementation FMIMovie

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = [title copy];
        self.actorsContainer = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)cast {
    return [self.actorsContainer copy];
}

- (NSUInteger)numberOfCast {
    return self.actorsContainer.count;
}

- (void)addActor:(FMIActor *)actor {
    [self.actorsContainer addObject:actor];
}

- (void)removeActorAtIndex:(NSUInteger)index {
    if (![self.actorsContainer fmi_validateIndex:index]) {
        return;
    }
    [self.actorsContainer removeObjectAtIndex:index];
}

- (nullable FMIActor *)actorAtIndex:(NSInteger)index {
    if (![self.actorsContainer fmi_validateIndex:index]) {
        return nil;
    }
    return self.actorsContainer[index];
}

@end
