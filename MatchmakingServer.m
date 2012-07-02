//
//  MatchmakingServer.m
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "MatchmakingServer.h"

NSString *SESSION_ID = @"Snap!";

@implementation MatchmakingServer {
	NSMutableArray *_connectedClients;
}

@synthesize maxClients = _maxClients;
@synthesize session = _session;

-(void) startAcceptingConnectionsForSessionID:(NSString *)sessionID {
	_connectedClients = [NSMutableArray arrayWithCapacity:self.maxClients];
	_session = [[GKSession alloc] initWithSessionID:sessionID
										displayName:nil
										sessionMode:GKSessionModeServer];
	_session.delegate = self;
	_session.available = YES;
}

-(NSArray *)connectedClients { return _connectedClients; }

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	NSLog(@"MatchmakingServer: peer %@ changed state %d", peerID, state);
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"MatchmakingServer: connection request from peer %@", peerID);
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	NSLog(@"MatchmakingServer: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"MatchmakingServer: session failed %@", error);
}

@end
