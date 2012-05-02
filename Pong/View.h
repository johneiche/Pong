//
//  View.h
//  Pong
//
//  Created by NYU User on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View: UIView {
	UIView *paddle;
	UIView *ball;
	CGFloat dx, dy;	//direction and speed of ball's motion
}

- (void) move: (CADisplayLink *) displayLink;
@end
