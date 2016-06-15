//
//  FMIDemoTableViewController.m
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <FMINestableTableView/FMINestableTableView.h>
#import "FMIDemoTableViewController.h"
#import "FMIMovie.h"
#import "FMIActor.h"
#import "FMICinema.h"
#import "FMICinemaWorld.h"
#import "FMIWorldProvider.h"

NSString *const FMIDemoTableViewControllerParentCellIdentifier = @"FMIDemoTableViewControllerParentCell";
NSString *const FMIDemoTableViewControllerChildCellIdentifier = @"FMIDemoTableViewControllerChildCell";

@interface FMIDemoTableViewController ()

@property (nonatomic, strong) FMICinemaWorld *world;

@end

@implementation FMIDemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.world = [FMIWorldProvider provideWorld];
    ((FMINestableTableView *) self.tableView).allowsNestedRows = YES;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)hideAllNestedRows:(id)sender {
    [(FMINestableTableView *) self.tableView hideNestedRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.world.numberOfCinemas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FMICinema *cinema = self.world.cinemas[section];
    return cinema.numberOfMovies + [(FMINestableTableView *) tableView numberOfVisibleNestedRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.world.cinemas[section].title;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    cell.backgroundColor = ([(FMINestableTableView *) tableView isNestedRowAtIndexPath:indexPath]) ? [UIColor colorWithWhite:0.941 alpha:1.0] : [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)nestedTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(FMINestableTableView *) nestedTableView configuredCellForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FMIDemoTableViewControllerParentCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.world movieAtIndexPath:indexPath].title;
    return cell;
}

- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForNestedRowAtIndex:(NSInteger)index rootRowIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FMIDemoTableViewControllerChildCellIdentifier forIndexPath:indexPath];
    FMIMovie *movie = [self.world movieAtIndexPath:indexPath];
    cell.textLabel.text = [movie castAtIndex:index].name;
    return cell;
}

- (BOOL)nestableTableView:(FMINestableTableView *)tableView hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([self.world movieAtIndexPath:indexPath].numberOfCast > 0);
}

- (NSInteger)nestableTableView:(FMINestableTableView *)tableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.world movieAtIndexPath:indexPath].numberOfCast;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.isEditing) ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(FMINestableTableView *) tableView isEditableRowAtIndexPath:indexPath];
}

- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    FMIMovie *movie = [self.world movieAtIndexPath:indexPath];
    return (movie.numberOfCast > 0);
}

- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [(FMINestableTableView *) tableView passCommitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)nestableTableView:(FMINestableTableView *)nestedTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.world removeMovieAtIndexPath:indexPath];
    [nestedTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self setEditing:NO animated:YES];
}

- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath {
    FMIMovie *movie = [self.world movieAtIndexPath:indexPath];
    [movie removeActorAtIndex:index];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (CGFloat) (([(FMINestableTableView *) tableView isNestedRowAtIndexPath:indexPath]) ? 44.0 : 66.0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(FMINestableTableView *) tableView passSelectRowAtIndexPath:indexPath];
}

- (void)nestableTableView:(FMINestableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Tapped row at index path: %@", indexPath);
}

- (void)nestableTableView:(FMINestableTableView *)tableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Tapped nested row at index %li for index path: %@", (long) index, indexPath);
}

@end
