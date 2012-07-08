//
//  JoinViewController.m
//  Snap
//
//  Created by Nicolas Ameghino on 02/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "JoinViewController.h"
#import "UIFont+SnapAdditions.h"
#import "UIButton+SnapAdditions.h"

@interface JoinViewController ()
@property (nonatomic, weak) IBOutlet UILabel *headingLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UIView *waitView;
@property (nonatomic, weak) IBOutlet UILabel *waitLabel;
@end

@implementation JoinViewController {
	MatchmakingClient *_client;
}

@synthesize delegate = _delegate;

@synthesize headingLabel = _headingLabel;
@synthesize nameLabel = _nameLabel;
@synthesize nameTextField = _nameTextField;
@synthesize statusLabel = _statusLabel;
@synthesize tableView = _tableView;

@synthesize waitView = _waitView;
@synthesize waitLabel = _waitLabel;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.headingLabel.font = [UIFont rw_snapFontWithSize:24.0f];
	self.nameLabel.font = [UIFont rw_snapFontWithSize:16.0f];
	self.statusLabel.font = [UIFont rw_snapFontWithSize:16.0f];
	self.waitLabel.font = [UIFont rw_snapFontWithSize:18.0f];
	self.nameTextField.font = [UIFont rw_snapFontWithSize:20.0f];
	
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.nameTextField action:@selector(resignFirstResponder)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:gestureRecognizer];
}

-(void)clientDidUpdateAvailableServers:(MatchmakingClient *)client {
	[self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
	if (!_client) {
		_client = [[MatchmakingClient alloc] init];
		_client.delegate = self;
		[_client startSearchingForServersWithSessionID:SESSION_ID];
		self.nameTextField.placeholder = _client.session.displayName;
		[self.tableView reloadData];
	}
}

-(void)viewWillDisappear:(BOOL)animated { 
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.waitView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[_client availableServers] count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.textLabel.font = [UIFont rw_snapFontWithSize:20.0f];
		cell.textLabel.textColor = [UIColor snapTextColor];
	}
	cell.textLabel.text = [_client.availableServers objectAtIndex:indexPath.row];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_client connectToPeerID:[[_client availableServers] objectAtIndex:indexPath.row]];
}

- (IBAction)exitAction:(id)sender {
	[self.delegate joinViewControllerDidCancel:self];
}




@end
