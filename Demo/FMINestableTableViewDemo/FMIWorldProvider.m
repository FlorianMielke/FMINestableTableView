#import "FMIWorldProvider.h"
#import "FMICinemaWorld.h"
#import "FMIMovie.h"
#import "FMIActor.h"
#import "FMICinema.h"

@implementation FMIWorldProvider

+ (FMICinemaWorld *)provideWorld {
    FMICinemaWorld *world = [[FMICinemaWorld alloc] init];
    FMICinema *cinema1 = [[FMICinema alloc] initWithTitle:@"Cinema 1"];
    [cinema1 addMovie:[self pulpFiction]];
    [cinema1 addMovie:[self killBillVol1]];
    [cinema1 addMovie:[self ingloriousBasterds]];
    [world addCinema:cinema1];
    FMICinema *cinema2 = [[FMICinema alloc] initWithTitle:@"Cinema 2"];
    [cinema2 addMovie:[self jackieBrown]];
    [cinema2 addMovie:[self killBillVol2]];
    [world addCinema:cinema2];
    FMICinema *cinema3 = [[FMICinema alloc] initWithTitle:@"Cinema 3"];
    [cinema3 addMovie:[self djangoUnchained]];
    [world addCinema:cinema3];
    return world;
}

+ (FMIMovie *)pulpFiction {
    FMIMovie *pulpFiction = [[FMIMovie alloc] initWithTitle:@"Pulp Fiction"];
    FMIActor *travolta = [[FMIActor alloc] initWithName:@"John Travolta"];
    [pulpFiction addActor:travolta];
    FMIActor *willis = [[FMIActor alloc] initWithName:@"Bruce Willis"];
    [pulpFiction addActor:willis];
    return pulpFiction;
}

+ (FMIMovie *)killBillVol1 {
    return [[FMIMovie alloc] initWithTitle:@"Kill Bill Vol. 1"];
}

+ (FMIMovie *)ingloriousBasterds {
    FMIMovie *ingloriousBasterds = [[FMIMovie alloc] initWithTitle:@"Inglorious Basterds"];
    FMIActor *pitt = [[FMIActor alloc] initWithName:@"Brad Pitt"];
    [ingloriousBasterds addActor:pitt];
    return ingloriousBasterds;
}

+ (FMIMovie *)jackieBrown {
    return [[FMIMovie alloc] initWithTitle:@"Jackie Brown"];
}

+ (FMIMovie *)killBillVol2 {
    FMIMovie *killBill = [[FMIMovie alloc] initWithTitle:@"Kill Bill Vol. 2"];
    FMIActor *thurman = [[FMIActor alloc] initWithName:@"Uma Thurman"];
    [killBill addActor:thurman];
    return killBill;
}

+ (FMIMovie *)djangoUnchained {
    return [[FMIMovie alloc] initWithTitle:@"Django Unchained"];
}

@end
