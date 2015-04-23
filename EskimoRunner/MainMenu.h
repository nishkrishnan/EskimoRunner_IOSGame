//
//  MainMenu.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2014-03-08.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface MainMenu : SKScene
-(BOOL)isInButton: (CGPoint)loc andName:(NSString*)name;
@end
