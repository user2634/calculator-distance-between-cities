//
//  ViewController.m
//  FourthApp
//
//  Created by Dava on 25.05.2020.
//  Copyright © 2020 David Dahina. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()
@property (nonatomic) DGDistanceRequest * req;
@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UITextField *endLocationD;
@property (weak, nonatomic) IBOutlet UILabel *distanceD;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end

@implementation ViewController

- (IBAction)buttonAction:(id)sender {
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    NSString* start = self.startLocation.text;
    NSString * disA = self.endLocationA.text;
    NSString * disB = self.endLocationB.text;
    NSString * disC = self.endLocationC.text;
    NSString * disD = self.endLocationD.text;
    NSArray * dests = @[disA,disB,disC,disD];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    __weak ViewController * weakSelf = self;
    
     
    self.req.callback = ^(NSArray * responses) {
        ViewController * strongSelf = weakSelf;
         if(!strongSelf)return;
        NSNull *badResult = [NSNull null];
           if (responses[0] != badResult){
               double num = ([responses[0] floatValue]/1000.0);
               NSString *x = [NSString stringWithFormat: @"%.2f km",num];
               strongSelf.distanceA.text = x;
           }else{
               strongSelf.distanceA.text = @"Error";
           }
        if (responses[1] != badResult){
            double num = ([responses[1] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat: @"%.2f km",num];
            strongSelf.distanceB.text = x;
        }else{
            strongSelf.distanceB.text = @"Error";
        }
        if (responses[2] != badResult){
            double num = ([responses[2] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat: @"%.2f km",num];
            strongSelf.distanceC.text = x;
        }else{
            strongSelf.distanceC.text = @"Error";
        }
        if (responses[3] != badResult){
            double num = ([responses[2] floatValue]/1000.0);
            NSString *x = [NSString stringWithFormat: @"%.2f km",num];
            strongSelf.distanceD.text = x;
        }else{
            strongSelf.distanceD.text = @"Error";
        }
        

        self.req = nil;
        self.calculateButton.enabled = YES;
    };
    [self.req start];
}



@end
