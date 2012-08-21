//
//  EQSRouteResultsViewController.m
//  esriQuickStartApp
//
//  Created by Nicholas Furness on 8/20/12.
//  Copyright (c) 2012 ESRI. All rights reserved.
//

#import "EQSRouteResultsViewController.h"
#import "EQSRouteResultsTableViewController.h"

@interface EQSRouteResultsViewController ()
@property (strong, nonatomic) IBOutlet EQSRouteResultsTableViewController *tableViewController;
@property (strong, nonatomic) IBOutlet UILabel *routeResultsDistanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *routeResultsTimeLabel;
@end

@implementation EQSRouteResultsViewController
@synthesize tableViewController;
@synthesize routeResultsDistanceLabel;
@synthesize routeResultsTimeLabel;

@synthesize routeResult = _routeResult;

@synthesize hidden = _hidden;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) setRouteResult:(AGSRouteResult *)routeResult
{
    _routeResult = routeResult;
    
    if (_routeResult)
    {
        self.routeResultsDistanceLabel.text = [NSString stringWithFormat:@"Distance: %.2f", routeResult.directions.totalLength];
        self.routeResultsTimeLabel.text = [NSString stringWithFormat:@"Time: %.2f minute%@", routeResult.directions.totalDriveTime,
                                           routeResult.directions.totalDriveTime == 1.0f?@"":@"s"];
        
        self.tableViewController.routeResult = routeResult;
    }
    
    self.hidden = (_routeResult == nil);
}

- (void) setHidden:(BOOL)hidden
{
    if (self.routeResult == nil)
    {
        _hidden = YES;
    }
    else
    {
        _hidden = hidden;
    }

    if (!_hidden)
    {
        self.view.alpha = 0;
        self.view.hidden = NO;
        [UIView animateWithDuration:0.4 animations:^{
            self.view.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.view.alpha = 0;
                         } completion:^(BOOL finished) {
                             self.view.hidden = YES;
                         }];
    }
}

@end
