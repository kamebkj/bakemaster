//
//  DiscoverViewController.h
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DiscoverViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate> {
    
    // from bletestVC
    CBCentralManager * manager;
    NSMutableArray   * peripherals;
    CBPeripheral * connected_peripheral;
    
//    __weak IBOutlet UILabel *managerState;
//    __weak IBOutlet UISwitch *scanSwitch;
    __weak IBOutlet UITableView *scanResult;
    
    // services
    NSDictionary * serviceNames;
    
}

@property (nonatomic, retain) CBPeripheral * peripheral;

- (void)centralManagerDidUpdateState:(CBCentralManager *)central;
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

//- (IBAction)scannerState:(id)sender;
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;

@end
