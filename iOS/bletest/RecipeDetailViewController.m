//
//  RecipeDetailViewController.m
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import "RecipeDetailViewController.h"
#import "StepsViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
@synthesize titleName, ser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [recipeTitle setText:titleName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startAction:(id)sender {
    NSLog(@"start");
    StepsViewController *stepsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stepsVC"];
    stepsVC.steps = 5;
    [stepsVC connectService:ser];
    [self.navigationController pushViewController:stepsVC animated:YES];
    
}


@end
