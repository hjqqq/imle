//
//  Sprite.m
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize Texture = m_texture;
@synthesize Position = m_position;
@synthesize Frame = m_frame;
@synthesize BoundingBox = m_boundingBox;
@synthesize Vertices = m_vertices;

- (void) dealloc
{
    free(m_vertices);
    [super dealloc];
}

- (id) initWithTexture:(Texture2 *)texture frame:(CGRect)frame position:(GLKVector2)pos boundingBox:(CGRect)box
{
    self = [super init];
    if (self)
    {
        m_texture = texture;
        m_frame = frame;
        m_position = pos;
        m_boundingBox = box;
        
        m_vertices = (SVertex *)malloc(sizeof(SVertex) * 4);
    }
    return self;
}

- (void) updateFrame
{
    // Update the location of the bounding box
    m_boundingBox.origin.x = m_position.x;
    m_boundingBox.origin.y = m_position.y;
    
    // Update the vertex positions
    // We do this here instead of using a ModelView matrix in order to facilitate sprite batching
    
}

- (void) renderFrame
{
    // We don't render the sprite individually, you must use a SpriteBatch.
}


@end
