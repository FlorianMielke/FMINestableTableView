#import <XCTest/XCTest.h>
#import "FMIDemoTableViewController.h"

@interface FMINestableTableViewDemoTests : XCTestCase

@property (nonatomic, strong) FMIDemoTableViewController *subject;

@end

@implementation FMINestableTableViewDemoTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:[self class]]];
    self.subject = [storyboard instantiateViewControllerWithIdentifier:FMIDemoTableViewControllerStoryboardID];
    [self.subject viewDidLoad];
}

- (void)testItShows3RowsByDefaultInSection1 {
    XCTAssertEqual(3, [self.subject.tableView numberOfRowsInSection:0]);
}

- (void)testItShowsChildCellsWhenTappingParentCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self expectationForNumberOfRows:5 inSection:0];

    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:indexPath];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];

    XCTAssertEqual(5, [self.subject.tableView numberOfRowsInSection:0]);
}

- (void)testItHidesChildCellsWhenTappingParentCellTwice {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self expectationForNumberOfRows:3 inSection:0];

    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:indexPath];
    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:indexPath];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];

    XCTAssertEqual(3, [self.subject.tableView numberOfRowsInSection:0]);
}

- (void)testItHidesChildCellsWhenTappingAnotherParentCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *anotherIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self expectationForNumberOfRows:3 inSection:0];
    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:indexPath];

    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:anotherIndexPath];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];

    XCTAssertEqual(3, [self.subject.tableView numberOfRowsInSection:0]);
    XCTAssertEqual(2, [self.subject.tableView numberOfRowsInSection:1]);
}

- (void)testItHidesChildCellsAndOpenOtherChildCells {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *anotherIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self expectationForNumberOfRows:3 inSection:0];
    [self expectationForNumberOfRows:3 inSection:1];
    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:indexPath];

    [self.subject tableView:self.subject.tableView didSelectRowAtIndexPath:anotherIndexPath];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];

    XCTAssertEqual(4, [self.subject.tableView numberOfRowsInSection:0]);
}

- (XCTestExpectation *)expectationForNumberOfRows:(NSUInteger)numberOfRows inSection:(NSInteger)section {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(UITableView *evaluatedObject, NSDictionary<NSString *, id> *bindings) {
        return ([evaluatedObject numberOfRowsInSection:section] == numberOfRows);
    }];
    return [self expectationForPredicate:predicate evaluatedWithObject:self.subject.tableView handler:nil];
}

@end
