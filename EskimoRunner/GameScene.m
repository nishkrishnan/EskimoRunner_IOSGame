//
//  MyScene.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 1/14/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "GameScene.h"
#include "math.h"

@implementation GameScene {
    
    NSString* bg_name;
    NSString* fg_name;
    Level *Difficulty;
        //ParallaxBackground *bg;
    
    
    SKSpriteNode* touchToBegin;
    CGPoint touchBegin;
    SKTextureAtlas *obst_atlas;
    NSTimer* spawnRate;
    float timerLength;
    BOOL gameStarted;
    int monstersKilled;
    CFTimeInterval gameStartTime;
    int yetiCount;
    int birdCount;

    
}

//static SKTextureAtlas *eskAtlas;
//static SKTextureAtlas* obstAtlas;
static SKSpriteNode* bg;
static SKSpriteNode* fg;



static const uint32_t weaponCategory = 0x1 << 1;
static const uint32_t runnerCategory = 0x1 << 2;
static const uint32_t monsterCategory = 0x1 <<3;
static const uint32_t groundCategory = 0x1 << 4;

const float SCREENLEFTRIGHTPOS = 250;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        [GameScene loadSceneAssets];
        
        /* Setup your scene here */
         //obst_atlas = [SKTextureAtlas atlasNamed:@"obstacles_atlas"];
        
        self.backgroundColor = [SKColor blackColor];
        //bg = [SKSpriteNode spriteNodeWithImageNamed: @"bg_mainlevel"];
        
        bg.position = CGPointMake(0,0);
        bg.xScale = 0.5;
        bg.yScale = 0.5;
        bg.anchorPoint = CGPointZero;
        bg.name = @"bg";
        [self addChild:bg];
        [self initializeBackground:bg];
        //bg = [[ParallaxBackground alloc]init:self];
        //[self addChild:bg];
        
        //fg = [SKSpriteNode spriteNodeWithImageNamed:@"fg_mainlevel"];
        fg.position = CGPointMake(0, 0);
        fg.xScale = 0.5;
        fg.yScale = 0.5;
        fg.anchorPoint = CGPointZero;
        fg.name = @"ground";
        //fg.physicsBody = [[Physics alloc]initPhys:fg.name :fg.size].physicsBody;
        [self addChild:fg];
        [self initializeBackground:fg];
        [self MakeGround];
        
        
        //self.timerLength = 5.0;
        Eskimo *runner = [[Eskimo alloc]init];
        NSLog(@"%f", runner.physicsBody.restitution);
        runner.position = CGPointMake(100, 100);
        
        [self addChild:runner];
        
        
        self.physicsWorld.gravity = CGVectorMake(0, -6); // 0, -2
        
      

        
        self.physicsWorld.contactDelegate = self;
        
        [runner performRun];
        
        touchToBegin = [SKSpriteNode spriteNodeWithImageNamed:@"touchbegin"];
        
        touchToBegin.position = CGPointMake(self.size.width/2, self.size.height/2);
        
        [self addChild:touchToBegin];
        
        
        
        
        gameStarted = NO;
        
        timerLength = 1.0;
        
      
        
        
        
        
    }
    return self;
}


#pragma mark Start Game

-(void)startGame {
    
    SKAction* fade = [SKAction fadeOutWithDuration:1];
    [touchToBegin runAction:fade completion:^{
        [touchToBegin removeFromParent];
        gameStarted = YES;
        yetiCount = 0;
        birdCount = 0;
        Difficulty = [[Level alloc]init];
        [self initScore];
        
        //spawnRate = [NSTimer timerWithTimeInterval:timerLength target:self selector:@selector(addYeti) userInfo:nil repeats:NO];
        //[[NSRunLoop currentRunLoop] addTimer:spawnRate forMode:NSRunLoopCommonModes];
    }];
}









#pragma mark Background and Ground

-(void)initializeBackground:(SKSpriteNode*)node {
    
    SKSpriteNode* bGround = [SKSpriteNode spriteNodeWithTexture:node.texture];

    bGround.texture = node.texture;
    bGround.xScale = node.xScale;
    bGround.yScale = node.yScale;
    bGround.name = node.name;
    bGround.anchorPoint = CGPointZero;
    bGround.position = CGPointMake(bGround.size.width,0);

        
        
    [self addChild:bGround];
    
    

    
}

-(void)Parallax:(CGPoint)velocity image:(NSString*)name {
    
    [self enumerateChildNodesWithName:name usingBlock: ^(SKNode* node, BOOL* stop)
     {
         SKSpriteNode* bground = (SKSpriteNode *) node;
         CGPoint amtToMove = CGPointMake(velocity.x * self.dt, velocity.y* self.dt);
         
         bground.position = CGPointMake(bground.position.x + amtToMove.x, bground.position.y + amtToMove.y);
         
         if (bground.position.x <= -bground.size.width) {
             bground.position = CGPointMake(bground.position.x + bground.size.width*2, bground.position.y);
         }
     }];
}



-(void)MakeGround {
    [self enumerateChildNodesWithName:@"ground" usingBlock: ^(SKNode* node, BOOL* stop)
     {
         SKSpriteNode* ground = (SKSpriteNode*)node;
         //ground.physicsBody = [[PhysicsBod alloc]initPhys:ground.name];
         ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
         
         ground.physicsBody.dynamic = NO;
         ground.physicsBody.categoryBitMask = groundCategory;
         ground.physicsBody.collisionBitMask = runnerCategory|monsterCategory;
     }];

}

-(void)updateParallax:(CFTimeInterval)currentTime {
    
    if (self.lastUpdateTime) {
        self.dt = currentTime - self.lastUpdateTime;
    }
    else {
        self.dt = 0;
    }
    self.lastUpdateTime = currentTime;
    [self Parallax:CGPointMake(-25, 0) image: bg.name];
    [self Parallax:CGPointMake(-100, 0) image:fg.name];
    
}











#pragma mark Yeti Stuff

-(void)addYeti {
    
    yeti* monsta = [[yeti alloc]init];
    /*
    monsta.physicsBody.categoryBitMask = monsterCategory;
    monsta.physicsBody.contactTestBitMask = runnerCategory|weaponCategory;
    monsta.physicsBody.collisionBitMask = groundCategory|runnerCategory;*/
    monsta.position = CGPointMake(self.frame.size.width/*+monsta.size.width/2*/, 100);
    [self addChild:monsta];
    NSLog(@"spawnyeti");
    [monsta performRun];
    
    //spawnRate = [NSTimer scheduledTimerWithTimeInterval:timerLength target:self selector:@selector(addYeti) userInfo:nil repeats:NO];
    
}

-(void)addBird {
    Bird* blueJay = [[Bird alloc]init];
    
    blueJay.position = CGPointMake(self.frame.size.width+blueJay.size.width/2, [self randomValueBetween:([self childNodeWithName:@"ground"]).frame.size.height + 64 andValue: self.frame.size.height-blueJay.size.height]);
    [self addChild:blueJay];
    NSLog(@"spawnbluejay");
    
    [blueJay performFly];
}
- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

-(void)spawnMonster {
    int monsterChoice = roundf([self randomValueBetween:0 andValue:1]);

    
    self.spawnTime += self.dt;
    if (self.spawnTime >= [Difficulty spawnTimeLength]) {
        self.spawnTime = 0;
        if (monsterChoice == 0) {
            yetiCount++;
            birdCount = 0;
            if (yetiCount == 3) {
                monsterChoice = 1;
            }
            else {
                [self addYeti];
            }
        }
        else if (monsterChoice == 1) {
            birdCount++;
            yetiCount = 0;
            [self addBird];
        }
    }
    
    
    
    
}

-(void)clearMonster {
    [self enumerateChildNodesWithName:@"monster" usingBlock: ^(SKNode* node, BOOL* stop)
     {
         SKSpriteNode* monster = (SKSpriteNode*)node;
         
         if(monster.position.x <= 0) {
             if (monster.position.y <= 0) {
                 [monster removeFromParent];
             }
             else {
                 [monster removeFromParent];
                 [self changeScene];

             }
             
         }
         
     }];
    
    //[spawnRate invalidate];
    
}













#pragma mark Physics and Eskimo

-(void)didBeginContact:(SKPhysicsContact*)contact {
    if ([Physics playerMonsterCollisions:contact]) {
        NSLog(@"you lose");
        [self changeScene];
        
    }
    if ([Physics weaponMonsterCollisions:contact]) {
        Eskimo *runner = (Eskimo*)[self childNodeWithName:@"runner"];
        if ([contact.bodyA.node isKindOfClass:[yeti class]]) {
            if (!((yeti*)contact.bodyA.node).isDying) {
                [(yeti*)contact.bodyA.node performDie];
                runner.shooting = NO;
                [contact.bodyB.node removeFromParent];
                
            }
        }
        else if ([contact.bodyA.node isKindOfClass:[Bird class]]) {
            if (!((Bird*)contact.bodyA.node).isDying) {
                [(Bird*)contact.bodyA.node performDie];
                runner.shooting = NO;
                [contact.bodyB.node removeFromParent];
            }
        }
        else if ([contact.bodyB.node isKindOfClass:[Bird class]]){
            if (!((Bird*)contact.bodyB.node).isDying) {
                [(Bird*)contact.bodyB.node performDie];
                runner.shooting = NO;
                [contact.bodyA.node removeFromParent];
            }
        }
        else {
            if (!((yeti*)contact.bodyB.node).isDying) {
                [(yeti*)contact.bodyB.node performDie];
                runner.shooting = NO;
                [contact.bodyA.node removeFromParent];
            }
        }
        [self updateScore];
        
        
    }
}


-(void)performShoot {
    Eskimo *runner = (Eskimo*)[self childNodeWithName:@"runner"];
    [runner performShoot];
}



#pragma mark Score
-(void)initScore {
    monstersKilled = 0;
    SKLabelNode* score = [[SKLabelNode alloc]initWithFontNamed:@"MarkerFelt-Wide"];
    score.text = [NSString stringWithFormat:@"%d", monstersKilled];
    score.position = CGPointMake(self.frame.size.width - 50, 10);
    score.name = @"score";
    [self addChild:score];
}
-(void)updateScore {
    
    SKLabelNode*score = (SKLabelNode*)[self childNodeWithName:@"score"];
    monstersKilled++;
    score.text = [NSString stringWithFormat:@"%d", (monstersKilled)];
    
    
    
}














    
#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];

    
	CGPoint loc = [touch locationInView:touch.view];
    
    if (!gameStarted) {
        [self startGame];
        
    }
    
    else {
        if (loc.x < SCREENLEFTRIGHTPOS) {
            NSLog(@"shoot");
            [self performShoot];
        }
        else if (loc.x > SCREENLEFTRIGHTPOS){
            touchBegin = loc;
        }
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    
    
	CGPoint loc = [touch locationInView:touch.view];
    
    
    if (gameStarted) {
        if (loc.x >= SCREENLEFTRIGHTPOS) {
            Eskimo* runner = (Eskimo*)[self childNodeWithName:@"runner"];
            if ((loc.y - touchBegin.y) > 0) {
                NSLog(@"duck");
                [runner performDuck];
                
            }
            else if ((loc.y - touchBegin.y) < 0) {
                NSLog(@"jump");
                
                [runner performJump];

            }
        }
    }
}









#pragma mark Update Method

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateParallax:currentTime];
    if (gameStarted) {
        [Difficulty update:(currentTime-gameStartTime)];
        [self spawnMonster];
        [self clearMonster];
        [(Eskimo*)[self childNodeWithName:@"runner"] clearBullet];
        
    }
    else {
        gameStartTime = currentTime;
        //NSLog(@"%f", gameStartTime);
    }
    
    
}






#pragma mark Game Over

-(void)changeScene {
    SKTransition *change = [SKTransition fadeWithColor:[SKColor whiteColor] duration:2];
    //change.pausesOutgoingScene = NO;
    GameOver* newScene = [[GameOver alloc]initWithSize: self.frame.size];
    [self.scene.view presentScene: newScene transition:change];
}

#pragma mark Load Scene Assets

+(void)loadSceneAssets {
    
    SKTextureAtlas *eskAtlas = [SKTextureAtlas atlasNamed:@"esk_atlas"];
    SKTextureAtlas* obstAtlas = [SKTextureAtlas atlasNamed:@"obstacles_atlas"];
    bg = [SKSpriteNode spriteNodeWithImageNamed: @"bg_mainlevel"];
    fg = [SKSpriteNode spriteNodeWithImageNamed:@"fg_mainlevel"];
    [Eskimo loadAssets];
    [yeti loadAssets];
    [Bird loadAssets];
}

@end
