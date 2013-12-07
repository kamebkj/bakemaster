//
//  PageControlViewControl.m
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import "PageControlViewControl.h"

@interface PageControlViewControl ()

@end

@implementation PageControlViewControl
@synthesize recipeItem;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *recipeArray = [dict objectForKey:@"recipes"];
    NSDictionary *item = recipeArray[recipeItem];
    NSArray *stepsArray = [item objectForKey:@"steps"];
    NSDictionary *stepDict = stepsArray[pageNumber];
    
//    stepLabel.text = [NSString stringWithFormat:@"Step %d", pageNumber + 1];
    //    amountTextView.text = [stepDict objectForKey:@"amount"];
    descriptionTextView.text = [stepDict objectForKey:@"description"];
    [imageView setImage:[UIImage imageNamed:[stepDict objectForKey:@"image"]]];
    
}

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"PageControlViewControl" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}



@end
