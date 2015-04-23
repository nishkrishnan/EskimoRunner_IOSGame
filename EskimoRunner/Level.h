//
//  Level.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2014-03-07.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "HelperMethods.h"

#define EASY_THRESHOLD 20
#define MED_THRESHOLD 40
#define HARD_THRESHOLD 60
@interface Level : NSObject

@property(nonatomic)NSTimeInterval timerLength;
@property(nonatomic)BOOL isSpawn;

-(id)init;
-(void)easy;
-(void)medium;
-(void)hard;
-(NSTimeInterval)spawnTimeLength;
-(void)update:(CFTimeInterval)currentTime;


@end
