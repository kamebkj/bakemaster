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
@synthesize pageNumberLabel;

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
    
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    //self.view.backgroundColor = [PageControlViewControl pageControlColorWithIndex:pageNumber];
}

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"PageControlViewControl" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}



@end
