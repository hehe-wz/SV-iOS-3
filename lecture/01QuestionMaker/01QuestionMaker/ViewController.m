//
//  ViewController.m
//  01QuestionMaker
//
//  Created by Zun Wang on 11/3/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSArray *questionArray;
@property (nonatomic) NSArray *answerArray;
@property (nonatomic) NSUInteger index;
@end

@implementation ViewController

- (NSArray *)answerArray {
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    _questionArray = @[
                       @"Question1",
                       @"Question2",
                       @"Question3",
                       ];
    _answerArray = @[@"Answer1", @"Answer2", @"Answer3"];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self answerArray];
//  self.answerArray
  _answerArray
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)userTapQuestionButton:(UIButton *)sender {
  self.index = arc4random_uniform(3);
  NSString *questionString = [self.questionArray objectAtIndex:self.index];
  self.questionLabel.text = questionString;
}

- (IBAction)userTapAnswerButton:(UIButton *)sender {
  NSString *answerString = [self.answerArray objectAtIndex:self.index];
  self.answerLabel.text = answerString;
}

@end

//classA initWithNum1:(num1+1) withNum2:(num2+1)

@implementation ClassA

//d
- (instancetype)initWithNum1:(NSNumber *)num1 withNum2:(NSNumber *)num2 {
  if (self = [super init]) {
    _numa = num1;
    _numb = num2;
  }
  return self;
}

//c
- (instancetype)initWithA:(ClassA *)a {
  return [[ClassA alloc] initWithNum1:@(a.numa.integerValue + 1)
                             withNum2:@(a.numb.integerValue + 1)];
//  if (self = [ClassA alloc] initWithNum1:  withNum2:<#(NSNumber *)#>) {
//    _numa = @(a.numa.integerValue + 1);
//    _numb = @(a.numb.integerValue + 1);
//  }
//  return self;
  BOOL b = self.running;
  BOOL c = [self isRunning];
}





@end