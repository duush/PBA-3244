/**
 * @class      OoyalaAPIListViewController OoyalaAPIListViewController.m "OoyalaAPIListViewController.m"
 * @brief      A list of playback examples that demonstrate usage of the Ooyala APIs
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import "OoyalaAPIListViewController.h"
#import "ChannelContentTreePlayerViewController.h"
#import "DiscoveryListViewController.h"
#import "PlayerSelectionOption.h"

@interface OoyalaAPIListViewController ()

@property NSArray *channelList;

@end

@implementation OoyalaAPIListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

  if (_channelList == nil) {
    PlayerSelectionOption *option1 =
      [[PlayerSelectionOption alloc] initWithTitle:@"Content Tree for Channel" embedCode:@"txaGRiMzqQZSmFpMML92QczdIYUrcYVe" viewController:[ChannelContentTreePlayerViewController class]];
    PlayerSelectionOption *option2 =
      [[PlayerSelectionOption alloc] initWithTitle:@"Discovery Results" embedCode:@"Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1" viewController:[DiscoveryListViewController class]];
    _channelList = [NSArray arrayWithObjects:option1, option2, nil];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

  PlayerSelectionOption *selection = self.channelList[indexPath.row];
  cell.textLabel.text = [selection title];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // When a row is selected, load its desired PlayerViewController
  PlayerSelectionOption *selection = self.channelList[indexPath.row];
  UIViewController *controller = (UIViewController *)[[selection viewController] new];

  if ([controller isKindOfClass:[ChannelContentTreePlayerViewController class]]) {
    ((ChannelContentTreePlayerViewController *)controller).option = selection;
  } else if ([controller isKindOfClass:[DiscoveryListViewController class]]) {
    ((DiscoveryListViewController *)controller).embedCode = selection.embedCode;
  }
  [self.navigationController pushViewController:controller animated:YES];
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
