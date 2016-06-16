#import <Foundation/Foundation.h>

@class FMICinemaWorld;

NS_ASSUME_NONNULL_BEGIN

@interface FMIWorldProvider : NSObject

+ (FMICinemaWorld *)provideWorld;

@end

NS_ASSUME_NONNULL_END