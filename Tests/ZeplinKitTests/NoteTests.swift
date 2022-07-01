//
//  NoteTests.swift
//  
//
//  Created by Ilian Konchev on 8.02.22.
//

@testable import Fetcher
import XCTest
@testable import ZeplinKit

final class NoteTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testNotesList() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getNotes
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id

        // WHEN
        let response: [ZeplinNote] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let note = response.first else {
            return XCTFail("unable to get the note")
        }
        SharedAssertions.assertNote(note)
    }

    func testGetNote() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getNote
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id
        let noteId = ZeplinKitMocks.note.id

        // WHEN
        let note: ZeplinNote = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes/\(noteId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        SharedAssertions.assertNote(note)
    }

    func testNoteCreation() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.createNote
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id

        // WHEN
        let response: ZeplinCreateNoteResponse = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes")
        XCTAssertEqual(sut.apiURL.requestMethod, "POST")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token), let position = bodyParams["position"] as? [String: Float] else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["content"] as? String, ZeplinKitMocks.addNoteRequest.content)
        XCTAssertEqual(bodyParams["color"] as? String, ZeplinKitMocks.addNoteRequest.color)
        XCTAssertEqual(position["x"], ZeplinKitMocks.addNoteRequest.position.originX)
        XCTAssertEqual(position["y"], ZeplinKitMocks.addNoteRequest.position.originY)
        XCTAssertEqual(response.id, "5dbad85a76ea51c1f35b6f69")
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 201)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testNoteUpdate() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.updateNote
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id
        let noteId = ZeplinKitMocks.note.id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes/\(noteId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token), let position = bodyParams["position"] as? [String: Float] else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["status"] as? String, ZeplinKitMocks.updateNoteRequest.status)
        XCTAssertEqual(bodyParams["color"] as? String, ZeplinKitMocks.updateNoteRequest.note.color.name)
        XCTAssertEqual(position["x"], ZeplinKitMocks.updateNoteRequest.position.originX)
        XCTAssertEqual(position["y"], ZeplinKitMocks.updateNoteRequest.position.originY)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testCommentCreation() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.createComment
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id
        let noteId = ZeplinKitMocks.note.id

        // WHEN
        let response: ZeplinCreateCommentResponse = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes/\(noteId)/comments")
        XCTAssertEqual(sut.apiURL.requestMethod, "POST")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["content"] as? String, ZeplinKitMocks.addCommentRequest.content)
        XCTAssertEqual(response.id, "5dbad85a76ea51c1f35b6f69")
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 201)
        XCTAssertTrue(isMatchingResponseCode)
    }

    func testCommentUpdate() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.updateComment
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id
        let noteId = ZeplinKitMocks.note.id
        let commentId = ZeplinKitMocks.comment.id

        // WHEN
        let isMatchingResponseCode = try await fetcher.matchHTTPCode(sut.apiURL, code: 204)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/notes/\(noteId)/comments/\(commentId)")
        XCTAssertEqual(sut.apiURL.requestMethod, "PATCH")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["content"] as? String, ZeplinKitMocks.updateCommentRequest.content)
        XCTAssertTrue(isMatchingResponseCode)
    }
}
