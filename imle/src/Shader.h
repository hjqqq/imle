//
//  Shader.h
//  imle
//
//  Created by Mark Lown on 8/10/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Shader : NSObject
{
    GLuint m_handle;
    GLuint m_vertShader;
    GLuint m_fragShader;
    GLuint m_positionSlot;
    GLuint m_colorSlot;
    GLuint m_normalSlot;
    GLuint m_textureSlot;
}

@property (nonatomic, assign) GLuint PositionSlot;
@property (nonatomic, assign) GLuint ColorSlot;
@property (nonatomic, assign) GLuint NormalSlot;
@property (nonatomic, assign) GLuint TextureSlot;
@property (nonatomic, assign) GLuint Handle;


- (id) initWithVS:(NSString *)vs FS:(NSString *)fs;
- (void) begin;
- (void) end;

@end
