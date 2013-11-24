//
// Bluegiga’s Bluetooth Smart Demo Application SW for iPhone 4S
// This SW is showing how to iPhone 4S can interact with Bluegiga Bluetooth
// Smart components like BLE112.
// Contact: support@bluegiga.com.
//
// This is free software distributed under the terms of the MIT license reproduced below.
//
// Copyright (c) 2012, Bluegiga Technologies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
//


#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CRViewController : UIViewController<CBPeripheralDelegate>
{
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
    
    
    BOOL isOpen;
}
@property (nonatomic, retain) CBPeripheral * peripheral;

- (void)connectService:(CBService *)per;
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

- (IBAction)openButton:(id)sender;
- (IBAction)closeButton:(id)sender;

@end
