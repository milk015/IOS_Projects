//
//  HistoryViewController.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "HistoryViewController.h"
#import "TicketModel.h"
#import "Ticket.h"
#import "HistoryDetailsViewController.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * tableView;
@end

@implementation HistoryViewController


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ticketHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Ticket * t = [self.ticketHistory objectAtIndex:indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ticketCell"];
    NSString * prodstring = [[NSString alloc] initWithFormat:@"%@ - $%.2f", t.ticketName,t.ticketPrice ];
    cell.textLabel.text =  prodstring;
    //cell.textLabel.text = @"TESTING";
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat: @"Quantity: %d",t.ticketQty];
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detailSegue"])
    {
        
        HistoryDetailsViewController * detailView = [segue destinationViewController];
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        Ticket * selected =  [self.ticketHistory objectAtIndex:(int) indexPath.row];
        detailView.ticketID = [[NSString alloc]initWithFormat:@"%d", selected.ticketID];
        detailView.ticketName= selected.ticketName;
        detailView.ticketPrice= [[NSString alloc]initWithFormat:@"$%.2f", selected.ticketPrice];
        detailView.ticketqty = [[NSString alloc] initWithFormat:@"%d", selected.ticketQty];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"E, d MMM yyyy HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate: selected.ticketDate];
        detailView.ticketDate = dateString;

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
