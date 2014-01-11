//
//  GameScene.m
//  spaceViking
//
//  Created by Aashish Karki on 1/9/14.
//  Copyright (c) 2014 Aashish Karki. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
-(id) init {
    self=[super init];
    if (self!=nil){
        BackgroundLayer *backgroundLayer=[BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        GamePlayLayer *gameplayLayer=[GamePlayLayer node];
        [self addChild:gameplayLayer z:5];
    }
    return self;
}
@end
