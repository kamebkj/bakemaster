//
//  DetailViewController.h
//  Chamcha3
//
//  Created by Kate Hsiao on 12/6/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DetailViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate> {
    // from bletestVC
    CBCentralManager * manager;
    NSMutableArray   * peripherals;
    CBPeripheral * connected_peripheral;
    Boolean bleReady;
    
    // services
    NSDictionary * serviceNames;
}



@property (weak, nonatomic) IBOutlet UIView *indicatorOverlay;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, retain) CBPeripheral * peripheral;

- (void)centralManagerDidUpdateState:(CBCentralManager *)central;
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;


// Button clicks
- (IBAction)clickBack:(id)sender;
- (IBAction)clickStart:(id)sender;

@end
