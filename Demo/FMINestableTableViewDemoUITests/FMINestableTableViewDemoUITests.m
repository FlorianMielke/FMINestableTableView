#import <XCTest/XCTest.h>

@interface FMINestableTableViewDemoUITests : XCTestCase

@property (nonatomic, strong) XCUIApplication *application;

@end

@implementation FMINestableTableViewDemoUITests

- (void)setUp {
    [super setUp];
    self.application = [[XCUIApplication alloc] init];
    [self.application launch];
}

- (void)testItExpandsAParentCell {
    XCUIElement *pulpFictionCell = self.application.tables.staticTexts[@"Pulp Fiction"];
    
    [pulpFictionCell tap];

    XCTAssertEqual(8, self.application.tables.cells.count);
}

- (void)testItHidesChildCells {
    XCUIElement *ingloriousCell = self.application.tables.staticTexts[@"Inglorious Basterds"];
    [ingloriousCell tap];
    
    XCTAssertEqual(7, self.application.tables.cells.count);
    
    XCUIElement *pulpFictionCell = self.application.tables.staticTexts[@"Pulp Fiction"];
    [pulpFictionCell tap];

    XCTAssertEqual(8, self.application.tables.cells.count);
}

@end
