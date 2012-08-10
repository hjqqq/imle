//
//  Texture2.h
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Texture2 : NSObject
{
    GLuint m_handle;
}

@property (nonatomic, assign) GLuint Handle;

- (id) initWithTexturePath:(NSString *)path smooth:(bool)smooth;

@end
