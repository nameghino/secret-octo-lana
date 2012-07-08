//
//  HostViewController.m
//  Snap
//
//  Created by Nicolas Ameghino on 29/06/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "HostViewController.h"

@interface HostViewController() 
@property (nonatomic, weak) IBOutlet UILabel *headingLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@end

@implementation HostViewController {
	MatchmakingServer *_server;
}

@synthesize headingLabel, nameLabel, nameTextField, statusLabel, tableView, startButton, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.headingLabel.font = [UIFont rw_snapFontWithSize:24.0f];;
	self.nameLabel.font = [UIFont rw_snapFontWithSize:16.0f];
	self.statusLabel.font = [UIFont rw_snapFontWithSize:16.0f];
	self.nameTextField.font = [UIFont rw_snapFontWithSize:20.0f];
	
	[self.startButton rw_applySnapStyle];
	
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.nameTextField action:@selector(resignFirstResponder)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:gestureRecognizer];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField { 
	[textField resignFirstResponder];
	return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)startAction:(id)sender {
	if (!_server) {
		_server = [[MatchmakingServer alloc] init];
		_server.maxClients = 3;
        _server.delegate = self;
		[_server startAcceptingConnectionsForSessionID:SESSION_ID];
		
		self.nameTextField.placeholder = _server.session.displayName;
		[self.tableView reloadData];
	}
}

- (IBAction)exitAction:(id)sender {
	[self.delegate hostViewControllerDidCancel:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[_server connectedClients] count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"Cell";
	UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.textLabel.font = [UIFont rw_snapFontWithSize:20.0f];
		cell.textLabel.textColor = [UIColor snapTextColor];
	}
    
    NSString *peerID = [[_server.connectedClients allKeys] objectAtIndex:indexPath.row];
    
	cell.textLabel.text = [_server.connectedClients objectForKey:peerID] == [NSNull null] ? peerID : [_server.connectedClients objectForKey:peerID];
	return cell;

}

-(void)serverDidUpdateConnectedClients:(MatchmakingServer *)client {
    [self.tableView reloadData];
}

@end
