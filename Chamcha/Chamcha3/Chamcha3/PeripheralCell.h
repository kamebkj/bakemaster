//
//  NSObject+PeripheralCell.h
//  Chamcha3
//
//  Created by Kate Hsiao on 12/6/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralCell : NSObject

@property (retain) CBPeripheral *peripheral;
@property (nonatomic, copy) NSNumber *rssi;

@end