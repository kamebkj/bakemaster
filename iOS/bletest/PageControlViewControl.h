//
//  PageControlViewControl.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>

@interface PageControlViewControl : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

@end
