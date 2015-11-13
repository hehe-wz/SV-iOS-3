//
//  AboutViewController.m
//  Bull's Eye Two
//
//  Created by Eric Huang on 11/10/15.
//  Copyright © 2015 Eric Huang. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
  NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
  NSURL *baseUrl = [NSURL fileURLWithPath:htmlFile];
  [_webView loadData:htmlData
            MIMEType:@"text/html"
    textEncodingName:@"UTF-8"
             baseURL:baseUrl];
  
}

-(IBAction)close {
  [self dismissViewControllerAnimated:YES
                           completion:nil];
}

@end
