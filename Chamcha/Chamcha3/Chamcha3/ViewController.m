//
//  ViewController.m
//  Chamcha3
//
//  Created by Kate Hsiao on 12/6/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickItem:(id)sender {
    NSLog(@"d");
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
