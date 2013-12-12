//
//  StepsViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface StepsViewController : UIViewController <UIScrollViewDelegate, CBPeripheralDelegate> {
    BOOL pageControlUsed;
    NSInteger steps;
    NSMutableArray *stepStatus;
    NSInteger remainTarget;
    
    // Characteristics
    CBCharacteristic *cr_characteristic;
    CBCharacteristic *pot_characteristic;
    CBCharacteristic *alert_characteristic;
    
    CBCharacteristic *acc_x_characteristic;
    CBCharacteristic *acc_y_characteristic;
    CBCharacteristic *acc_z_characteristic;
    
    CBCharacteristic *btn_play_characteristic;
    CBCharacteristic *btn_prev_characteristic;
    CBCharacteristic *btn_next_characteristic;
    
    CBCharacteristic *pot_rollmax_characteristic;
    
    BOOL firstLoad;
    NSInteger baseValue;
    
}
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
//@property (weak, nonatomic) IBOutlet UITextView *currentValue;
//@property (weak, nonatomic) IBOutlet UITextView *targetValue;
@property (weak, nonatomic) IBOutlet UILabel *currentValue;
@property (weak, nonatomic) IBOutlet UILabel *targetValue;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *colorBg;
@property (nonatomic, retain) NSMutableArray *viewControllers;

@property (retain, nonatomic) NSArray *stepArray;
@property (nonatomic) NSInteger recipeItem;

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)clickPlay:(id)sender;
- (IBAction)clickCancel:(id)sender;


// Characteristics
@property (nonatomic, retain) CBPeripheral * peripheral;

- (void)connectService:(CBService *)per;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

@end
