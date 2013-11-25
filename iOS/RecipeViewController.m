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
    
    // Get recipes from recipe.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    recipeArray = [dict objectForKey:@"recipes"];
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
    return [recipeArray count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [recipeArray[indexPath.row] objectForKey:@"name"];
//    if (indexPath.row==0) cell.textLabel.text = @"Chocolate cake";
//    else if (indexPath.row==1) cell.textLabel.text = @"Banana cake";
//    else cell.textLabel.text = @"Almond cookie";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecipeDetailViewController * recipeDetailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"recipeDetailVC"];
    recipeDetailVC.recipeDetail = recipeArray[indexPath.row];
    recipeDetailVC.recipeItem = indexPath.row;
    recipeDetailVC.ser = ser;
    [self.navigationController pushViewController:recipeDetailVC animated:YES];
}

@end
