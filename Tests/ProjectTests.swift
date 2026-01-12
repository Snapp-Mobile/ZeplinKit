//
//  ProjectTests.swift
//
//
//  Created by Ilian Konchev on 8.02.22.
//

import XCTest

@testable import Fetcher
@testable import ZeplinKit

final class ProjectTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testCurrentUserEndpoint() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getCurrentUser

        // WHEN
        let user: ZeplinUser = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/users/me")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        SharedAssertions.assertUser(user)
    }

    func testProject() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getProject
        let projectId = ZeplinKitMocks.project.id

        // WHEN
        let project: ZeplinProject = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        SharedAssertions.assertProject(project)
    }

    func testProjectsList() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getProjects

        // WHEN
        let response: [ZeplinProject] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let project = response.first else {
            return XCTFail("unable to get a project")
        }
        SharedAssertions.assertProject(project)
    }

}
