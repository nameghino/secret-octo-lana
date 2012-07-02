//
//  MatchmakingServer.h
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SESSION_ID;


@interface MatchmakingServer : NSObject <GKSessionDelegate>

@property(nonatomic, assign) NSUInteger maxClients;
@property(nonatomic, strong, readonly) NSArray* connectedClients;
@property(nonatomic, strong, readonly) GKSession* session;

-(void) startAcceptingConnectionsForSessionID:(NSString*) sessionID;

@end
