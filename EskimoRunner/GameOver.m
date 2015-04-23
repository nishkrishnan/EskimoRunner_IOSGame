//
//  GameOver.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2/26/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver


-(id) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed: @"bg_menu"];
        background.position = CGPointMake(0, 0);
        //background.xScale = 0.5;
        //background.yScale = 0.5;
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        SKLabelNode* gmeOver = [SKLabelNode labelNodeWithFontNamed:@"Zapfino"];
        gmeOver.text = @"GAME OVER";
        gmeOver.fontSize = 42;
        gmeOver.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:gmeOver];
        
        
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime {
    
}

@end
