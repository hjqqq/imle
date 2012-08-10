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
    m_vertices[0].position[0] = m_position.x + m_frame.size.width / 2;
    m_vertices[0].position[1] = m_position.y - m_frame.size.height / 2;
    m_vertices[0].position[2] = 1;
    m_vertices[0].color[0] = 1;
    m_vertices[0].color[1] = 1;
    m_vertices[0].color[2] = 1;
    m_vertices[0].color[3] = 1;
    
    m_vertices[1].position[0] = m_position.x + m_frame.size.width / 2;
    m_vertices[1].position[1] = m_position.y + m_frame.size.height / 2;
    m_vertices[1].position[2] = 1;
    m_vertices[1].color[0] = 1;
    m_vertices[1].color[1] = 1;
    m_vertices[1].color[2] = 1;
    m_vertices[1].color[3] = 1;
    
    m_vertices[2].position[0] = m_position.x - m_frame.size.width / 2;
    m_vertices[2].position[1] = m_position.y + m_frame.size.height / 2;
    m_vertices[2].position[2] = 1;
    m_vertices[2].color[0] = 1;
    m_vertices[2].color[1] = 1;
    m_vertices[2].color[2] = 1;
    m_vertices[2].color[3] = 1;
    
    m_vertices[3].position[0] = m_position.x - m_frame.size.width / 2;
    m_vertices[3].position[1] = m_position.y - m_frame.size.height / 2;
    m_vertices[3].position[2] = 1;
    m_vertices[3].color[0] = 1;
    m_vertices[3].color[1] = 1;
    m_vertices[3].color[2] = 1;
    m_vertices[3].color[3] = 1;
}

- (void) renderFrame
{
    // We don't render the sprite individually, you must use a SpriteBatch.
}


@end
