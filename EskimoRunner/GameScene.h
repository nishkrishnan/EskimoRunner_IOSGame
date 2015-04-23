//
//  MyScene.h
//  EskimoRunner
//

//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Eskimo.h"
#import "yeti.h"
#import "Bird.h"
#import "Physics.h"
#import "GameOver.h"
#import "Level.h"


@interface GameScene : SKScene
@property (nonatomic)SKSpriteNode* eskimo;
@property (nonatomic)NSTimeInterval lastUpdateTime;
@property (nonatomic)NSTimeInterval dt;
@property(nonatomic)NSTimeInterval spawnTime;
//@property(nonatomic)NSTimeInterval timerLength;

-(void)addYeti;
+(void)loadSceneAssets;

@end
