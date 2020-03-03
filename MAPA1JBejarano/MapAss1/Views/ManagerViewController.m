//
//  ManagerViewController.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "ManagerViewController.h"
#import "HistoryViewController.h"
#import "ResetViewController.h"
#import "ViewController.h"
#import "Ticket.h"

@interface ManagerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *history;

@end

@implementation ManagerViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"HistorySegue"]){
        HistoryViewController * historyView = [segue destinationViewController];
        historyView.ticketHistory = self.gate.allPurchasedTickets;
        NSLog(@"HISTORYSEGUE %lu", self.gate.allPurchasedTickets.count);
    }
    else if([[segue identifier] isEqualToString:@"resetSegue"]){
        ResetViewController * resetView = [segue destinationViewController];

        resetView.allTickets = self.gate.allTickets;
        NSLog(@"%lu",self.gate.allTickets.count);
        resetView.delegate = self.delegate;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
