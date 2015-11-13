//
//  ViewController.m
//  techbowA1objC
//
//  Created by ZhangZehua on 11/12/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSInteger currentValue;
@property (nonatomic) NSInteger targetValue;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger round;


@end

@implementation ViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        _currentValue = 50;
//        _targetValue = 0;
//        _score = 0;
//        _round = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self startNewGame];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [_slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [_slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 14, 0, 14);
    
    UIImage *trackLeftImage = [UIImage imageNamed:@"SliderTrackLeft"];
    UIImage *trackRightImage = [UIImage imageNamed:@"SliderTrackRight"];
    if (trackLeftImage != nil) {
        UIImage *trackLeftResizable = [trackLeftImage resizableImageWithCapInsets:insets];
        [_slider setMinimumTrackImage:trackLeftResizable forState:UIControlStateNormal];
    }
    if (trackRightImage != nil) {
        UIImage *trackRightResizable = [trackRightImage resizableImageWithCapInsets:insets];
        [_slider setMaximumTrackImage:trackRightResizable forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) startOver:(UIButton *)sender {
    [self startNewGame];
    [self updateLabels];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.view.layer addAnimation:transition forKey: nil];
    
}

- (IBAction) showAlert {
    NSInteger difference = (NSInteger) labs(_targetValue - _currentValue);
    NSInteger points = 100 - difference;
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
    
    _score += points;
    
    NSString *message = [NSString stringWithFormat:@"You scored %ld points", (long)points];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        [self startNewRound];
        [self updateLabels];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:true completion:nil];
}

- (IBAction)sliderMoved:(UISlider *)sender {
    _currentValue = lroundf(sender.value);
}

- (void) startNewRound {
    _round++;
    _targetValue = 1 + (NSInteger) arc4random_uniform(100);
    _currentValue = 50;
    _slider.value = (float) _currentValue;
}

- (void) startNewGame {
    _score = 0;
    _round = 0;
    [self startNewRound];
}

- (void) updateLabels {
    _targetLabel.text = [@(_targetValue) stringValue];
    _scoreLabel.text = [@(_score) stringValue];
    _roundLabel.text = [@(_round) stringValue];
}

@end
