//
//  Shader.m
//  imle
//
//  Created by Mark Lown on 8/10/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import "Shader.h"

@implementation Shader

@synthesize PositionSlot = m_positionSlot;
@synthesize ColorSlot = m_colorSlot;
@synthesize NormalSlot = m_normalSlot;
@synthesize TextureSlot = m_textureSlot;

- (void) dealloc
{
    [self unbind];
    
    glDeleteShader(m_vertShader);
    glDeleteShader(m_fragShader);
    glDeleteProgram(m_handle);
    
    [super dealloc];
}

- (id) initWithVS:(NSString *)vs FS:(NSString *)fs
{
    self = [super init];
    if (self)
    {
        NSString *vsPath = [[NSBundle mainBundle] pathForResource:vs ofType:@"glsl"];
        NSString *vsStr = [NSString stringWithContentsOfFile:vsPath encoding:NSUTF8StringEncoding error:nil];
        if (!vsStr)
            return nil;
        
        NSString *fsPath = [[NSBundle mainBundle] pathForResource:fs ofType:@"glsl"];
        NSString *fsStr = [NSString stringWithContentsOfFile:fsPath encoding:NSUTF8StringEncoding error:nil];
        if (!fsStr)
            return nil;
        
        m_vertShader = glCreateShader(GL_VERTEX_SHADER);
        m_fragShader = glCreateShader(GL_FRAGMENT_SHADER);
        
        const char *vsStrUTF8 = [vsStr UTF8String];
        const char *fsStrUTF8 = [fsStr UTF8String];
        int vsL = [vsStr length];
        int fsL = [fsStr length];
        glShaderSource(m_vertShader, 1, &vsStrUTF8, &vsL);
        glShaderSource(m_fragShader, 1, &fsStrUTF8, &fsL);
        
        glCompileShader(m_vertShader);
        glCompileShader(m_fragShader);
        
        GLint stt;
        
        glGetShaderiv(m_vertShader, GL_COMPILE_STATUS, &stt);
        if (stt == GL_FALSE)
            return nil;
        
        glGetShaderiv(m_fragShader, GL_COMPILE_STATUS, &stt);
        if (stt == GL_FALSE)
            return nil;
        
        m_handle = glCreateProgram();
        glAttachShader(m_handle, m_vertShader);
        glAttachShader(m_handle, m_fragShader);
        glLinkProgram(m_handle);
        
        glGetProgramiv(m_handle, GL_LINK_STATUS, &stt);
        if (stt == GL_FALSE)
            return nil;
        
        glUseProgram(m_handle);
        
        m_positionSlot = glGetAttribLocation(m_handle, "Position");
        m_colorSlot = glGetAttribLocation(m_handle, "Color");
        m_normalSlot = glGetAttribLocation(m_handle, "Normal");
        m_textureSlot = glGetAttribLocation(m_handle, "Texture");
    }
    return self;
}

- (void) begin
{
    glUseProgram(m_handle);
}

- (void) end
{
    glUseProgram(0);
}

@end
