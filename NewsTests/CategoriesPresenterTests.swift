//
//  NewsTests.swift
//  NewsTests
//
//  Created by Aleksandr on 19.11.2022.
//

import XCTest
@testable import News

class CategoriesPresenterTests: XCTestCase {
    
    var categories: [String] = []
    
    var sut: CategoriesPresenter!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        
//        sut = CategoriesPresenter(view: <#T##CategoriesViewInputProtocol#>)
    }

    override func tearDownWithError() throws {
        
        sut = nil
        
        try super.tearDownWithError()
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
