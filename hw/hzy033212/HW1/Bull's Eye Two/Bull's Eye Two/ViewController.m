//
//  ViewController.m
//  Bull's Eye Two
//
//  Created by Eric Huang on 11/10/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
  
@end

@implementation ViewController

 long currentVal = 50;
 long targetVal = 0;
 long score = 0;
 long roundNum = 0;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
  [self updateLabels];
  
  UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
  [_slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
  
  UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
  [_slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
  
  UIEdgeInsets insets = { .top = 0, .left = 14, .bottom = 0, .right = 14 };
  
  UIImage *trackLeftImage = [UIImage imageNamed:@"SliderTrackLeft"];
  UIImage *trackLeftResizable = [trackLeftImage resizableImageWithCapInsets:insets];
  [_slider setMinimumTrackImage:trackLeftResizable forState:UIControlStateNormal];
  
  UIImage *trackRightImage = [UIImage imageNamed:@"SliderTrackRight"];
  UIImage *trackRightResizable = [trackRightImage resizableImageWithCapInsets:insets];
  [_slider setMaximumTrackImage:trackRightResizable forState:UIControlStateNormal];
  
}

- (IBAction)showAlert {
  
  long difference = labs(currentVal - targetVal);
  long points = 100 - difference;
  
  NSString *title;
  if (difference == 0) {
    title = @"Perfect!";
    points += 100;
  } else if (difference < 5) {
    title = @"You almost had it!";
    if (difference == 1) {
      points += 50;
    }
  } else if (difference < 10) {
    title = @"Pretty good!";
  } else {
    title = @"Not even close...";
  }
  
  score += points;
  
  NSString *message = [NSString stringWithFormat:@"You scored %ld points", points];
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
  // Note self should be claimed as weak before being used in block
  __weak ViewController *weakSelf = self;
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [weakSelf startNewRound];
    [weakSelf updateLabels];
  }];
  [alert addAction:action];
  [self presentViewController:alert animated:YES completion:nil];
  
//  [self startNewRound];
//  [self updateLabels];
}

-(IBAction)slideMoved: (UISlider*) slider {
  NSLog(@"The value of slider is now: %f", slider.value);
  currentVal = lroundf(slider.value);
}

-(IBAction)startOver {
  [self startNewGame];
  [self updateLabels];
  
  CATransition *transition = [[CATransition alloc] init];
  transition.type = kCATransitionFade;
  transition.duration = 1;
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

-(void)startNewRound {
  roundNum += 1;
  targetVal = 1 + arc4random_uniform(100);
  currentVal = 50;
  _slider.value = currentVal;
}

-(void)updateLabels {
  _targetLabel.text = [NSString stringWithFormat:@"%li", targetVal];
  _scoreLabel.text = [NSString stringWithFormat:@"%li", score];
  _roundLabel.text = [NSString stringWithFormat:@"%li", roundNum];
}

-(void)startNewGame {
  score = 0;
  roundNum  = 0;
  [self startNewRound];
}

@end
