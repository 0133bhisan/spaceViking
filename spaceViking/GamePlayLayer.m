//
//  GamePlayLayer.m
//  spaceViking
//
//  Created by Aashish Karki on 1/9/14.
//  Copyright (c) 2014 Aashish Karki. All rights reserved.
//

#import "GamePlayLayer.h"

@implementation GamePlayLayer

-(void) initJoystickAndButtons{
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    
    CGRect joystickBaseDimensions=CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect jumpButtonDimensions= CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions=CGRectMake(0, 0, 64.0f, 64.0f);
    
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    joystickBasePosition=ccp(screenSize.width*0.07f, screenSize.height*0.11f);
    jumpButtonPosition=ccp(screenSize.width*0.93f, screenSize.height*0.11f);
    attackButtonPosition=ccp(screenSize.width*0.93f, screenSize.height*0.35f);
    
    SneakyJoystickSkinnedBase *joystickBase= [[[SneakyJoystickSkinnedBase alloc]init]autorelease];
    joystickBase.position=joystickBasePosition;
    joystickBase.backgroundSprite=[CCSprite spriteWithFile:@"dpadDown.png"];
    joystickBase.thumbSprite=[CCSprite spriteWithFile:@"joystickDown.png"];
    joystickBase.joystick=[[SneakyJoystick alloc]initWithRect:joystickBaseDimensions];
    
    leftJoystick=[joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase =[[[SneakyButtonSkinnedBase alloc]init]autorelease];
    jumpButtonBase.position=jumpButtonPosition;
    jumpButtonBase.defaultSprite=[CCSprite spriteWithFile:@"jumpUp.png"];
    jumpButtonBase.activatedSprite=[CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.pressSprite=[CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.button=[[SneakyButton alloc]initWithRect:jumpButtonDimensions];
    
    jumpButton=[jumpButtonBase.button retain];
    jumpButton.isToggleable=NO;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase=[[[SneakyButtonSkinnedBase alloc]init]autorelease];
    attackButtonBase.position=attackButtonPosition;
    attackButtonBase.defaultSprite=[CCSprite spriteWithFile:@"handUp.png"];
    attackButtonBase.activatedSprite=[CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.pressSprite=[CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.button=[[SneakyButton alloc] initWithRect:attackButtonDimensions];
    
    attackButton =[attackButtonBase.button retain];
    attackButton.isToggleable=NO;
    
    [self addChild:attackButtonBase];
    
}
-(void) applyJoystick:(SneakyJoystick *)aJoystick toNode:(CCNode *)tempNode
         forTimeDelta:(float) deltaTime{
    CGPoint scaledVelocity=ccpMult(aJoystick.velocity, 250.0f);
    
    CGPoint newPosition=ccp(tempNode.position.x+scaledVelocity.x*deltaTime,
                            tempNode.position.y);
    
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    if (newPosition.x>screenSize.width){
        newPosition.x=screenSize.width;}
    if (newPosition.x<0){
        newPosition.x=0;}
    
    
    [tempNode setPosition:newPosition];
    
    if (jumpButton.active==YES){
        CCLOG(@"jump button is pressed");
    }
    if (attackButton.active==YES){
        CCLOG(@"attack button is pressed");
    }
    
}

#pragma mark -
#pragma mark Update Method
-(void) update:(ccTime)deltaTime
{
    [self applyJoystick:leftJoystick toNode:vikingSprite forTimeDelta:deltaTime];
}


-(id) init{
    self=[super init];
    if (self!=nil){
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        self.TouchEnabled=YES;
        //vikingSprite =[CCSprite spriteWithFile:@"sv_anim_1.png"];
       
        CCSpriteBatchNode *chapter2SpriteBatchNode;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
        chapter2SpriteBatchNode= [CCSpriteBatchNode batchNodeWithFile:@"scene1atlasiPhone.png"];
        //[chapter2SpriteBatchNode setScale:2.0f];
        vikingSprite=[CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
        
        [chapter2SpriteBatchNode addChild:vikingSprite];
        
        
        [self addChild:chapter2SpriteBatchNode];

        [vikingSprite setPosition:CGPointMake(screenSize.width/2, screenSize.height*0.17f)];
        
        
        CCSprite *animatingRobot=[CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
        [animatingRobot setPosition:ccp([vikingSprite position].x+50.0f, [vikingSprite position].y)];
        [self addChild:animatingRobot];
  
        CCAnimation *robotAnim=[CCAnimation animation];
        [robotAnim addFrame:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_2.png"]];
        
        [robotAnim addFrame:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_3.png"]];

        [robotAnim addFrame:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_4.png"]];

        id robotAnimationAction=[CCAnimate actionWithDuration:0.25f animation: robotAnim restoreOriginalFrame:NO];
        id repeatRobotAnimation=[CCRepeatForever actionWithAction:robotAnimationAction];
        [animatingRobot runAction:repeatRobotAnimation];
        
     
        
        
        
        
        
        
        [self initJoystickAndButtons];
        [self scheduleUpdate];
        if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPad){
            [vikingSprite setScaleX:screenSize.width/1024.0f];
            [vikingSprite setScaleY:screenSize.height/768.0f];
        }
    }
    return self;
}

@end
