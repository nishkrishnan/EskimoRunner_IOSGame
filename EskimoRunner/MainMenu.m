//
//  MainMenu.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2014-03-08.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        SKSpriteNode* button = [SKSpriteNode spriteNodeWithImageNamed:@"playButton"];
        [button setScale:0.5];
        //SKLabelNode *button = [[SKLabelNode alloc]initWithFontNamed:@"MarkerFelt-Wide"];
        button.name = @"play";
        //button.text = @"Play Game";
        button.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:button];
        
        
    }
    
    return self;
    
}

-(BOOL) isInButton: (CGPoint)loc andName:(NSString*)name {
    
    SKSpriteNode* button = (SKSpriteNode*)[self childNodeWithName:name];
    CGFloat radius = button.frame.size.height;
    
    
    CGFloat firstNum = powf((loc.x + radius), (loc.x + radius));
    
    CGFloat secondNum = powf((loc.y + radius), (loc.y + radius));
    CGFloat radiusSquare = powf((radius), (radius));
    if (firstNum + secondNum <= radiusSquare) { //equation of a circle
        return true;
        
        
    }
    return false;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:touch.view];
    if([self isInButton:loc andName:@"play"]) {
        SKTransition *change = [SKTransition fadeWithColor:[SKColor blackColor] duration:2];
        
        GameScene* newScene = [[GameScene alloc]initWithSize: self.frame.size];
        [self.scene.view presentScene: newScene transition:change];
    }

    /*NSArray *nodes = [self nodesAtPoint:[touch locationInNode:[self childNodeWithName:@"play"]]];
    
    for (SKNode* node in nodes) {
        NSLog(@"%@", node.name);
    
        if ([node.name isEqualToString:@"play"]) {
            
            SKTransition *change = [SKTransition fadeWithColor:[SKColor blackColor] duration:2];
            
            GameScene* newScene = [[GameScene alloc]initWithSize: self.frame.size];
            [self.scene.view presentScene: newScene transition:change];
            
        }
    }*/
    

}


-(void)update:(CFTimeInterval)currentTime {


}


@end
