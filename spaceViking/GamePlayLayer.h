//
//  GamePlayLayer.h
//  spaceViking
//
//  Created by Aashish Karki on 1/9/14.
//  Copyright (c) 2014 Aashish Karki. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"

@interface GamePlayLayer : CCLayer{
    CCSprite *vikingSprite;
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
}

@end
