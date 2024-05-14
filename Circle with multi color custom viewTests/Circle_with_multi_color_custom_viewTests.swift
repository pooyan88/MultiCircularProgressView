//
//  Circle_with_multi_color_custom_viewTests.swift
//  Circle with multi color custom viewTests
//
//  Created by Pooyan J on 2/22/1403 AP.
//

import XCTest
import SnapshotTesting
@testable import Circle_with_multi_color_custom_view

final class Circle_with_multi_color_custom_viewTests: XCTestCase {

    // android lint

    func getVC() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        vc?.view.layoutIfNeeded()
        return vc!
    }
}

// MARK: - Test Logic
extension Circle_with_multi_color_custom_viewTests {

    private func getDegree(input: Double) -> Double {
        return (input - 90) * .pi / 180.0
    }

    private func getRemainPercentageDegree(total: Double, remain: Double) -> Double {
        let remainPercentage = getRemainPercentage(total: total, remain: remain)
        return (remainPercentage * 360) / 100
    }

    private func getRemainPercentage(total: Double, remain: Double) -> Double {
        return (remain / total) * 100
    }

    func test_getRemainPercetange() {
        let remainPercentage = getRemainPercentage(total: 100, remain: 45)
        XCTAssertEqual(remainPercentage, 45)
    }

    func test_remainPercentageDegree() {
        let remainPercentage = getRemainPercentage(total: 100, remain: 50)
        let degree = (remainPercentage * 360) / 100
        XCTAssertEqual(degree, 180)
    }
}

// MARK: - Test UI
extension Circle_with_multi_color_custom_viewTests {

    func test_snapShotMainView() {
        assertSnapshots(matching: getVC(), as: [.image], record: false)
    }
}
