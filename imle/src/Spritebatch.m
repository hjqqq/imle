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
    
    // Bind the buffer and push data to the GPU
    glBindBuffer(GL_ARRAY_BUFFER, m_vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, m_spriteCount * 4 * sizeof(SVertex), m_vertices, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, m_spriteCount * 6 * sizeof(GLubyte), m_indices, GL_STATIC_DRAW);
    
    // Configure the viewport
    glViewport(0, 0, 768, 1024);
    
    // Enable the shader
    [m_shader begin];
    
    // Set the projection matrix
    m_shader.ProjectionSlot = glGetUniformLocation(m_shader.Handle, "Projection");
    GLKMatrix4 projection = GLKMatrix4MakeOrtho(0, 768, 0, 1024, -100, 100);
    glUniformMatrix4fv(m_shader.ProjectionSlot, 1, 0, projection.m);
    
    // Set the attribute positions
    m_shader.PositionSlot = glGetAttribLocation(m_shader.Handle, "Position");
    m_shader.ColorSlot = glGetAttribLocation(m_shader.Handle, "Color");
    glVertexAttribPointer(m_shader.PositionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(SVertex), 0);
    glVertexAttribPointer(m_shader.ColorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(SVertex), (GLvoid *)(sizeof(sizeof(float) * 3)));
    
    // Send the draw call to the GPU
    glDrawElements(GL_TRIANGLES, m_spriteCount * 6, GL_UNSIGNED_BYTE, 0);
    
    // Disable the shader
    [m_shader end];
}

- (void) drawSprite:(Sprite *)sprite
{
    if (!m_began)
        return;
    
    // We don't draw anything here, instead we add this sprite's vertices
    // to the current batch which will get drawn with the call the Spritebatch::end
    
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
    
    //NSLog(@"%f, %f", sprite.Vertices[3].position[0], sprite.Vertices[3].position[1]);
}

@end
