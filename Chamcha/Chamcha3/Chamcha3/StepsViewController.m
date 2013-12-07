//
//  StepsViewController.m
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import "StepsViewController.h"
#import "PageControlViewControl.h"
#include <string.h>
//#import "CRViewController.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>

@interface StepsViewController ()

@end

@implementation StepsViewController
@synthesize stepLabel, targerValue, currentValue, scrollView, pageControl, viewControllers;
@synthesize stepArray, recipeItem;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    steps = [stepArray count];
//    NSLog(@"stepArray: %@", stepArray);
    
    stepStatus = [[NSMutableArray alloc] init];
    
    // Initial the first remaining weight needed
    remainTarget = (NSInteger) [stepArray[0] objectForKey:@"amount"];
    targerValue.text = [stepArray[0] objectForKey:@"amount"];
	
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < steps; i++) {
        [controllers addObject:[NSNull null]];
        [stepStatus addObject:[NSNumber numberWithInt:0]];
    }
    self.viewControllers = controllers;
    [scrollView setFrame:CGRectMake(0, 44, 320, 290)];
    [stepLabel setText:@"Step 1"];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * steps, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
    pageControl.numberOfPages = steps;
    pageControl.currentPage = 0;
    
    NSLog(@"after, scrollView.frame.size.width: %f", scrollView.frame.size.width);
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    pageControlUsed = YES;
}



- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= steps) return;
	
    // replace the placeholder if necessary
    PageControlViewControl *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[PageControlViewControl alloc] initWithPageNumber:page];
        controller.recipeItem = recipeItem;
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (!pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    pageControlUsed = NO;
//}

- (IBAction)prevPage:(id)sender {
    NSLog(@"prev");
    [self gotoPrevStep];
}

- (IBAction)nextPage:(id)sender {
    NSLog(@"next");
    [self gotoNextStep];
}

- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoPrevStep {
    
    int page = pageControl.currentPage-1;
    NSLog(@"page: %d", page);
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
    if (page<0) return;
    
    [stepLabel setText:[NSString stringWithFormat:@"Step %d", page+1]];
    
    // If ..., then send data to BLE
    targerValue.text = [stepArray[page] objectForKey:@"amount"];
    NSInteger amount = (NSInteger) [stepArray[page] objectForKey:@"amount"];
    if (stepStatus[page]==0 && amount!=0) {
        [self sendDatatoBLE:amount];
    }
    
}

- (void)gotoNextStep {
    
    int page = pageControl.currentPage+1;
    NSLog(@"page: %d", page);
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
    
    if (page>=steps) return;
    [stepLabel setText:[NSString stringWithFormat:@"Step %d", page+1]];
    
    // If ..., then send data to BLE
    targerValue.text = [stepArray[page] objectForKey:@"amount"];
    NSInteger amount = (NSInteger) [stepArray[page] objectForKey:@"amount"];
    if (stepStatus[page]==0 && amount!=0) {
        [self sendDatatoBLE:amount];
    }
}

- (void)sendDatatoBLE:(NSInteger)num {
    NSLog(@"sendDatatoBLE: %d", num);
    UInt8 s = (UInt8)num;
    NSData *data=[NSData dataWithBytes:&s length:sizeof(s)];
    [_peripheral writeValue:data forCharacteristic:alert_characteristic type:CBCharacteristicWriteWithResponse];
}



#pragma mark - Characteristic part

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
    pot_rollmax_characteristic = nil;
    
    [_peripheral setDelegate:self];
    
    // 1,2: weight, ?
    // 3,4,5: x,y,z
    // 6,7,8: play,prev,next
    // 9: roll out max weight
    [_peripheral discoverCharacteristics:[NSArray arrayWithObjects:
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97651"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97652"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97653"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97654"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97655"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97656"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97657"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97658"],
                                          [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97659"],nil] forService:ser];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear");
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if(error != nil)
    {
        //TODO: handle error
        NSLog(@"some error");
        return;
    }
    
    NSEnumerator *e = [service.characteristics objectEnumerator];

    
    for (int i=0; i<9; i++) {
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
            else if (i==8) {
                pot_rollmax_characteristic = cr_characteristic;
                [peripheral setNotifyValue:YES forCharacteristic: pot_rollmax_characteristic];
            }
            
        }
    }
    
    
    
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if(error != nil)
    {
        //TODO: handle error
        NSLog(@"some error");
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
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97658"],
                                              [CBUUID UUIDWithString:@"c3bad76c-a2b5-4b30-b7ae-74bf35b97659"],nil] forService:service];
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error != nil)
        return;
    
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
    
    if (characteristic == pot_characteristic) {
        currentValue.text = [NSString stringWithFormat:@"%d\n", temp];
    }
    else if (characteristic == alert_characteristic) {
        
    }
    else if (characteristic == acc_x_characteristic) {
        //        NSLog(@"x: %d", temp);
    }
    else if (characteristic == acc_y_characteristic) {
        //        NSLog(@"y: %d", temp);
    }
    else if (characteristic == acc_z_characteristic) {
        //        NSLog(@"z: %d", temp);
    }
    else if (characteristic == btn_play_characteristic) {
        //        NSLog(@"play: %d", temp);
    }
    else if (characteristic == btn_prev_characteristic) {
        //        NSLog(@"prev: %d", temp);
        if (temp!=0) {
            [self gotoPrevStep];
        }
    }
    else if (characteristic == btn_next_characteristic) {
        //        NSLog(@"nex: %d", temp);
        if (temp!=0) {
            [self gotoNextStep];
        }
    }
    else if (characteristic == pot_rollmax_characteristic) {
        
        NSLog(@"rollMax: %d", temp);
        //NSLog(@"pot_rollmax_characteristic");
        
        // Once receive this alert value, cut the remainTarget, and send a new one to BLE
//        remainTarget = remainTarget - temp;
//        if (remainTarget!=0) {
//            // The step hasn't finished
//            [self sendDatatoBLE:remainTarget];
//        }
//        else {
//            // The step has finished, so goto the next step
//            [self gotoNextStep];
//        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error)
    {
        NSLog(@"someome");
        //handle error
        //        cr_characteristic = nil;
        //        pot_characteristic = nil;
        //        alert_characteristic = nil;
        //        acc_x_characteristic = nil;
        //        acc_y_characteristic = nil;
        //        acc_z_characteristic = nil;
        //        btn_play_characteristic = nil;
        //        btn_prev_characteristic = nil;
        //        btn_next_characteristic = nil;
        //        pot_rollmax_characteristic = nil;
    }
    //[_peripheral readValueForCharacteristic:characteristic];
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"descriptor: %@", descriptor);
    NSLog(@"error: %@", error);
}


@end
