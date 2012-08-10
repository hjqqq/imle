//
//  Sprite.h
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Vertex.h"

@class Texture2;

@interface Sprite : NSObject
{
@private
    // The texture
    Texture2 *m_texture;
    // The position of the the center of the sprite
    GLKVector2 m_position;
    // The frame to render within the texture. 
    CGRect m_frame;
    // The bounding box used for collisions.
    CGRect m_boundingBox;
    // The vertex array
    SVertex *m_vertices;
}

@property (nonatomic, retain) Texture2 *Texture;
@property (nonatomic, assign) GLKVector2 Position;
@property (nonatomic, assign) CGRect Frame;
@property (nonatomic, assign) CGRect BoundingBox;
@property (readonly, assign) SVertex *Vertices;


- (id) initWithTexture:(Texture2 *)texture frame:(CGRect)frame position:(GLKVector2)pos boundingBox:(CGRect)box;
- (void) updateFrame;
- (void) renderFrame;

@end
