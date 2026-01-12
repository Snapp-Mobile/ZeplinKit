//
//  SharedAssertions.swift
//
//
//  Created by Ilian Konchev on 8.02.22.
//

import XCTest
import ZeplinKit

final class SharedAssertions {
    static func assertNote(_ note: ZeplinNote) {
        let expected = ZeplinKitMocks.note
        XCTAssertEqual(note.id, expected.id)
        XCTAssertEqual(note.order, expected.order)
        XCTAssertEqual(note.color, expected.color)
        XCTAssertEqual(note.position, expected.position)
        XCTAssertEqual(note.comments.count, 1)
        XCTAssertEqual(note.comments, expected.comments)
        guard let author = note.comments.first?.author else {
            return XCTFail("Unable to assert the author of the first comment in the note")
        }
        SharedAssertions.assertUser(author)
        SharedAssertions.assertUser(note.creator)
        XCTAssertEqual(note.status, expected.status)
        XCTAssertEqual(note.created, expected.created)
    }

    static func assertUser(_ user: ZeplinUser) {
        let expected = ZeplinKitMocks.user
        XCTAssertEqual(user.id, expected.id)
        XCTAssertEqual(user.email, expected.email)
        XCTAssertEqual(user.username, expected.username)
        XCTAssertEqual(user.avatarURL, expected.avatarURL)
        XCTAssertEqual(user.lastSeen, expected.lastSeen)
        XCTAssertEqual(user.emotar, expected.emotar)
    }

    static func assertProject(_ project: ZeplinProject) {
        let expected = ZeplinKitMocks.project
        XCTAssertEqual(project.id, expected.id)
        XCTAssertEqual(project.name, expected.name)
        XCTAssertEqual(project.description, expected.description)
        XCTAssertEqual(project.thumbnailURL, expected.thumbnailURL)
        XCTAssertEqual(project.platform, expected.platform)
        XCTAssertEqual(project.status, expected.status)
        XCTAssertEqual(project.created, expected.created)
        XCTAssertEqual(project.updated, expected.updated)
        XCTAssertEqual(project.numberOfScreens, expected.numberOfScreens)
        XCTAssertEqual(project.numberOfComponents, expected.numberOfComponents)
        XCTAssertEqual(project.numberOfTextStyles, expected.numberOfTextStyles)
        XCTAssertEqual(project.numberOfColors, expected.numberOfColors)
        XCTAssertEqual(project.numberOfMembers, expected.numberOfMembers)
        XCTAssertEqual(project.linkedStyleguide?.id, expected.linkedStyleguide?.id)
    }

    static func assertScreen(_ screen: ZeplinScreen) {
        let expected = ZeplinKitMocks.screen
        XCTAssertEqual(screen.id, expected.id)
        XCTAssertEqual(screen.name, expected.name)
        XCTAssertEqual(screen.description, expected.description)
        XCTAssertEqual(screen.created, expected.created)
        XCTAssertEqual(screen.updated, expected.updated)
        XCTAssertEqual(screen.image.width, expected.image.width)
        XCTAssertEqual(screen.image.height, expected.image.height)
        XCTAssertEqual(screen.image.originalURL, expected.image.originalURL)
        XCTAssertNil(screen.backgroundColor)
        XCTAssertEqual(screen.section?.id, expected.section?.id)
        XCTAssertEqual(screen.tags, expected.tags)
        XCTAssertEqual(screen.numberOfNotes, expected.numberOfNotes)
        XCTAssertEqual(screen.numberOfVersions, expected.numberOfVersions)
    }
}
