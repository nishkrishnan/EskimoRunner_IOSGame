//
//  Level.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2014-03-07.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "Level.h"

@implementation Level

static const float easyMin = 4;
static const float easyMax = 6;
static const float medMin = 2;
static const float hardMin = 1;
static const float medMax = 4;
static const float hardMax = 2;

-(id)init {
    if (self = [super init]) {
        self.timerLength = 0;
        self.isSpawn = NO;
    }
    return self;
}

-(void)easy {
    self. timerLength = [HelperMethods randomValueBetween:easyMin andValue:easyMax];
    NSLog(@"EASY LEVEL");
    
}

-(void)medium {
    self. timerLength = [HelperMethods randomValueBetween:medMin andValue:medMax];
        NSLog(@"MEDIUM LEVEL");
}

-(void)hard {
    self. timerLength = [HelperMethods randomValueBetween:hardMin andValue:hardMax];
        NSLog(@"HARD LEVEL");
}

-(NSTimeInterval)spawnTimeLength {
    self.isSpawn = NO;
    return self.timerLength;
}

-(void)update:(CFTimeInterval)currentTime {
    if (!self.isSpawn) {
        self.isSpawn = YES;
        if (currentTime <= EASY_THRESHOLD) {
            NSLog(@"%f", currentTime);

            [self easy];
        }
        else if (currentTime <= MED_THRESHOLD) {
             NSLog(@"%f", currentTime);
            [self medium];
           
        }
        else if (currentTime <= HARD_THRESHOLD) {
             NSLog(@"%f", currentTime);
            [self hard];
           
        }
    }
    
    
    
}

@end
