//
//  FMINestableTableView.h
//  FMINestableTableView
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FMINestableTableView;


/**
 * The FMINestableTableViewDataSource protocol is adopted by an object that mediates the application’s data model for a FMINestableTableView object.
 * The data source provides the table-view object with the information it needs to construct and modify a table view.
 */
@protocol FMINestableTableViewDataSource <NSObject, UITableViewDataSource>

/**
 * Asks the data source to return the number of nested rows for a given index path.
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating a row in tableView.
 * @return The number of nested rows for indexPath.
 */
- (NSInteger)nestableTableView:(FMINestableTableView *)tableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating a row in tableView.
 * @return YES if the row indicated by indexPath has nested rows; otherwise, NO.
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the data source for a cell to insert in a particular location of the table view.
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating a row in tableView.
 * @return An object inheriting from UITableViewCell that the table view can use for the specified row. An assertion is raised if you return nil.
 */
- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView The table-view object requesting this information.
 * @param index
 * @param indexPath
 * @return
 */
- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *
 * @param tableView The table-view object requesting this information.
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
 * @param tableView The table-view object requesting this information.
 * @param editingStyle
 * @param indexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param tableView The table-view object requesting this information.
 * @param editingStyle
 * @param indexPath
 * @param index
 * @param rootIndexPath
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

/**
 * The delegate of a \c FMINestableTableView object must adopt the FMINestableTableViewDelegate protocol.
 */
@protocol FMINestableTableViewDelegate <NSObject, UITableViewDelegate>

/**
 * Tells the delegate that the specified row is now selected.
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating the new selected row in tableView.
 */
- (void)nestableTableView:(FMINestableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Tells the delegate that the specified nested row is now selected.
 * @param tableView The table-view object requesting this information.
 * @param index An index locating the new selected nested row in tableView.
 * @param indexPath An index path that locates a root row in tableView.
 */
- (void)nestableTableView:(FMINestableTableView *)tableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *
 */
@interface FMINestableTableView : UITableView

/**
 * The object that acts as the data source of the table view.
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMINestableTableViewDataSource> dataSource;

/**
 * The object that acts as the delegate of the table view.
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMINestableTableViewDelegate> delegate;

/**
 * A Boolean value that determines whether the table view uses nested rows.
 */
@property (NS_NONATOMIC_IOSONLY) IBInspectable BOOL allowsNestedRows;

/**
 * A Boolean value that indicates whether the tabe view shows nested rows.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL showsNestedRows;

/**
 *
 * @param numberOfRows
 * @param section
 * @return
 */
- (NSInteger)fmi_numberOfRows:(NSInteger)numberOfRows inSection:(NSInteger)section;

/**
 *
 * @param indexPath
 * @return
 */
- (UITableViewCell *)fmi_cellForRowAtIndexPath:(NSIndexPath *)indexPath;

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
- (BOOL)fmi_canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 * @return
 */
- (BOOL)fmi_isNestedRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param indexPath
 */
- (void)fmi_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *
 * @param editingStyle
 * @param indexPath
 */
- (void)fmi_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Hides all visible nested rows if needed.
 */
- (void)fmi_hideNestedRows;

@end

NS_ASSUME_NONNULL_END
