//
//  FMINestableTableView.m
//  FMINestableTableView
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "FMINestableTableView.h"

@interface FMINestableTableView ()

@property (NS_NONATOMIC_IOSONLY) NSMutableArray *indexPathsForNestedRows;
@property (NS_NONATOMIC_IOSONLY) NSIndexPath *indexPathForRootRow;

@end

@implementation FMINestableTableView

@dynamic delegate;
@dynamic dataSource;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.fmi_allowsNestedRows = NO;
    }
    return self;
}

- (NSInteger)fmi_numberOfRows:(NSInteger)numberOfRows inSection:(NSInteger)section {
    return numberOfRows + [self numberOfVisibleNestedRowsInSection:section];
}

- (NSInteger)numberOfVisibleNestedRowsInSection:(NSInteger)section {
    if (!self.fmi_allowsNestedRows || !self.fmi_showsNestedRows || ![self isRootRowSectionEqualToSection:section]) {
        return 0;
    }
    return [self numberOfNestedRowsForRowAtIndexPath:self.indexPathForRootRow];
}

- (UITableViewCell *)fmi_cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows) {
        return nil;
    }
    if ([self fmi_isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        return [self.dataSource nestableTableView:self cellForNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    }
    NSIndexPath *adjustedIndexPath = [self fmi_adjustedIndexPathForIndexPath:indexPath];
    return [self.dataSource nestableTableView:self cellForRowAtIndexPath:adjustedIndexPath];
}

- (BOOL)fmi_canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows) {
        return [self.dataSource nestableTableView:self canEditRowAtIndexPath:indexPath];
    }
    if ([self fmi_isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        return [self.dataSource nestableTableView:self canEditNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    }
    NSIndexPath *adjustedIndexPath = [self fmi_adjustedIndexPathForIndexPath:indexPath];
    return [self.dataSource nestableTableView:self canEditRowAtIndexPath:adjustedIndexPath];
}

- (void)fmi_didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows) {
        [self.delegate nestableTableView:self didSelectRowAtIndexPath:indexPath];
    }
    if ([self fmi_isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        [self.delegate nestableTableView:self didSelectNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    } else {
        NSIndexPath *adjustedIndexPath = [self fmi_adjustedIndexPathForIndexPath:indexPath];
        if ([self hasNestedRowsForRowAtIndexPath:adjustedIndexPath]) {
            [self toggleNestedRowsForRowAtIndexPath:adjustedIndexPath];
        } else {
            [self fmi_hideNestedRows];
            [self.delegate nestableTableView:self didSelectRowAtIndexPath:adjustedIndexPath];
        }
    }
}

- (void)fmi_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows) {
        [self.dataSource nestableTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
    if ([self fmi_isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        [self.dataSource nestableTableView:self commitEditingStyle:editingStyle forNestedRowAtIndexPath:indexPath nestedItemIndex:index rootRowIndexPath:self.indexPathForRootRow];
        [self prepareNestedIndexPathsForIndexPath:self.indexPathForRootRow];
    } else {
        NSIndexPath *adjustedIndexPath = [self fmi_adjustedIndexPathForIndexPath:indexPath];
        [self.dataSource nestableTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:adjustedIndexPath];
    }
}

- (BOOL)fmi_isNestedRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.indexPathsForNestedRows containsObject:indexPath];
}

- (void)fmi_hideNestedRows {
    if (self.fmi_showsNestedRows) {
        [self hideNestedRowsForRowAtIndexPath:self.indexPathForRootRow];
    }
}

- (void)toggleNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows) {
        return;
    }
    [self deselectRowAtIndexPath:indexPath animated:YES];
    [self beginUpdates];
    if ([self isRootRowAtIndexPath:indexPath]) {
        [self hideNestedRowsForRowAtIndexPath:indexPath];
    } else {
        [self hideNestedRowsForRowAtIndexPath:self.indexPathForRootRow];
        if ([self hasNestedRowsForRowAtIndexPath:indexPath]) {
            [self showNestedRowsForRowAtIndexPath:indexPath];
        }
    }
    [self endUpdates];
}

- (void)showNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPathForRootRow = indexPath;
    [self prepareNestedIndexPathsForIndexPath:self.indexPathForRootRow];
    [self insertRowsAtIndexPaths:self.indexPathsForNestedRows withRowAnimation:UITableViewRowAnimationTop];
    [self scrollToRowAtIndexPath:self.indexPathForRootRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)hideNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPathForRootRow = nil;
    NSArray *nestedRowsIndexPaths = [self.indexPathsForNestedRows copy];
    [self.indexPathsForNestedRows removeAllObjects];
    [self deleteRowsAtIndexPaths:nestedRowsIndexPaths withRowAnimation:UITableViewRowAnimationTop];
}

- (void)prepareNestedIndexPathsForIndexPath:(NSIndexPath *)indexPath {
    [self.indexPathsForNestedRows removeAllObjects];
    NSInteger numberOfNestedRows = [self numberOfNestedRowsForRowAtIndexPath:indexPath];
    NSInteger firstRow = indexPath.row + 1;
    for (NSInteger row = firstRow; row < firstRow + numberOfNestedRows; row++) {
        [self.indexPathsForNestedRows addObject:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
    }
}

- (NSIndexPath *)fmi_adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath {
    if (!self.fmi_allowsNestedRows
            || !self.fmi_showsNestedRows
            || ![self isRootRowSectionEqualToSection:indexPath.section]
            || [self isRootRowIndexPathAfterIndexPath:indexPath]
            || [self isRootRowAtIndexPath:indexPath]
            || [self fmi_isNestedRowAtIndexPath:indexPath]) {
        return indexPath;
    }
    NSInteger row = indexPath.row - [self numberOfVisibleNestedRowsInSection:indexPath.section];
    return [NSIndexPath indexPathForRow:row inSection:indexPath.section];
}

- (NSInteger)indexForNestedRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self fmi_isNestedRowAtIndexPath:indexPath]) {
        return NSNotFound;
    }
    return indexPath.row - self.indexPathForRootRow.row - 1;
}

- (BOOL)fmi_showsNestedRows {
    return (self.indexPathForRootRow != nil);
}

- (NSInteger)numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource nestableTableView:self numberOfNestedRowsForRowAtIndexPath:indexPath];
}

- (BOOL)hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource nestableTableView:self hasNestedRowsForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)cellForRootRow {
    return self.fmi_showsNestedRows ? [self cellForRowAtIndexPath:self.indexPathForRootRow] : nil;
}

- (BOOL)isRootRowSectionEqualToSection:(NSInteger)section {
    return (section == self.indexPathForRootRow.section);
}

- (BOOL)isRootRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([indexPath compare:self.indexPathForRootRow] == NSOrderedSame);
}

- (BOOL)isRootRowIndexPathAfterIndexPath:(NSIndexPath *)indexPath {
    return ([self.indexPathForRootRow compare:indexPath] == NSOrderedDescending);
}

- (void)setFmi_allowsNestedRows:(BOOL)fmi_allowsNestedRows {
    if (_fmi_allowsNestedRows != fmi_allowsNestedRows) {
        _fmi_allowsNestedRows = fmi_allowsNestedRows;
        if (_fmi_allowsNestedRows) {
            self.indexPathsForNestedRows = [[NSMutableArray alloc] init];
        } else {
            [self.indexPathsForNestedRows removeAllObjects];
            self.indexPathForRootRow = nil;
        }
    }
}

@end
