//
//  ViewController.h
//  imle
//
//  Created by Mark Lown on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "Game.h"

@interface ViewController : GLKViewController
{
@private
    EAGLContext *m_context;
    Game *m_game;
}

@property (strong, nonatomic) EAGLContext *context;

@end
