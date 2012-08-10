//
//  Spritebatch.h
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Vertex.h"

@class Sprite;
@class Shader;

@interface Spritebatch : NSObject
{
@private
    Shader *m_shader;
    bool m_began;
    GLuint m_vertexBuffer;
    GLuint m_indexBuffer;
    SVertex *m_vertices;
    GLubyte *m_indices;
    int m_spriteCount;
    NSMutableArray *m_sprites;
}

- (id) initWithShader:(Shader *)shader;
- (void) begin;
- (void) end;
- (void) drawSprite:(Sprite *)sprite;

@end
