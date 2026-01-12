//
//  ZeplinKitMocks.swift
//  
//
//  Created by Ilian Konchev on 3.02.22.
//

import Fetcher
import Foundation
@testable import ZeplinKit

struct ZeplinKitMocks {
    // swiftlint:disable large_tuple
    static func mocked(request: URLRequest) -> (HTTPURLResponse, Data?, Error?) {
        var mockFileName: String?
        var wantedResponseCode: Int = 200
        for urlMock in ZeplinKitURLMock.allCases {
            let mapRequest = urlMock.apiURL.request(token: ZeplinKitMocks.token)
            if mapRequest?.url == request.url && mapRequest?.httpMethod == request.httpMethod {
                mockFileName = urlMock.fileName
                wantedResponseCode = urlMock.responseCode
                break
            }
        }
        guard let mockFileName = mockFileName,
              let url = Bundle.module.url(forResource: mockFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)
            return (response!, nil, APIError.unknown)
        }

        let response = HTTPURLResponse(url: request.url!, statusCode: wantedResponseCode, httpVersion: nil, headerFields: nil)
        return (response!, data, nil)
    }

    static let code = "mockCode"

    static let addNoteRequest = ZeplinAddNoteRequest(project: ZeplinKitMocks.project,
                                                     screen: ZeplinKitMocks.screen,
                                                     position: ZeplinNotePosition(originX: 0.3, originY: 0.3),
                                                     color: "purple",
                                                     content: "Test comment")

    static let updateNoteRequest = ZeplinUpdateNoteRequest(project: ZeplinKitMocks.project,
                                                           screen: ZeplinKitMocks.screen,
                                                           note: ZeplinKitMocks.note,
                                                           position: ZeplinNotePosition(originX: 0.5, originY: 0.5),
                                                           status: ZeplinNote.Status.open.rawValue)

    static let addCommentRequest = ZeplinAddCommentRequest(project: ZeplinKitMocks.project,
                                                           screen: ZeplinKitMocks.screen,
                                                           note: ZeplinKitMocks.note,
                                                           content: "Test comment")

    static let updateCommentRequest = ZeplinUpdateCommentRequest(project: ZeplinKitMocks.project,
                                                                 screen: ZeplinKitMocks.screen,
                                                                 note: ZeplinKitMocks.note,
                                                                 comment: ZeplinKitMocks.comment,
                                                                 content: "Updated content")

    static let token = Token(accessToken: "abc123",
                             expiresIn: Int32(Date().addingTimeInterval(3600).timeIntervalSince1970),
                             refreshToken: "123abc",
                             refreshExpiresIn: Int32(Date().addingTimeInterval(86_400).timeIntervalSince1970),
                             tokenType: "bearer")

    static let project = ZeplinProject(id: "5db81e73e1e36ee19f138c1a",
                                       name: "HAL 9000",
                                       description: "UI designs for the onboard computer on the spaceship Discovery 1",
                                       thumbnailURL: "http://placekitten.com/200/300",
                                       platform: .web,
                                       status: "active",
                                       created: 1_517_184_000.0,
                                       updated: 1_572_347_818.0,
                                       numberOfScreens: 112,
                                       numberOfSpacingTokens: 63,
                                       numberOfComponents: 46,
                                       numberOfTextStyles: 28,
                                       numberOfColors: 17,
                                       numberOfMembers: 47,
                                       linkedStyleguide: LinkedStyleguide(id: "5db81e6e6a4462065f04d932"),
                                       organization: ZeplinOrganizationSummary(id: "5d9caaecb4a3fa9b972f86ce",
                                                                               name: "Acme, Inc.",
                                                                               logo: "http://placekitten.com/200/300"))

    static let screen = ZeplinScreen(id: "5dbad85a76ea51c1f35b6f69",
                                     name: "Login",
                                     description: "Login screen for HAL 9000",
                                     created: 1_517_184_000.0,
                                     updated: 1_572_347_818.0,
                                     image: ZeplinImage(width: 2560.0,
                                                        height: 1920.0,
                                                        originalURL: "http://placekitten.com/2560/1920"),
                                     backgroundColor: nil,
                                     section: ZeplinSection(id: "5db81e6e6a4462065f04d932"),
                                     tags: ["mobile", "login"],
                                     numberOfNotes: 7,
                                     numberOfVersions: 4)

    static let user = ZeplinUser(id: "5d9caaecb4a3fa9bc9718686",
                                 email: "5d9caaecb4a3fa9bc9718686@user.zeplin.io",
                                 username: "zozo",
                                 emotar: "🍎",
                                 avatarURL: "http://placekitten.com/200/300",
                                 lastSeen: 1_616_739_240.0)

    static let organization = ZeplinOrganizationSummary(id: "5d9caaecb4a3fa9b972f86ce",
                                                        name: "Acme, Inc.",
                                                        logo: "http://placekitten.com/200/300")

    static let color = ZeplinColor(alpha: 1, red: 254, green: 207, blue: 51, name: "yellow")

    static let notificationId = "5fbe387f8c72ef23659fb500"

    static let notifications: [ZeplinNotificationRepresentation] = [
        ZeplinNotificationRepresentation(id: "5fbe387f8c72ef23659fb500",
                                         created: 1_586_852_836.0,
                                         lastUpdated: 1_586_852_836.0,
                                         isRead: false)
    ]

    static let notificationsAlt: [ZeplinNotificationRepresentation] = [
        ZeplinNotificationRepresentation(id: "5fbe387f8c72ef23659fb501",
                                         created: 1_586_852_836.0,
                                         lastUpdated: 1_586_852_836.0,
                                         isRead: true)
    ]

    static let comment = ZeplinComment(id: "5dbad85a89ea51c1f35bcffe",
                                       author: ZeplinKitMocks.user,
                                       content: "Hey ho! Let's go!",
                                       updated: 1_572_347_818.0)

    static let note = ZeplinNote(id: "5dbad85a76ea51c1f35b6f69",
                                 order: "1",
                                 color: ZeplinKitMocks.color,
                                 position: ZeplinNotePosition(originX: 0.93, originY: 0.1),
                                 comments: [ZeplinKitMocks.comment],
                                 creator: ZeplinKitMocks.user,
                                 status: .open,
                                 created: 1_572_347_818.0)

    static let member = ZeplinProjectMember(user: ZeplinKitMocks.user, role: .owner)

    static let zeplinAPIConfiguration = MockZeplinAPIConfiguration()
}
