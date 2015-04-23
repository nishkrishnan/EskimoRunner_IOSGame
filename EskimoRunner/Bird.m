//
//  Bird.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2/27/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "Bird.h"
#include "math.h"

@implementation Bird

@synthesize isDying;

static NSArray* runFrames;
static NSArray* dieFrames;
static SKTexture* standFrame;


-(id)init{
    if (self = [super initWithTexture:standFrame]) {
        
        
        //self = [self initWithTexture:standFrame];
        [self setScale:0.4];
        
        //Initialize Textures
        self.standingFrame = standFrame;
        self.runningFrames = runFrames;
        //self.dyingFrames = @[[bird_atlas textureNamed:@"b_fly1"], [_atlas textureNamed:@"b_fly2"], [bird_atlas textureNamed:@"b_fly3"], [bird_atlas textureNamed:@"b_fly4"], [bird_atlas textureNamed:@"b_fly5"]];
        self.name = @"monster";
        
        
        //Initialize Physics Bodies
        //self.physicsBody = [[PhysicsBod alloc]initPhys:self.name];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(70, 60)];
        self.physicsBody.contactTestBitMask = RUNNERCATEGORY|WEAPONCATEGORY;
        self.physicsBody.categoryBitMask = MONSTERCATEGORY;
        self.physicsBody.collisionBitMask = RUNNERCATEGORY;
        self.physicsBody.affectedByGravity = NO;
        
        self.physicsBody.restitution = 0.0;
        self.physicsBody.mass = 10;
        //self.physicsBody.dynamic = YES;
        self.isDying = NO;
        
    }
    return self;
}

-(void)performFly {
    [super performRun: self.runningFrames time: 0.1];
}
-(void)performDie {
    self.physicsBody.affectedByGravity = YES;
    SKAction* die = [SKAction rotateByAngle:(M_PI/4) duration:0.5];
    [super performDie:die];


}

+(void)loadAssets {
    SKTextureAtlas* bird_atlas = [SKTextureAtlas atlasNamed:@"monster_atlas"];
    
    runFrames = @[[bird_atlas textureNamed:@"b_fly1"], [bird_atlas textureNamed:@"b_fly2"], [bird_atlas textureNamed:@"b_fly3"]];
    standFrame = [bird_atlas textureNamed:@"b_fly1"];

}

@end
