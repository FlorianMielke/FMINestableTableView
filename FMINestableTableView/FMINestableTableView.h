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
 * The FMITableViewDataSourceNesting protocol is adopted by an object that mediates the application’s data model for a FMINestableTableView object.
 * The data source provides the table-view object with the information it needs to construct and modify a table view.
 */
@protocol FMITableViewDataSourceNesting <NSObject>

/**
 * Asks the data source to return the number of nested rows for a given index path.
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating a row in tableView.
 * @return The number of nested rows for indexPath.
 */
- (NSInteger)nestableTableView:(FMINestableTableView *)tableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the data source to verify that the given row has nested rows.
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
 * Asks the data source for a cell to insert in a nested location of the table view.
 * @param tableView The table-view object requesting this information.
 * @param index An index locating a nested row for the given rootRowIndexPath.
 * @param rootIndexPath An index path locating a root row in tableView.
 * @return An object inheriting from UITableViewCell that the table view can use for the specified row. An assertion is raised if you return nil.
 */
- (UITableViewCell *)nestableTableView:(FMINestableTableView *)tableView cellForNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@optional
/**
 * Asks the data source to verify that the given row is editable.
 * @param tableView The table-view object requesting this information.
 * @param indexPath An index path locating a row in tableView.
 * @return YES if the row indicated by indexPath is editable; otherwise, NO.
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the data source to verify that the given nested row is editable.
 * @param tableView The table-view object requesting this information.
 * @param index An index locating a nested row for the given rootRowIndexPath.
 * @param rootIndexPath An index path locating a root row in tableView.
 * @return
 */
- (BOOL)nestableTableView:(FMINestableTableView *)tableView canEditNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

/**
 * Asks the data source to commit the insertion or deletion of a specified row in the receiver.
 * @param tableView The table-view object requesting this information.
 * @param editingStyle The cell editing style corresponding to a insertion or deletion requested for the row specified by indexPath.
 * @param indexPath An index path locating the row in tableView.
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the data source to commit the insertion or deletion of a specified nested row in the receiver.
 * @param tableView The table-view object requesting this information.
 * @param editingStyle The cell editing style corresponding to a insertion or deletion requested for the nested row specified by indexPath.
 * @param indexPath An index path locating the nested row in tableView.
 * @param index An index locating a nested row for the given rootRowIndexPath.
 * @param rootIndexPath An index path locating the root row in tableView.
 */
- (void)nestableTableView:(FMINestableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

/**
 * The delegate of a \c FMINestableTableView object must adopt the FMITableViewDelegateNesting protocol.
 */
@protocol FMITableViewDelegateNesting <NSObject>

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
 * @param rootIndexPath An index path that locates a root row in tableView.
 */
- (void)nestableTableView:(FMINestableTableView *)tableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

/**
 * An instance of FMINestableTableView enhances UITableView to handle nested rows.
 */
@interface FMINestableTableView : UITableView

/**
 * The object that acts as the data source of the table view.
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) IBOutlet id <FMITableViewDataSourceNesting> nestingDataSource;

/**
 * The object that acts as the delegate of the table view.
 */
@property (nullable, weak, NS_NONATOMIC_IOSONLY) IBOutlet id <FMITableViewDelegateNesting> nestingDelegate;

/**
 * A Boolean value that determines whether the table view can show nested rows.
 */
@property (NS_NONATOMIC_IOSONLY) IBInspectable BOOL fmi_allowsNestedRows;

/**
 * A Boolean value that indicates whether the tabe view currently displays any nested row.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL fmi_displaysNestedRows;

/**
 * Returns the number of rows incl. any visible nested rows in a specified section.
 * @param numberOfRows The number of rows when no nested rows where visible.
 * @param section An index number that identifies a section of the table.
 * @return The number of rows in the section.
 */
- (NSInteger)fmi_adjustedNumberOfRowsForNumberOfRows:(NSInteger)numberOfRows inSection:(NSInteger)section;

/**
 * Passes to the data source to ask for a cell to insert in a particular location of the table view.
 * @param indexPath An index path locating a row in tableView.
 * @return An object inheriting from UITableViewCell that the table view can use for the specified row.
 */
- (UITableViewCell *)fmi_cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Passes to the data source to verify that the given row is editable.
 * @param indexPath An index path locating a row in tableView.
 * @return YES if the row indicated by indexPath is editable; otherwise, NO.
 */
- (BOOL)fmi_canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Passes to the delegate to tell that the specified row is now selected.
 * @param indexPath
 */
- (void)fmi_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Returns the adjusted index path of a given indexPath and considering any visible nested rows.
 * @param indexPath An index path locating the row in tableView.
 * @return An adjusted index path based on whether any nested rows are visible or not.
 */
- (NSIndexPath *)fmi_adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath;

/**
 * Asks the data source to verify that the given row is nested.
 * @param indexPathn An index path locating a row in tableView.
 * @return YES if the row indicated by indexPath is nested; otherwise, NO.
 */
- (BOOL)fmi_isNestedRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Passes to the data source to commit the insertion or deletion of a specified row in the receiver.
 * @param editingStyle The cell editing style corresponding to a insertion or deletion requested for the row specified by indexPath.
 * @param indexPath An index path locating the row in tableView.
 */
- (void)fmi_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Hides all visible nested rows if needed.
 */
- (void)fmi_hideNestedRows;

@end

NS_ASSUME_NONNULL_END
