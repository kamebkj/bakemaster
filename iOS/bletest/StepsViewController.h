//
//  StepsViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>

@interface StepsViewController : UIViewController <UIScrollViewDelegate> {
    BOOL pageControlUsed;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic) NSInteger steps;

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

@end
