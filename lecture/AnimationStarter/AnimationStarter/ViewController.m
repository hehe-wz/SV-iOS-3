//
//  ViewController.m
//  AnimationStarter
//
//  Created by Zun Wang on 12/4/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ViewController {
  UIImageView *_statusView;
  UILabel *_stepLabel;
  NSArray *_messages;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _statusView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
  _statusView.hidden = YES;
  [self.view addSubview:_statusView];
  
  _stepLabel = [[UILabel alloc] initWithFrame:_statusView.bounds];
  _stepLabel.textColor = [UIColor brownColor];
  _stepLabel.textAlignment = NSTextAlignmentCenter;
  [_statusView addSubview:_stepLabel];
  
  _messages = @[@"Step 1",
                @"Step 2",
                @"Step 3",
                ];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  const CGFloat viewWidth = self.view.bounds.size.width;
  
//  _header.center = (CGPoint){- viewWidth / 2, _header.center.y};
//  _usernameTextField.center = (CGPoint){- viewWidth / 2, _usernameTextField.center.y};
  
  _passwordTextField.center = (CGPoint){- viewWidth / 2, _passwordTextField.center.y};
  _statusView.center = _loginButton.center;
  _loginButton.center = (CGPoint){_loginButton.center.x, _loginButton.center.y + 60};
}

- (void)viewDidAppear:(BOOL)animated {
  const CGFloat viewWidth = self.view.bounds.size.width;
  
  CABasicAnimation *flyFromLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
  flyFromLeft.fromValue = @(- viewWidth / 2);
  flyFromLeft.toValue = @(viewWidth / 2);
  flyFromLeft.duration = 0.5;
  flyFromLeft.fillMode = kCAFillModeBoth;
//  flyFromLeft.removedOnCompletion = NO;
  
  [_header.layer addAnimation:flyFromLeft forKey:nil];
  
  flyFromLeft.beginTime = CACurrentMediaTime() + 0.3;
  [_usernameTextField.layer addAnimation:flyFromLeft forKey:nil];
  
  // header animation
//  [UIView animateWithDuration:0.5
//                   animations:^{
//                     _header.center = (CGPoint){viewWidth / 2, _header.center.y};
//                   }];
  
  // text field animation
//  [UIView animateWithDuration:0.5
//                        delay:0.3
//                      options:UIViewAnimationOptionCurveEaseInOut// | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
//                   animations:^{
//                     _usernameTextField.center = (CGPoint){viewWidth / 2, _usernameTextField.center.y};
//                   }
//                   completion:nil];
  
  [UIView animateWithDuration:0.5
                        delay:0.4
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     _passwordTextField.center = (CGPoint){viewWidth / 2, _passwordTextField.center.y};
                   }
                   completion:nil];
  
  [UIView animateWithDuration:0.5
                        delay:0.5
       usingSpringWithDamping:0.5
        initialSpringVelocity:0
                      options:0
                   animations:^{
                     _loginButton.center = (CGPoint){_loginButton.center.x, _loginButton.center.y - 60};
                   }
                   completion:nil];
}

- (IBAction)userTapLoginButton:(UIButton *)sender {
  __weak ViewController *weakSelf = self;
  [UIView animateKeyframesWithDuration:0.7
                                 delay:0
                               options:UIViewKeyframeAnimationOptionCalculationModeLinear
                            animations:^ {
                              [UIView addKeyframeWithRelativeStartTime:0
                                                      relativeDuration:0.3
                                                            animations:^ {
                                                              _loginButton.center = (CGPoint){_loginButton.center.x, _loginButton.center.y + 60};
                                                            }];
                              [UIView addKeyframeWithRelativeStartTime:0.3
                                                      relativeDuration:0.7
                                                            animations:^ {
                                                              _loginButton.frame = CGRectMake(_loginButton.frame.origin.x - 30,
                                                                                              _loginButton.frame.origin.y,
                                                                                              _loginButton.frame.size.width + 60,
                                                                                              _loginButton.frame.size.height);
                                                            }];
                              
                            }
                            completion:^(BOOL finished) {
                              [weakSelf showMessageWithIndex:0];
                            }];
}

- (void)showMessageWithIndex:(NSInteger)index {
  if (index < _messages.count) {
    _stepLabel.text = _messages[index];
    
    __weak ViewController *weakSelf = self;
    [UIView transitionWithView:_statusView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                      _statusView.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                      [weakSelf removeMessageWithIndex:index];
                    }];
  } else {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       _loginButton.frame = CGRectMake(_loginButton.frame.origin.x + 30,
                                                       _loginButton.frame.origin.y - 60,
                                                       _loginButton.frame.size.width - 60,
                                                       _loginButton.frame.size.height);
                     }
                     completion:nil];
  }
}

- (void)removeMessageWithIndex:(NSInteger)index {
  __weak ViewController *weakSelf = self;
  [UIView transitionWithView:_statusView
                    duration:0.5
                     options:UIViewAnimationOptionTransitionCurlUp
                  animations:^{
                    _statusView.hidden = YES;
                  }
                  completion:^(BOOL finished) {
                    [weakSelf showMessageWithIndex:index + 1];
                  }];
}

@end
