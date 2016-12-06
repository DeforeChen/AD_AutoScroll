//
//  Demo_for_AD_AutoScrollCellUITests.m
//  Demo for AD_AutoScrollCellUITests
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Chen Defore. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Demo_for_AD_AutoScrollCellUITests : XCTestCase

@end

@implementation Demo_for_AD_AutoScrollCellUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testExampleA{
    XCUIElementQuery *tablesQuery = [[XCUIApplication alloc] init].tables;
    XCUIElement *page3Of4PageIndicator = tablesQuery.pageIndicators[@"page 3 of 4"];
    [page3Of4PageIndicator swipeLeft];
    [page3Of4PageIndicator swipeLeft];
    
    XCUIElement *page2Of4PageIndicator = tablesQuery.pageIndicators[@"page 2 of 4"];
    [page2Of4PageIndicator swipeLeft];
    [page3Of4PageIndicator swipeLeft];
    [page2Of4PageIndicator swipeLeft];
    [page2Of4PageIndicator swipeLeft];
    [page3Of4PageIndicator swipeLeft];
    [tablesQuery.pageIndicators[@"page 4 of 4"] swipeLeft];
    [tablesQuery.pageIndicators[@"page 1 of 4"] swipeLeft];
    
}

@end
