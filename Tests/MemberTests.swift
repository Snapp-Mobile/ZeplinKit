//
//  MemberTests.swift
//
//
//  Created by Ilian Konchev on 8.02.22.
//

import XCTest

@testable import Fetcher
@testable import ZeplinKit

final class MemberTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testProjectMembers() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getProjectMembers
        let projectId = ZeplinKitMocks.project.id

        // WHEN
        let response: [ZeplinProjectMember] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/members?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let member = response.first else {
            return XCTFail("unable to get the note or the first comment")
        }
        SharedAssertions.assertUser(member.user)
        XCTAssertEqual(member.role, ZeplinRole.admin)
    }

    func testMemberInvitation() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.inviteMember
        let organizationId = ZeplinKitMocks.organization.id

        // WHEN
        let member: ZeplinOrganizationMember = try await fetcher.fetch(sut.apiURL)
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 201)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/organizations/\(organizationId)/members")
        XCTAssertEqual(sut.apiURL.requestMethod, "POST")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["handle"] as? String, ZeplinKitMocks.user.email)
        XCTAssertEqual(bodyParams["role"] as? String, ZeplinRole.member.rawValue)
        XCTAssertEqual(bodyParams["restricted"] as? Bool, true)
        SharedAssertions.assertUser(member.user)
        XCTAssertEqual(member.role, .owner)
        XCTAssertEqual(member.tags, ["developers"])
        XCTAssertFalse(member.restricted)
        XCTAssertEqual(member.invited, 1_517_184_000.0)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testMemberRoleUpdate() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.updateMemberRole
        let organizationId = ZeplinKitMocks.organization.id
        let memberId = ZeplinKitMocks.member.user.id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/organizations/\(organizationId)/members/\(memberId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["role"] as? String, ZeplinRole.admin.rawValue)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testMemberRemoval() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.removeMember
        let organizationId = ZeplinKitMocks.organization.id
        let memberId = ZeplinKitMocks.member.user.id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/organizations/\(organizationId)/members/\(memberId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "DELETE")
        XCTAssertTrue(isMatchingResponseCode)
    }
}
