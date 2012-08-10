//
//  Spritebatch.m
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import "Spritebatch.h"
#import "Sprite.h"
#import "Shader.h"
#import <GLKit/GLKit.h>

@implementation Spritebatch

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithShader:(Shader *)shader
{
    self = [super init];
    if (self)
    {
        m_shader = shader;
        m_began = NO;
        
        // Make space for 1000 Sprites max
        m_vertices = (SVertex *)malloc(4 * 1000 * sizeof(SVertex));
        m_indices = (GLubyte *)malloc(6 * 1000 * sizeof(GLubyte));
        
        m_spriteCount = 0;
        
        glGenBuffers(1, &m_vertexBuffer);
        glGenBuffers(1, &m_indexBuffer);
        
    }
    return self;
}

- (void) begin
{
    m_began = YES;
    m_spriteCount = 0;
}

- (void) end
{
    if (!m_began)
        return;
    
    glBindBuffer(GL_ARRAY_BUFFER, m_vertexBuffer);
    glBufferData(m_vertexBuffer, m_spriteCount * sizeof(SVertex), m_vertices, GL_DYNAMIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_indexBuffer);
    glBufferData(m_indexBuffer, m_spriteCount * 6 * sizeof(GLubyte), m_indices, GL_DYNAMIC_DRAW);
    
    [m_shader begin];
    
    glVertexAttribPointer(m_shader.PositionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(SVertex), 0);
    glVertexAttribPointer(m_shader.ColorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(SVertex), (GLvoid *)(sizeof(sizeof(float) * 3)));
    
    glDrawElements(GL_TRIANGLES, m_spriteCount * 6, GL_UNSIGNED_BYTE, 0);
    
    [m_shader end];
}

- (void) drawSprite:(Sprite *)sprite
{
    if (!m_began)
        return;
    
    m_vertices[m_spriteCount + 0] = sprite.Vertices[0];
    m_vertices[m_spriteCount + 1] = sprite.Vertices[1];
    m_vertices[m_spriteCount + 2] = sprite.Vertices[2];
    m_vertices[m_spriteCount + 3] = sprite.Vertices[3];
    
    m_indices[m_spriteCount + 0] = 4 * m_spriteCount + 0;
    m_indices[m_spriteCount + 1] = 4 * m_spriteCount + 1;
    m_indices[m_spriteCount + 2] = 4 * m_spriteCount + 2;
    m_indices[m_spriteCount + 3] = 4 * m_spriteCount + 2;
    m_indices[m_spriteCount + 4] = 4 * m_spriteCount + 3;
    m_indices[m_spriteCount + 5] = 4 * m_spriteCount + 0;
    
    m_spriteCount++;
}

@end
