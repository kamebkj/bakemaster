//
//  RecipeViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface RecipeViewController : UITableViewController {
//    NSDictionary *recipeDict;
    NSArray *recipeArray;
}

@property (nonatomic, retain) CBService* ser;


@end
