//
//  RecipeViewController.m
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import "RecipeViewController.h"
#import "RecipeDetailViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController
@synthesize ser;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0) cell.textLabel.text = @"Chocolate cake";
    else if (indexPath.row==1) cell.textLabel.text = @"Banana cake";
    else cell.textLabel.text = @"Almond cookie";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecipeDetailViewController * recipeDetailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"recipeDetailVC"];
    recipeDetailVC.titleName = [NSString stringWithFormat:@"%d", indexPath.row];
    recipeDetailVC.ser = ser;
    [self.navigationController pushViewController:recipeDetailVC animated:YES];
    
    
//    if (indexPath.row==0) {
//        
//    }
//    else if (indexPath.row==1) {
//        
//    }
//    else {
//        
//    }
    
}

@end
