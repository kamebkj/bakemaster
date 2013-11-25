//
//  RecipeDetailViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface RecipeDetailViewController : UIViewController {
    
    IBOutlet UILabel *recipeTitle;
    IBOutlet UIImageView *recipeImage;
    IBOutlet UITextView *recipeDescription;
}


@property (retain, nonatomic) NSDictionary *recipeDetail;
@property (nonatomic) NSInteger recipeItem;
@property (nonatomic, retain) CBService* ser;

- (IBAction)startAction:(id)sender;



@end
