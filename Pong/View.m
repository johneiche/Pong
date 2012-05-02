//
//  View.m
//  Pong
//
//  Created by NYU User on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor greenColor];

		//Create the paddle.
		frame = CGRectMake(40, 100, 20, 100);
		paddle = [[UIView alloc] initWithFrame: frame];
		paddle.backgroundColor = [UIColor whiteColor];
		[self addSubview: paddle];

		//Create the ball in the upper left corner of this View.
		frame = CGRectMake(0, 0, 20, 20);
		ball = [[UIView alloc] initWithFrame: frame];
		ball.backgroundColor = [UIColor whiteColor];
		[self addSubview: ball];

		//Ball initially moves to lower right.
		dx = 2;
		dy = 2;
	}
	return self;
}

//Change the ball's direction of motion,
//if necessary to avoid an impending collision.

- (void) bounce {	
	//Where the ball would be if its horizontal motion were allowed
	//to continue for one more move.
	CGRect horizontal = ball.frame;
	horizontal.origin.x += dx;
	
	//Where the ball would be if its vertical motion were allowed
	//to continue for one more move.
	CGRect vertical = ball.frame;
	vertical.origin.y += dy;
	
	//Ball must remain inside self.bounds.
	if (!CGRectEqualToRect(horizontal, CGRectIntersection(horizontal, self.bounds))) {
		//Ball will bounce off left or right edge of View.
		dx = -dx;
	}
	
	if (!CGRectEqualToRect(vertical, CGRectIntersection(vertical, self.bounds))) {
		//Ball will bounce off top or bottom edge of View.
		dy = -dy;
	}
	
	//If the ball is not currently intersecting the paddle,
	if (!CGRectIntersectsRect(ball.frame, paddle.frame)) {
		
		//but if the ball will intersect the paddle on the next move,
		if (CGRectIntersectsRect(horizontal, paddle.frame)) {
			dx = -dx;
		}
		
		if (CGRectIntersectsRect(vertical, paddle.frame)) {
			dy = -dy;
		}
	}
}

- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
	UITouch *touch = [touches anyObject];
	CGPoint p = [touch locationInView: self];
	CGFloat y = p.y;
	
	//Don't let the paddle move off the bottom or top of the View.
	CGFloat half = paddle.bounds.size.height / 2;
	y = MIN(y, self.bounds.size.height - half); //don't let y get too big
	y = MAX(y, half);                         //don't let y get too small
	
	paddle.center = CGPointMake(paddle.center.x, y);
	[self bounce];
}

- (void) move: (CADisplayLink *) displayLink {
	//NSLog(@"%.15g", displayLink.timestamp);	//15 significant digits
	
	ball.center = CGPointMake(ball.center.x + dx, ball.center.y + dy);
	[self bounce];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
	// Drawing code
}
*/

@end
