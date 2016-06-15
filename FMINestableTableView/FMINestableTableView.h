//
//  FMINestableTableView.h
//  FMINestableTableView
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMINestableTableViewDelegate;
@protocol FMINestableTableViewDataSource;

@interface FMINestableTableView : UITableView

@property (nonatomic, weak, nullable) id <FMINestableTableViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <FMINestableTableViewDelegate> delegate;
@property (nonatomic) BOOL allowsNestedRows;

- (NSInteger)numberOfVisibleNestedRowsInSection:(NSInteger)section;

- (UITableViewCell *)configuredCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath;

- (BOOL)showsNestedRows;

- (BOOL)isEditableRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)isNestedRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)passSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)passCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)hideNestedRows;

@end

@protocol FMINestableTableViewDataSource <UITableViewDataSource>

- (NSInteger)nestableTableView:(FMINestableTableView *)tableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)nestableTableView:(FMINestableTableView *)tableView hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

@protocol FMINestableTableViewDelegate <UITableViewDelegate>

- (void)nestableTableView:(FMINestableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestableTableView:(FMINestableTableView *)tableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
