//
//  ResetViewController.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "ResetViewController.h"
#import "Ticket.h"
#import "ViewController.h"

@interface ResetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *qtybox;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ResetViewController

Ticket * updateTicket = nil;
int qtyRefresh;
int indexTicket = -1;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Ticket * t = [self.allTickets objectAtIndex:indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ticketCell"];
    NSString * prodstring = [[NSString alloc] initWithFormat:@"%@ - $%.2f", t.ticketName,t.ticketPrice ];
    cell.textLabel.text =  prodstring;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat: @"Quantity: %d",t.ticketQty];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    updateTicket = nil;
    updateTicket = [self.allTickets objectAtIndex:(int)indexPath.row];
    indexTicket =(int) indexPath.row;
    self.qtybox.text = [[NSString alloc] initWithFormat:@"%d",updateTicket.ticketQty ];
}

-(IBAction)OKClicked:(id)sender{
    if(indexTicket != -1){
    }
        updateTicket.ticketQty += (int)[self.qtybox.text integerValue];
    [self.delegate managerReset:updateTicket atID: indexTicket];
        [self.allTickets replaceObjectAtIndex: indexTicket withObject: updateTicket];
    [self.tableView reloadData];
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
