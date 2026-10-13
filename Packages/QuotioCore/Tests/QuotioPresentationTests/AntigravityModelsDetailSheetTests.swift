import AppKit
import QuotioDomain
import SwiftUI
import XCTest
@testable import QuotioPresentation

@MainActor
final class AntigravityModelsDetailSheetTests: XCTestCase {
    func testSheetLaysOutWithoutMenuBarSettings() {
        let hosts: [(models: [QuotaMetric], displayMode: QuotaDisplayMode, hideSensitiveInfo: Bool)] = [
            (metrics(5), .used, true),
            (metrics(9), .used, true),
            (metrics(9), .remaining, false),
            ([], .used, true),
        ]
        for host in hosts {
            let view = NSHostingView(rootView: AntigravityModelsDetailSheet(
                email: "person@example.com",
                models: host.models,
                displayMode: host.displayMode,
                hideSensitiveInfo: host.hideSensitiveInfo
            ))
            view.layoutSubtreeIfNeeded()
            XCTAssertGreaterThan(view.fittingSize.width, 0)
            XCTAssertGreaterThan(view.fittingSize.height, 0)
        }
    }

    private func metrics(_ count: Int) -> [QuotaMetric] {
        (0..<count).map { QuotaMetric(name: "model-\($0)", percentage: 40, resetTime: "") }
    }
}
