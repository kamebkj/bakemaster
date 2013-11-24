//
//  RecipeDetailViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController {
    
    __weak IBOutlet UILabel *recipeTitle;
}


@property (retain, nonatomic) NSString *titleName;

- (IBAction)startAction:(id)sender;



@end
