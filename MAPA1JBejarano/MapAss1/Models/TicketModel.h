//
//  TicketModel.h
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketModel : NSObject

@property (strong, nonatomic) NSMutableArray* allTickets;
@property (strong, nonatomic) NSMutableArray* allPurchasedTickets;

-(void)buyTicket: (int) qty atSeat: (int) ID;
-(void)addTicketToList:(Ticket *) ticketbought NumberOf: (int) qty WithPrices: (double)price;

@end

NS_ASSUME_NONNULL_END
