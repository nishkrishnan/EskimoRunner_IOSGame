//
//  Bird.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2/27/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Character.h"

@interface Bird : Character


-(void)performFly;
-(void)performDie;
+(void)loadAssets;

@end
