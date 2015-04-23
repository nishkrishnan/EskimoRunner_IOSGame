//
//  Character.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 3/1/2014./Users/Nishad/EskimoRunner/EskimoRunner/Eskimo.m
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "Character.h"

@implementation Character

@synthesize isDying;



-(void)performStand: (SKTexture*)standingFrame {
    self.standingFrame = standingFrame;
    
}

-(void)performRun: (NSArray*)runningFrames time: (float)timePrFrame {
    SKAction* run = [SKAction repeatActionForever:[SKAction animateWithTextures: self.runningFrames timePerFrame: timePrFrame]];
    SKAction* move = [SKAction moveToX:(0 - self.frame.size.width) duration:[HelperMethods randomValueBetween:2 andValue:4]];
    SKAction* moveAndRun = [SKAction group:@[run, move]];
    [self runAction:moveAndRun];
    
}

-(void)performDie: (SKAction*)die{
    [self removeAllActions];
    self.isDying = YES;
    self.physicsBody.categoryBitMask = NOCATEGORY;
    SKAction* fade = [SKAction fadeOutWithDuration:FADEDURATION];
    SKAction* dieFade = [SKAction sequence:@[die,fade]];
    [self runAction:dieFade completion:^{
        [self removeFromParent];
    }];
    
}
-(void)loadAssets {

    
}

@end
