//
//  Texture2.m
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import "Texture2.h"

@implementation Texture2

@synthesize Handle = m_handle;

- (void) dealloc
{
    glDeleteTextures(1, &m_handle);
    
    [super dealloc];
}

- (id) initWithTexturePath:(NSString *)path smooth:(bool)smooth
{
    self = [super init];
    if (self)
    {
        CGImageRef spriteImage = [UIImage imageNamed:path].CGImage;
        if (!spriteImage)
        {
            NSLog(@"Failed to load image %@", path);
            return nil;
        }
        
        size_t width = CGImageGetWidth(spriteImage);
        size_t height = CGImageGetHeight(spriteImage);
        
        GLubyte *spriteData = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
        
        CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
        
        CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
        CGContextRelease(spriteContext);
        
        glGenTextures(1, &m_handle);
        glBindTexture(GL_TEXTURE_2D, m_handle);
        
        if (!smooth)
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        else
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
        free(spriteData);
    }
    return self;
}

@end
