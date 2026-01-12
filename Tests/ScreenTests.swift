//
//  ScreenTests.swift
//  
//
//  Created by Ilian Konchev on 8.02.22.
//

@testable import Fetcher
import XCTest
@testable import ZeplinKit

final class ScreenTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testScreen() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getScreen
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id

        // WHEN
        let screen: ZeplinScreen = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        SharedAssertions.assertScreen(screen)
    }

    func testScreensList() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getScreens
        let projectId = ZeplinKitMocks.project.id

        // WHEN
        let response: [ZeplinScreen] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens?sort=section&limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let screen = response.first else {
            return XCTFail("unable to get a screen")
        }
        SharedAssertions.assertScreen(screen)
    }

    func testScreenSections() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getSections
        let projectId = ZeplinKitMocks.project.id

        // WHEN
        let response: [ZeplinSection] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screen_sections?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let section = response.first else {
            return XCTFail("unable to get the note or the first comment")
        }
        XCTAssertEqual(section.id, "5db81e73e1e36ee19f138c1a")
        XCTAssertEqual(section.created, 1_517_184_000.0)
        XCTAssertEqual(section.name, "Radar")
    }

}
