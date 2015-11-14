//
//  ViewController.m
//  ioshw1
//
//  Created by lindadai on 11/12/15.
//  Copyright © 2015 lindadai. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController{
    int currentSliderValue, targetValue, score, round;
}

@synthesize slider, targetLabel, scoreLabel, roundLabel;


- (IBAction)HitmeButton:(UIButton *)sender {
    
    int difference;
    difference = abs(currentSliderValue - targetValue);
    
    int points;
    points = 100 - difference;
    
    NSString* title;
    if (difference == 0) {
        title = [NSString stringWithFormat:@"Perfect!"];
        points += 100;
    }else if(difference < 25){
        title = [NSString stringWithFormat:@"Not bad!"];
        points += 10;
    }else{
        title = [NSString stringWithFormat:@"Try harder!"];
        points *= -1;
    }
    
    
    NSString* msg = [NSString stringWithFormat:@"%d Points", points];
    score += points;
    
    UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:title
                           message:msg
                           delegate:self
                           cancelButtonTitle:@"Ok"
                           otherButtonTitles: nil
                           ];
    [alert show];
    
}
- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self startNewRound];
}
- (void)startNewRound{
    currentSliderValue = 50;
    self.slider.value = lroundf(currentSliderValue);
    targetValue = 1 + (arc4random() % 100);
    round += 1;
    [self updateLabels];
    
}

- (IBAction)restart:(UIButton *)sender {
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self startNewGame];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)updateLabels{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}
- (IBAction)slide:(UISlider *)sender {
    
    currentSliderValue = slider.value;
    
}

-(void)startNewGame{
    round = 0;
    score = 0;
    [self startNewRound];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage* sliderThumbNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    UIImage* sliderTrackLeft = [UIImage imageNamed:@"SliderTrackLeft"];
    UIImage* sliderTrackRight = [UIImage imageNamed:@"SliderTrackRight"];
    UIImage* sliderThumbHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    
    
    [self.slider setThumbImage:sliderThumbNormal forState:UIControlStateNormal];
    [self.slider setMinimumTrackImage:sliderTrackLeft forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:sliderTrackRight forState:UIControlStateNormal];
    [self startNewGame];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
