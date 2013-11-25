//
//  PageControlViewControl.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>

@interface PageControlViewControl : UIViewController {
    IBOutlet UILabel *stepLabel;
    IBOutlet UIImageView *imageView;
//    IBOutlet UITextView *amountTextView;
    IBOutlet UITextView *descriptionTextView;
    
    int pageNumber;
}

@property (nonatomic) NSInteger recipeItem;

- (id)initWithPageNumber:(int)page;

@end
