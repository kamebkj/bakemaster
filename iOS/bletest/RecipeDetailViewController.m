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
@synthesize recipeDetail, recipeItem, ser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [recipeTitle setText:[recipeDetail objectForKey:@"name"]];
    [recipeDescription setText:[recipeDetail objectForKey:@"description"]];
    [recipeImage setImage:[UIImage imageNamed:[recipeDetail objectForKey:@"image"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startAction:(id)sender {
    NSArray *steps = [recipeDetail objectForKey:@"steps"];
    
    NSLog(@"start");
    StepsViewController *stepsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stepsVC"];
    stepsVC.recipeItem = recipeItem;
    stepsVC.stepArray = steps;
    
    [stepsVC connectService:ser];
    [self.navigationController pushViewController:stepsVC animated:YES];
    
}


@end
