//
//  ViewController.m
//  AppSecurity
//
//  Created by MAC2 on 6/20/18.
//  Copyright © 2018 MAC2. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated
{
     BOOL hasTouchID = false;
    if([LAContext class])
    {
        LAContext *context = [LAContext new];
        NSError *error = nil;
        hasTouchID = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    }

    
    if (hasTouchID) {
        
        LAContext *myContext = [[LAContext alloc]init];
        NSError *authError = nil;
        NSString *myLocalizedReasonString = @"Touch ID Test to show Face ID working in custom app.";

        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"Success" sender:nil];
                });
            }
            else
            {
                
                                        switch (error.code) {
                                            case LAErrorSystemCancel:
                                                NSLog(@"Authentication was cancelled by the system.");
                                                exit(0);
                                            case LAErrorUserCancel:
                                                NSLog(@"Authentication was cancelled by the user.");
                                                exit(0);
                                            case LAErrorUserFallback:
                                                NSLog(@"User selected to enter custom password");
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                [self performSegueWithIdentifier:@"Success" sender:nil];
                                                                            });
                                                
                                        }

            }
            
        }];
        
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
