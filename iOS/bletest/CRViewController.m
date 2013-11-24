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


#include <string.h>
#import "CRViewController.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>

@implementation CRViewController
@synthesize peripheral = _peripheral;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isOpen = YES;
}
- (void)viewDidUnload
{
    helloText = nil;
    textRx = nil;
    textAcceX = nil;
    textAcceY = nil;
    textAcceZ = nil;
    textBtnPlay = nil;
    textBtnNext = nil;
    textBtnPrev = nil;

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)connectService:(CBService *)ser
{
    _peripheral=ser.peripheral;
    cr_characteristic=nil;
    pot_characteristic=nil;
    alert_characteristic=nil;
    acc_x_characteristic = nil;
    acc_y_characteristic = nil;
    acc_z_characteristic = nil;
    btn_play_characteristic = nil;
    btn_prev_characteristic = nil;
    btn_next_characteristic = nil;
    
    [_peripheral setDelegate:self];
    
    // 1,2: weight, ?
    // 3,4,5: x,y,z
    // 6,7,8: play,prev,next
    [_peripheral discoverCharacteristics:[NSArray arrayWithObjects:
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97651"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97652"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97653"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97654"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97655"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97656"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97657"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97658"],nil] forService:ser];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if(error != nil)
    {
        //TODO: handle error
        return;
    }
    
    NSEnumerator *e = [service.characteristics objectEnumerator];
    for (int i=0; i<8; i++) {
        if ( (cr_characteristic = [e nextObject]) ) {
            if (i==0) {
                pot_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: pot_characteristic];
            }
            else if (i==1) {
                alert_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: alert_characteristic];
            }
            else if (i==2) {
                acc_x_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: acc_x_characteristic];
            }
            else if (i==3) {
                acc_y_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: acc_y_characteristic];
            }
            else if (i==4) {
                acc_z_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: acc_z_characteristic];
            }
            else if (i==5) {
                btn_play_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: btn_play_characteristic];
            }
            else if (i==6) {
                btn_prev_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: btn_prev_characteristic];
            }
            else if (i==7) {
                btn_next_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: btn_next_characteristic];
            }
    
        }
    }
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if(error != nil)
    {
        //TODO: handle error
        return;
    }
    
    NSEnumerator *e = [_peripheral.services objectEnumerator];
    CBService * service;
    
    while ( (service = [e nextObject]) ) {
        [_peripheral discoverCharacteristics:[NSArray arrayWithObjects:
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97651"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97652"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97653"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97654"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97655"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97656"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97657"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97658"],nil] forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error != nil)
        return;
    
    if (characteristic == pot_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textRx.text = [NSString stringWithFormat:@"%d\n", temp];
        
        if (temp>2000 && isOpen==FALSE) {
            helloText.text = @"Morning! Open the curtains.";
        }
        else if (temp<1000 && isOpen==TRUE) {
            helloText.text = @"Night! Close the curtains.";
        }

    }
    else if (characteristic == alert_characteristic) {

    }
    else if (characteristic == acc_x_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textAcceX.text = [NSString stringWithFormat:@"%d\n", temp];
        
    }
    else if (characteristic == acc_y_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textAcceY.text = [NSString stringWithFormat:@"%d\n", temp];
        
    }
    else if (characteristic == acc_z_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textAcceZ.text = [NSString stringWithFormat:@"%d\n", temp];
    }
    else if (characteristic == btn_play_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textBtnPlay.text = [NSString stringWithFormat:@"%d\n", temp];
    }
    else if (characteristic == btn_prev_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textBtnPrev.text = [NSString stringWithFormat:@"%d\n", temp];
    }
    else if (characteristic == btn_next_characteristic) {
        char buffer[32];
        int len=characteristic.value.length;
        memcpy(buffer,[characteristic.value bytes],len);
        buffer[len]=0;
        
        NSString *bufferStr = [NSString stringWithFormat:@"%@", characteristic.value];
        NSString *right = [bufferStr substringWithRange:NSMakeRange(1, 2)];
        NSString *left = [bufferStr substringWithRange:NSMakeRange(3, 2)];
        bufferStr = [NSString stringWithFormat:@"%@%@", left, right];
        
        NSScanner *scanner = [NSScanner scannerWithString:bufferStr];
        unsigned int temp;
        [scanner scanHexInt:&temp];
        textBtnNext.text = [NSString stringWithFormat:@"%d\n", temp];
    }

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error)
    {
        //handle error
        cr_characteristic = nil;
        pot_characteristic = nil;
        alert_characteristic = nil;
        acc_x_characteristic = nil;
        acc_y_characteristic = nil;
        acc_z_characteristic = nil;
        btn_play_characteristic = nil;
        btn_prev_characteristic = nil;
        btn_next_characteristic = nil;
    }
    //[_peripheral readValueForCharacteristic:characteristic];
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"descriptor: %@", descriptor);
    NSLog(@"error: %@", error);
}

- (IBAction)openButton:(id)sender {
    //start animation on tx
//    
//    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    
//    pulseAnimation.toValue = [NSNumber numberWithInt:157];
//    pulseAnimation.fromValue = [NSNumber numberWithInt:0];
//    
//    pulseAnimation.duration = ARROWDURATION;
//    pulseAnimation.repeatCount = 1;
//    pulseAnimation.autoreverses = NO;
//    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    [[arrowTx layer] addAnimation:pulseAnimation forKey:nil];
    
    UInt8 s = 0x10;
    NSData *data=[NSData dataWithBytes:&s length:sizeof(s)];
    
    [_peripheral writeValue:data forCharacteristic:alert_characteristic type:CBCharacteristicWriteWithResponse];
    
    isOpen = TRUE;
    helloText.text = @"";
    
    //
//    cameraViewController *cmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"camera"];
//    [self.navigationController pushViewController:cmVC animated:YES];
    
}

- (IBAction)closeButton:(id)sender {
    //start animation on tx
//    
//    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    
//    pulseAnimation.toValue = [NSNumber numberWithInt:157];
//    pulseAnimation.fromValue = [NSNumber numberWithInt:0];
//    
//    pulseAnimation.duration = ARROWDURATION;
//    pulseAnimation.repeatCount = 1;
//    pulseAnimation.autoreverses = NO;
//    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    [[arrowTx layer] addAnimation:pulseAnimation forKey:nil];
    
    UInt8 s = 0x11;
    NSData *data=[NSData dataWithBytes:&s length:sizeof(s)];
    
    [_peripheral writeValue:data forCharacteristic:alert_characteristic type:CBCharacteristicWriteWithResponse];
    
    isOpen = FALSE;
    helloText.text = @"";
}

@end
