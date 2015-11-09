//
//  InfiniteCircleView.m
//  InfiniteCircle
//
//  Created by Zun Wang on 11/7/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "InfiniteCircleView.h"

@interface InfiniteCircleView ()
@property (nonatomic, strong) UIColor *strokeColor;
@end

@implementation InfiniteCircleView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];
    _strokeColor = [UIColor yellowColor];
  }
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  
  CGPoint centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
  double maxRadius = hypot(rect.size.width, rect.size.height) / 2;
  
  UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                      radius:maxRadius
                                                  startAngle:0
                                                    endAngle:M_PI * 2
                                                   clockwise:YES];
  
  for (double radius = maxRadius - 20; radius >= 0; radius -= 20) {
    [path moveToPoint:CGPointMake(centerPoint.x + radius, centerPoint.y)];
    [path addArcWithCenter:centerPoint
                    radius:radius
                startAngle:0
                  endAngle:M_PI * 2
                 clockwise:YES];
  }
  
  path.lineWidth = 10;
//  [[UIColor yellowColor] setStroke];
  [self.strokeColor setStroke];
  [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  CGFloat red = arc4random() % 100 / 100.0;
  CGFloat green = arc4random() % 100 / 100.0;
  CGFloat blue = arc4random() % 100 / 100.0;
  
  self.strokeColor = [[UIColor alloc] initWithRed:red
                                            green:green
                                             blue:blue
                                            alpha:1];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
  _strokeColor = strokeColor;
  //redraw
  [self setNeedsDisplay];
}

@end
