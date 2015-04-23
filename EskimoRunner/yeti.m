//
//  yeti.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 1/18/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "yeti.h"

@implementation yeti {
}
@synthesize isDying;

static NSArray* runFrames;
static NSArray* dieFrames;
static SKTexture* standFrame;



-(id)init {
    
    if (self = [super initWithTexture:standFrame]) {
    

        //self = [self initWithTexture:standFrame];
        
        
        //Initialize Textures
        self.standingFrame = standFrame;
        self.runningFrames = runFrames;
        self.dyingFrames = dieFrames;
        self.name = @"monster";

        
        //Initialize Physics Bodies
        //self.physicsBody = [[PhysicsBod alloc]initPhys:self.name];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(120, 120)];
        
        self.physicsBody.restitution = 0.0;
        self.physicsBody.mass = 10;
        self.physicsBody.categoryBitMask = MONSTERCATEGORY;
        self.physicsBody.contactTestBitMask = RUNNERCATEGORY|WEAPONCATEGORY;
        self.physicsBody.collisionBitMask = GROUNDCATEGORY|RUNNERCATEGORY;
        //self.physicsBody.dynamic = YES;
        self.isDying = NO;
        
    }
    
    return self;
    
}


-(void)performRun {
    [super performRun: self.runningFrames time:0.1];
}

-(void)performAttack {
    
}

-(void)performDie {

    SKAction* die = [SKAction animateWithTextures:self.dyingFrames timePerFrame:0.1];
    [super performDie:die];
    
    
}
-(void)performClearActions {
    [self removeAllActions];
}

+(void)getHeight {
    
    
}
+(void)loadAssets {
    SKTextureAtlas* yeti_atlas = [SKTextureAtlas atlasNamed:@"obstacles_atlas"];
    standFrame = [yeti_atlas textureNamed:@"@move_1"];
    runFrames = @[[yeti_atlas textureNamed:@"move_1"], [yeti_atlas textureNamed:@"move_2"], [yeti_atlas textureNamed:@"move_3"], [yeti_atlas textureNamed:@"move_4"]];
    dieFrames = @[[yeti_atlas textureNamed:@"death_1"], [yeti_atlas textureNamed:@"death_2"], [yeti_atlas textureNamed:@"death_3"], [yeti_atlas textureNamed:@"death_4"], [yeti_atlas textureNamed:@"death_5"]];


    
}

@end
