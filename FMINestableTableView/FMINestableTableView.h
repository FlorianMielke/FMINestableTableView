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

/**
 *
 */
@interface FMINestableTableView : UITableView

/**
 *
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMINestableTableViewDataSource> dataSource;

/**
 *
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMINestableTableViewDelegate> delegate;

/**
 *
 */
@property (NS_NONATOMIC_IOSONLY) IBInspectable BOOL allowsNestedRows;

/**
 *
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL showsNestedRows;

/**
 *
 * @param section
 * @return
 */
- (NSInteger)numberOfVisibleNestedRowsInSection:(NSInteger)section;

/**
 *
 * @param indexPath
 * @return
 */
- (UITableViewCell *)configuredCellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 * @return
 */
- (NSIndexPath *)adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 * @return
 */
- (BOOL)isEditableRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 * @return
 */
- (BOOL)isNestedRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 */
- (void)passSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param editingStyle
 * @param indexPath
 */
- (void)passCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 */
- (void)hideNestedRows;

@end

/**
 *
 */
@protocol FMINestableTableViewDataSource <UITableViewDataSource>

/**
 *
 * @param tableView
 * @param indexPath
 * @return
 */
- (NSInteger)nestableTableView:(FMINestableTableView *)tableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param indexPath
 * @return
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param indexPath
 * @return
 */
- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param index
 * @param indexPath
 * @return
 */
- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *
 * @param tableView
 * @param indexPath
 * @return
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param index
 * @param indexPath
 * @return
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param editingStyle
 * @param indexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param editingStyle
 * @param indexPath
 * @param index
 * @param rootIndexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

/**
 *
 */
@protocol FMINestableTableViewDelegate <UITableViewDelegate>

/**
 *
 * @param tableView
 * @param indexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView
 * @param index
 * @param indexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
