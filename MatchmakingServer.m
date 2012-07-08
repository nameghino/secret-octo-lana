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
	NSMutableDictionary *_connectedClients;
    DataReceiver *_dr;
}

@synthesize maxClients = _maxClients;
@synthesize session = _session;
@synthesize delegate = _delegate;

-(void) startAcceptingConnectionsForSessionID:(NSString *)sessionID {
	_connectedClients = [NSMutableDictionary dictionaryWithCapacity:self.maxClients];
	_session = [[GKSession alloc] initWithSessionID:sessionID
										displayName:nil
										sessionMode:GKSessionModeServer];
	_session.delegate = self;
	_session.available = YES;
    _dr = [[DataReceiver alloc] init];
    
    NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
                       self, @"type", nil];
    
    [_session setDataReceiveHandler:_dr withContext:(void*)d];
}

-(NSDictionary *)connectedClients { return _connectedClients; }

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    if (state == GKPeerStateConnected) {
    }
	NSLog(@"MatchmakingServer: peer %@ changed state %d", peerID, state);
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    NSError *error = nil;
    if ([_connectedClients count] < _maxClients) {
        if ([session acceptConnectionFromPeer:peerID error:&error]) {
            [_connectedClients setObject:[NSNull null] forKey:peerID];
            [_delegate serverDidUpdateConnectedClients:self];
        }
    } else {
        [_session cancelConnectToPeer:peerID];
    }
	NSLog(@"MatchmakingServer: connection request from peer %@", peerID);
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	NSLog(@"MatchmakingServer: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"MatchmakingServer: session failed %@", error);
}

@end
