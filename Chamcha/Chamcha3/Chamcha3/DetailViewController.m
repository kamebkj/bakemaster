//
//  DetailViewController.m
//  Chamcha3
//
//  Created by Kate Hsiao on 12/6/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "DetailViewController.h"
#import "PeripheralCell.h"
#import "StepsViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize indicatorOverlay, indicator;
@synthesize peripheral = _peripheral;

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
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    connected_peripheral=nil;
    peripherals = [NSMutableArray arrayWithCapacity:1];
}

- (void)viewWillAppear:(BOOL)animated {
    //disconnect peripheral if connected
    [super viewWillAppear:animated];
    
    [indicatorOverlay setHidden:YES];
    [indicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Bluetooth

- (void)startBLEconnection {
    if(connected_peripheral!=nil)
        [manager cancelPeripheralConnection:connected_peripheral];
    connected_peripheral=nil;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"did update manager state");
    
    char * managerStrings[]={
        "Unknown",
        "Resetting",
        "Unsupported",
        "Unauthorized",
        "PoweredOff",
        "PoweredOn"
    };
    
    NSString * newstring=[NSString stringWithFormat:@"%s",managerStrings[central.state]];
    //    managerState.text=newstring;
    NSLog(@"newstring: %@", newstring);
    if ([newstring isEqualToString:@"PoweredOn"]) {
        NSLog(@"power on");
        bleReady = YES;
    }
    else {
        bleReady = NO;
    }
}


- (void)startScanning {
    [peripherals removeAllObjects];
//    [scanResult reloadData];
    NSArray * services=[NSArray arrayWithObjects:
                        [CBUUID UUIDWithString:@"da588615-01fc-4a86-949a-ca8de10607c5"],
                        nil
                        ];
    [manager scanForPeripheralsWithServices:services options: [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey]];
}

/**
 Called when scanner finds device
 First checks if it exists, if not then insert new device
 */
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    BOOL (^test)(id obj, NSUInteger idx, BOOL *stop);
    test = ^ (id obj, NSUInteger idx, BOOL *stop) {
        if([[[obj peripheral] name] compare:peripheral.name] == NSOrderedSame)
            return YES;
        return NO;
    };
    
    PeripheralCell* cell;
    NSUInteger t=[peripherals indexOfObjectPassingTest:test];
    if(t!= NSNotFound)
    {
        cell=[peripherals objectAtIndex:t];
        cell.peripheral=peripheral;
        cell.rssi=RSSI;
//        [scanResult reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:t inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        cell=[[PeripheralCell alloc] init];
        [peripherals addObject: cell];
        cell.peripheral=peripheral;
        cell.rssi=RSSI;
//        [scanResult insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[peripherals count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    NSLog(@"cell.peripheral: %@", cell.peripheral);
    [manager connectPeripheral:cell.peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"did connect");
    NSLog(@"peripheral: %@", peripheral);
    //    ServiceViewController * hr= [self.storyboard instantiateViewControllerWithIdentifier:@"services"];
    //    connected_peripheral = peripheral;
    //    [hr connectPeripheral:peripheral];
    //    [self.navigationController pushViewController:hr animated:YES];
    [self connectPeripheral:peripheral];
    
}

- (void)connectPeripheral:(CBPeripheral *)per {
    NSLog(@"connectPeripheral");
    _peripheral=per;
    
    NSArray *keys = [NSArray arrayWithObjects:
                     [CBUUID UUIDWithString:@"da588615-01fc-4a86-949a-ca8de10607c5"],
                     nil];
    NSArray *objects = [NSArray arrayWithObjects:
                        @"Pot pot",
                        nil];
    
    serviceNames = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:[serviceNames allKeys]];
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    NSLog(@"didDiscoverServices");
    
    
    CBService* ser=[_peripheral.services objectAtIndex:0];
    
    if([ser.UUID isEqual:[CBUUID UUIDWithString:@"da588615-01fc-4a86-949a-ca8de10607c5"]]) {
        NSLog(@"right!");
        
        // Get recipes from recipe.plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSArray *recipeArray = [dict objectForKey:@"recipes"];
        //        NSDictionary *recipeChoosed = recipeArray[0];
        
        StepsViewController *stepsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stepsVC"];
        stepsVC.recipeItem = 0;
        stepsVC.stepArray = [recipeArray[0] objectForKey:@"steps"];
        [stepsVC connectService:ser];
        [self.navigationController presentViewController:stepsVC animated:YES completion:nil];
    }
    else{
        NSLog(@"not the right service");
    }
    
}

#pragma mark - Button clicks

- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickStart:(id)sender {
    [indicatorOverlay setHidden:NO];
    [indicator startAnimating];
    
    if (bleReady) {
        [self startBLEconnection];
        [self startScanning];
    }
    
}
@end
