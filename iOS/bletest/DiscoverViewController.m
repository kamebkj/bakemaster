//
//  DiscoverViewController.m
//  bletest
//
//  Created by Kate Hsiao on 11/23/13.
//
//

#import "DiscoverViewController.h"
#import "PeripheralCell.h"
#import "CRViewController.h"
#import "RecipeViewController.h"

#define DEBUGMODE 0

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController
@synthesize peripheral = _peripheral;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    scanResult = nil;
//    managerState = nil;
//    scanSwitch = nil;
//    scanResult = nil;
    [super viewDidUnload];
}

#pragma mark - load view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    connected_peripheral=nil;
    peripherals = [NSMutableArray arrayWithCapacity:1];
    
    //[self startScanning];
}

- (void)viewWillAppear:(BOOL)animated {
    //disconnect peripheral if connected
    if(connected_peripheral!=nil)
        [manager cancelPeripheralConnection:connected_peripheral];
    connected_peripheral=nil;
    [super viewWillAppear:animated];
}

#pragma mark -

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
        [self startScanning];
    }
}


- (void)startScanning {
    [peripherals removeAllObjects];
    [scanResult reloadData];
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
        [scanResult reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:t inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        cell=[[PeripheralCell alloc] init];
        [peripherals addObject: cell];
        cell.peripheral=peripheral;
        cell.rssi=RSSI;
        [scanResult insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[peripherals count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
        if (DEBUGMODE) {
            CRViewController * cr=[self.storyboard instantiateViewControllerWithIdentifier:@"cablerep"];
            [cr connectService:ser];
            [self.navigationController pushViewController:cr animated:YES];
        }
        else {
            RecipeViewController *recipeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"recipeVC"];
            recipeVC.ser = ser;
            [self.navigationController pushViewController:recipeVC animated:YES];
        }
        
    }
    else{
        NSLog(@"not the right service");
        
    }
    
}


@end
