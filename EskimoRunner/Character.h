//
//  Character.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 3/1/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "HelperMethods.h"

@interface Character : SKSpriteNode

#define WEAPONCATEGORY 0x1 << 1
#define RUNNERCATEGORY 0x1 << 2
#define MONSTERCATEGORY 0x1 <<3
#define GROUNDCATEGORY  0x1 << 4
#define NOCATEGORY 0x0
#define FADEDURATION 1


@property BOOL dying;
@property(assign, nonatomic)CGSize physicsBodySize;
@property (strong, nonatomic) SKTexture* standingFrame;
@property(strong, nonatomic)NSArray* runningFrames;
@property(strong, nonatomic)NSArray* jumpingFrames;
@property(strong, nonatomic)NSArray* dyingFrames;
@property (nonatomic, assign) BOOL isDying;



-(void)performRun: (NSArray*)runningFrames time: (float)timePrFrame;
-(void)performStand:(SKTexture*)standingFrame;
-(void)performDie: (SKAction*)die;
@end
