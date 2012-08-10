//
//  Game.m
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import "Game.h"

#import "Sprite.h"
#import "Spritebatch.h"
#import "Texture2.h"
#import "Shader.h"

@implementation Game

Shader *shader;
Spritebatch *spritebatch;
Sprite *glider;

- (void) dealloc
{
    spritebatch = nil;
    glider = nil;
    shader = nil;
    
    [shader release];
    [spritebatch release];
    [glider release];
    
    [super dealloc];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        // We can't do any OpenGL initialization yet because the context
        // has not been fully created. Instead we do this in a seperate 
        // function - (void) load.
    }
    return self;
}

- (void) load
{
    glDisable(GL_CULL_FACE);
    
    shader = [[Shader alloc] initWithVS:@"PositionColorVert" FS:@"PositionColorFrag"];
    if (shader == nil)
        exit(0);
    
    spritebatch = [[Spritebatch alloc] initWithShader:shader];
    
    Texture2 *texture = [[Texture2 alloc] initWithTexturePath:@"glider.png" smooth:NO];
    glider = [[Sprite alloc] initWithTexture:texture frame:CGRectMake(0.0f, 0.0f, 64.0f, 64.0f) position:GLKVector2Make(200.0f, 200.0f) boundingBox:CGRectMake(200.0f, 200.0f, 64.0f, 64.0f)];
}

- (void) updateFrame:(NSTimeInterval)frameTime
{
    [glider updateFrame];
}

- (void) renderFrame:(NSTimeInterval)frameTime
{
    //NSLog(@"%f", 1 / frameTime);
    
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [spritebatch begin];
    
    [spritebatch drawSprite:glider];
    
    [spritebatch end];
}

@end
