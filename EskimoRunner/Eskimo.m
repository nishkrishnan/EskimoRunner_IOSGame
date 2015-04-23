//
//  Eskimo.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 1/17/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "Eskimo.h"

@implementation Eskimo


static NSArray* runFrames;
static SKTexture* standFrame;
static NSArray* jumpFrames;
static SKTexture* weaponFrame;

-(id)init {
    if (self = [super initWithTexture:standFrame]) {
    
        //Eskimo* player = [[Eskimo alloc]initWithTexture:standing];
        //self = [self initWithTexture:standFrame];
        [self setScale:0.2];
        
        //Initialize Textures
        self.standingFrame = standFrame;
        self.runningFrames = runFrames;
        self.jumpingFrames = jumpFrames;
        self.name = @"runner";
        
        //Initialize Physics Bodies
        //self.physicsBody = [[PhysicsBod alloc]initPhys:self.name];
        self.physicsBodySize = CGSizeMake(68, 68);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.physicsBodySize];
        //self.physicsBody.restitution = 0.3;
        self.physicsBody.mass = 1;
        
        self.physicsBody.categoryBitMask = RUNNERCATEGORY;
        self.physicsBody.contactTestBitMask = MONSTERCATEGORY;
        self.physicsBody.collisionBitMask = GROUNDCATEGORY| MONSTERCATEGORY;
        self.shooting = NO;

        
    }
    
    return self;
    
    
}


-(void)performRun {
    self.jumping = NO;
    [self removeAllActions];
    
    SKAction* run = [SKAction repeatActionForever:[SKAction animateWithTextures:self.runningFrames timePerFrame: 0.06]];
    [self runAction:run];
    
	
    
}

-(void) performJump {
	
	if(!self.jumping) {
		self.jumping = YES;
        
		CGVector force = CGVectorMake(0, 600);
		[self.physicsBody applyImpulse: force];
        
		SKAction* jumping = [SKAction animateWithTextures:self.jumpingFrames timePerFrame: 0.3];
        
        [self runAction:jumping completion:^{
            [self performRun];
        }];
        
    }
}

-(void)performDuck {
    
}
-(void)performShoot {
    if (!self.shooting) {

    //CGPoint sceneSize = [self convertPoint: toNode:self.parent];
    
    self.shooting = YES;
    SKSpriteNode* bullet = [SKSpriteNode spriteNodeWithTexture: weaponFrame size:CGSizeMake(30, 30)];
    bullet.name = @"weapon";
    //[bullet setScale:0.075];
    CGPoint bulletDest = CGPointMake(self.parent.frame.size.width + bullet.size.width, self.position.y);
    
    
    
    bullet.position = self.position;
    [self.parent addChild:bullet];
    //bullet.physicsBody = [[PhysicsBod alloc]initPhys:bullet.name];
    
    bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.size];
    
    bullet.physicsBody.affectedByGravity = NO;
    bullet.physicsBody.categoryBitMask = WEAPONCATEGORY;
    bullet.physicsBody.contactTestBitMask = MONSTERCATEGORY;
    bullet.physicsBody.collisionBitMask = MONSTERCATEGORY;
    bullet.physicsBody.usesPreciseCollisionDetection = YES;
    bullet.physicsBody.mass = 0.5;
    
    SKAction* fly = [SKAction moveToX:bulletDest.x duration:(1)];
    SKAction* rotate = [SKAction repeatActionForever:[SKAction rotateByAngle:2*M_PI duration:0.5]];
    SKAction* group = [SKAction group:@[fly, rotate]];
    //SKAction* remove = [SKAction removeFromParent];
    //SKAction* fireRemove = [SKAction sequence:@[group, remove]];
        [bullet runAction:group];
    }

    
    
    
    
    
}


-(void) performClearActions {
	[self removeAllActions];
	self.jumping = NO;
}

-(void)clearBullet {
    SKSpriteNode* bullet = (SKSpriteNode*)[self.parent childNodeWithName:@"weapon"];
    if (bullet.position.x >= bullet.parent.frame.size.width) {
        self.shooting = NO;
        [bullet removeFromParent];
    }

}

+(void)loadAssets {
    SKTextureAtlas *eskAtlas = [SKTextureAtlas atlasNamed:@"esk_atlas"];
    SKTextureAtlas* obst_atlas = [SKTextureAtlas atlasNamed:@"obstacles_atlas"];
    runFrames = @[[eskAtlas textureNamed:@"run_1"], [eskAtlas textureNamed:@"run_2"], [eskAtlas textureNamed:@"run_3"], [eskAtlas textureNamed:@"run_4"], [eskAtlas textureNamed:@"run_5"], [eskAtlas textureNamed:@"run_6"], [eskAtlas textureNamed:@"run_7"], [eskAtlas textureNamed:@"run_8"], [eskAtlas textureNamed:@"run_9"], [eskAtlas textureNamed:@"run_10"]];
    standFrame = [eskAtlas textureNamed: @"standing"];
    jumpFrames = @[[eskAtlas textureNamed:@"jump_1"], [eskAtlas textureNamed:@"jump_2"], [eskAtlas textureNamed:@"jump_3"], [eskAtlas textureNamed:@"jump_4"], [eskAtlas textureNamed:@"jump_5"]];
    weaponFrame = [obst_atlas textureNamed:@"ninja_star"];
    


}



@end
