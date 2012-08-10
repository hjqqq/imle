//
//  Game.h
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 Full Nelson Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Game : NSObject
{
    
}

- (void) load;
- (void) updateFrame:(NSTimeInterval)frameTime;
- (void) renderFrame:(NSTimeInterval)frameTime;

@end
