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
    
    __weak IBOutlet UITextView *helloText;
    __weak IBOutlet UITextView *textRx;
    __weak IBOutlet UITextView *textAcceX;
    __weak IBOutlet UITextView *textAcceY;
    __weak IBOutlet UITextView *textAcceZ;
    __weak IBOutlet UITextView *textBtnPlay;
    __weak IBOutlet UITextView *textBtnPrev;
    __weak IBOutlet UITextView *textBtnNext;
    
//    BOOL isOpen;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic) NSInteger steps;

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

// Characteristics

@property (nonatomic, retain) CBPeripheral * peripheral;

- (void)connectService:(CBService *)per;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
//
//- (IBAction)openButton:(id)sender;
//- (IBAction)closeButton:(id)sender;
@end
