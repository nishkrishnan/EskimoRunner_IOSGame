//
//  Physics.h
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2/1/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Physics : SKNode
@property(nonatomic, weak)NSString* type;
-(instancetype)initPhys:(NSString*)string :(CGSize)size;
+(BOOL)playerMonsterCollisions:(SKPhysicsContact*)contact;
+(BOOL)weaponMonsterCollisions:(SKPhysicsContact*)contact;

@end
