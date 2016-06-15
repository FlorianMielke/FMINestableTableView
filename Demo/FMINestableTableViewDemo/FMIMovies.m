//
//  FMIMovies.h
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "FMIMovies.h"
#import "FMIMovie.h"
#import "FMIActor.h"

@implementation FMIMovies

- (NSArray <FMIMovie *> *)movies {
    FMIActor *uma = [[FMIActor alloc] initWithName:@"Uma Thurman"];
    FMIActor *samuel = [[FMIActor alloc] initWithName:@"Samuel L. Jackson"];
    FMIMovie *pulp = [[FMIMovie alloc] initWithTitle:@"Pulp Fiction" releaseYear:@1994 cast:@[uma, samuel]];

    FMIActor *jeff = [[FMIActor alloc] initWithName:@"Jeff Bridges"];
    FMIActor *john = [[FMIActor alloc] initWithName:@"John Goodman"];
    FMIMovie *lebowski = [[FMIMovie alloc] initWithTitle:@"The Big Lebowski" releaseYear:@1998 cast:@[jeff, john]];

    FMIActor *edward = [[FMIActor alloc] initWithName:@"Edward Norton"];
    FMIActor *brad = [[FMIActor alloc] initWithName:@"Brad Pitt"];
    FMIMovie *fight = [[FMIMovie alloc] initWithTitle:@"Fight Club" releaseYear:@1999 cast:@[edward, brad]];

    return @[pulp, lebowski, fight];
}

@end
