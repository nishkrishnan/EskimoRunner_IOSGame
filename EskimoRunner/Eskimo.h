//
//  Eskimo.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 1/17/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Character.h"

@interface Eskimo : Character
@property BOOL jumping;
@property BOOL shooting;
@property(strong, nonatomic)NSArray* jumpingFrames;

-(void)performRun;
-(void)performShoot;
-(void)performJump;
-(void)performDuck;
-(void)clearBullet;
+(void)loadAssets;
@end
