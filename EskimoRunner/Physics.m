//
//  Physics.m
//  EskimoRunner
//
//  Created by Nishad Krishnan on 2/1/2014.
//  Copyright (c) 2014 TheBusiness. All rights reserved.
//

#import "Physics.h"

@implementation Physics {
}

static const uint32_t weaponCategory = 0x1 << 1;
static const uint32_t runnerCategory = 0x1 << 2;
static const uint32_t monsterCategory = 0x1 <<3;
static const uint32_t groundCategory = 0x1 << 4;


+(SKNode*)initPhys:(SKNode*)node :(CGSize)size{
        
        
        if ([node.name isEqualToString: @"monster"]) {
            node.physicsBody.categoryBitMask = monsterCategory;
            node.physicsBody.contactTestBitMask = runnerCategory|weaponCategory;
            node.physicsBody.collisionBitMask = groundCategory|runnerCategory;
            node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
            node.physicsBody.mass = 10;
            node.physicsBody.dynamic = YES;
        }
        else if ([node.name isEqualToString:@"weapon"]) {
            node.physicsBody.categoryBitMask = weaponCategory;
            node.physicsBody.contactTestBitMask = monsterCategory;
            node.physicsBody.collisionBitMask = monsterCategory;
            node.physicsBody.usesPreciseCollisionDetection = YES;
            node.physicsBody.mass = 0.5;
            node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
            node.physicsBody.affectedByGravity = NO;
        }
        else if ([node.name isEqualToString:@"ground"]) {
            node.physicsBody.categoryBitMask = groundCategory;
            node.physicsBody.collisionBitMask = runnerCategory|monsterCategory;
            node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
            node.physicsBody.dynamic = NO;
            
        }
        else if ([node.name isEqualToString:@"runner"]) {
            node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
            node.physicsBody.restitution = 0.3;
            node.physicsBody.mass = 1;
            node.physicsBody.categoryBitMask = runnerCategory;
            node.physicsBody.contactTestBitMask = monsterCategory;
            node.physicsBody.collisionBitMask = groundCategory|monsterCategory;
            
        }
    
    return node;

    
}



+(BOOL)playerMonsterCollisions: (SKPhysicsContact*)contact {
    if ((contact.bodyA.categoryBitMask == runnerCategory || contact.bodyB.categoryBitMask == runnerCategory) && (contact.bodyA.categoryBitMask == monsterCategory || contact.bodyB.categoryBitMask == monsterCategory)) {
        return true;
    }
    return false;
}

+(BOOL)weaponMonsterCollisions: (SKPhysicsContact*)contact {
    if ((contact.bodyA.categoryBitMask == weaponCategory || contact.bodyB.categoryBitMask == weaponCategory) && (contact.bodyA.categoryBitMask == monsterCategory || contact.bodyB.categoryBitMask == monsterCategory)) {
        return true;
    }
    return false;
}


@end
