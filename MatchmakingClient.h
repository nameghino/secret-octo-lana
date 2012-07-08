//
//  MatchmakingClient.h
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataReceiver.h"

@class MatchmakingClient;
@protocol MatchmakingClientDelegate <NSObject>
-(void) clientDidUpdateAvailableServers:(MatchmakingClient*) client;
@end

@interface MatchmakingClient : NSObject <GKSessionDelegate>

@property(nonatomic, strong, readonly) NSArray *availableServers;
@property(nonatomic, strong, readonly) GKSession *session;
@property(nonatomic, strong) id<MatchmakingClientDelegate> delegate;

-(void) startSearchingForServersWithSessionID:(NSString*) sessionID;
-(void) connectToPeerID:(NSString*) peerID;

@end
