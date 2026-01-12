//
//  NotificationTests.swift
//
//
//  Created by Ilian Konchev on 8.02.22.
//

import XCTest

@testable import Fetcher
@testable import ZeplinKit

final class NotificationTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testNotificationsList() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getNotifications

        // WHEN
        let response: [ZeplinNotification] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/users/me/notifications?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let notification = response.first, let user = notification.actor.user else {
            return XCTFail("unable to get the note or the first comment")
        }
        XCTAssertEqual(notification.id, "5fbe387f8c72ef23659fb500")
        XCTAssertEqual(notification.created, 1_586_852_836.0)
        XCTAssertFalse(notification.isRead)
        XCTAssertEqual(notification.type, "project.color")
        XCTAssertEqual(notification.action, ZeplinNotificationAction.created)
        SharedAssertions.assertUser(user)
        XCTAssertEqual(notification.contextDescription, "HAL 9000 (web)")
        XCTAssertEqual(notification.actionDescription, "created color \"baby poop green\"")
    }

    func testNotificationUpdate() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.updateNotification

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/users/me/notifications/\(ZeplinKitMocks.notificationId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["is_read"] as? Bool, true)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testNotificationsUpdate() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.updateNotifications
        let notificationId = ZeplinKitMocks.notifications[0].id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/users/me/notifications?id=\(notificationId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["is_read"] as? Bool, true)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testFlagNotificationsAsUnread() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.flagNotificationsAsUnread
        let notificationId = ZeplinKitMocks.notificationsAlt[0].id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/users/me/notifications?id=\(notificationId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["is_read"] as? Bool, false)
        XCTAssertTrue(isMatchingResponseCode)
    }
}
