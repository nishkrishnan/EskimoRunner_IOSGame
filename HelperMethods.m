//
//  HelperMethods.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 3/1/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "HelperMethods.h"

@implementation HelperMethods

+(float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}


@end
