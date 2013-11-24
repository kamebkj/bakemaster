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
    
    __weak IBOutlet UILabel *recipeTitle;
}


@property (retain, nonatomic) NSString *titleName;
@property (nonatomic, retain) CBService* ser;

- (IBAction)startAction:(id)sender;



@end
