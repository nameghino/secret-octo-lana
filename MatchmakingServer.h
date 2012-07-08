//
//  MatchmakingServer.h
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataReceiver.h"

extern NSString *SESSION_ID;

@class MatchmakingServer;
@protocol MatchmakingServerDelegate <NSObject>
-(void) serverDidUpdateConnectedClients:(MatchmakingServer*) client;
@end



@interface MatchmakingServer : NSObject <GKSessionDelegate>

@property(nonatomic, assign) NSUInteger maxClients;
@property(nonatomic, strong, readonly) NSDictionary* connectedClients;
@property(nonatomic, strong, readonly) GKSession* session;
@property(nonatomic, strong) id<MatchmakingServerDelegate> delegate;

-(void) startAcceptingConnectionsForSessionID:(NSString*) sessionID;

@end
