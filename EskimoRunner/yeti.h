//
//  yeti.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 1/18/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Physics.h"
#import "Character.h"

@interface yeti : Character
/*
@property(assign, nonatomic)CGSize physicsBodySize;
@property (strong, nonatomic) SKTexture* standingFrame;
@property(strong, nonatomic)NSArray* runningFrames;
@property(strong, nonatomic)NSArray* dyingFrames;
@property (nonatomic, assign) BOOL isDying;
@property (nonatomic, assign)CGFloat height;*/


-(void)performRun;
-(void)performAttack;
-(void)performDie;
-(void)performClearActions;
+(void)loadAssets;

@end
