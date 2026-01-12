//
//  ScreenVersionTests.swift
//  
//
//  Created by Ilian Konchev on 8.02.22.
//

@testable import Fetcher
import XCTest
@testable import ZeplinKit

final class ScreenVersionTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testScreenVersionsList() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getScreenVersions
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id

        // WHEN
        let response: [ZeplinScreenVersionSummary] = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/versions?limit=1&offset=0")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        XCTAssertEqual(response.count, 1)
        guard let version = response.first,
              let commit = version.commit,
              let creator = version.creator,
              let commitCreator = commit.author
        else {
            return XCTFail("unable to get the note or the first comment")
        }
        XCTAssertEqual(version.id, "5dbad85a76ea51c1f35b6f69")
        XCTAssertEqual(version.created, 1_572_347_818.0)
        SharedAssertions.assertUser(creator)
        XCTAssertEqual(commit.message, "Update paddings")
        SharedAssertions.assertUser(commitCreator)
        XCTAssertEqual(commit.color?.red, 145)
        XCTAssertEqual(commit.color?.green, 223)
        XCTAssertEqual(commit.color?.blue, 33)
        XCTAssertEqual(commit.color?.alpha, 1.0)
        XCTAssertEqual(version.imageURL, "http://placekitten.com/2560/1920")
        XCTAssertEqual(version.width, 2560.0)
        XCTAssertEqual(version.height, 1920.0)
        XCTAssertEqual(version.density, 2)
        XCTAssertEqual(version.source, "sketch/value")
        XCTAssertEqual(version.backgroundColor?.red, 143)
        XCTAssertEqual(version.backgroundColor?.green, 152)
        XCTAssertEqual(version.backgroundColor?.blue, 5)
        XCTAssertEqual(version.backgroundColor?.alpha, 1.0)
    }

    func testScreenVersionFetch() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getScreenVersion
        let projectId = ZeplinKitMocks.project.id
        let screenId = ZeplinKitMocks.screen.id

        // WHEN
        let version: ZeplinScreenVersion = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/projects/\(projectId)/screens/\(screenId)/versions/latest")
        XCTAssertEqual(sut.apiURL.requestMethod, "GET")
        guard let creator = version.creator,
              let commit = version.commit,
              let commitAuthor = commit.author,
              let grid = version.grid,
              let backgroundColor = version.backgroundColor
        else {
            return XCTFail("unable to get the versiion creator")
        }
        XCTAssertEqual(version.id, "5dbad85a76ea51c1f35b6f69")
        SharedAssertions.assertUser(creator)
        SharedAssertions.assertUser(commitAuthor)
        XCTAssertEqual(commit.message, "Update paddings")
        XCTAssertEqual(commit.color?.red, 145)
        XCTAssertEqual(commit.color?.green, 223)
        XCTAssertEqual(commit.color?.blue, 33)
        XCTAssertEqual(commit.color?.alpha, 1.0)
        XCTAssertEqual(version.width, 2560.0)
        XCTAssertEqual(version.height, 1920.0)
        XCTAssertEqual(version.density, 2.0)
        XCTAssertEqual(version.source, "sketch/value")
        XCTAssertEqual(version.imageURL, "http://placekitten.com/2560/1920")
        XCTAssertEqual(backgroundColor.red, 143)
        XCTAssertEqual(backgroundColor.green, 152)
        XCTAssertEqual(backgroundColor.blue, 5)
        XCTAssertEqual(backgroundColor.alpha, 1.0)
        XCTAssertEqual(grid.horizontalOffset, 0.0)
        XCTAssertEqual(grid.verticalOffset, 0.0)
        XCTAssertEqual(grid.horizontalGrid?.gutterHeight, 12.0)
        XCTAssertEqual(grid.horizontalGrid?.numberOfRows, 6)
        XCTAssertEqual(grid.horizontalGrid?.rowHeight, 60.0)
        XCTAssertEqual(grid.verticalGrid?.guttersOnOutside, true)
        XCTAssertEqual(grid.verticalGrid?.columnWidth, 60.0)
        XCTAssertEqual(grid.verticalGrid?.numberOfColumns, 12)
        XCTAssertEqual(grid.verticalGrid?.gutterWidth, 20.0)
        XCTAssertEqual(version.links.first?.rect.originX, 0.0)
        XCTAssertEqual(version.links.first?.rect.originY, 0.0)
        XCTAssertEqual(version.links.first?.rect.width, 40.0)
        XCTAssertEqual(version.links.first?.rect.height, 40.0)
        XCTAssertEqual(version.links.first?.destination.name, "Artboard")
        XCTAssertEqual(version.links.first?.destination.type, "screen")
        XCTAssertEqual(version.layers.first?.id, "5db81e73e1e36ee19f138c1a")
        XCTAssertEqual(version.layers.first?.type, .shape)
        XCTAssertEqual(version.layers.first?.name, "First rectangle in group")
        XCTAssertEqual(version.layers.first?.rect.originX, 0.0)
        XCTAssertEqual(version.layers.first?.rect.originY, 0.0)
        XCTAssertEqual(version.layers.first?.rect.width, 40.0)
        XCTAssertEqual(version.layers.first?.rect.height, 40.0)
        XCTAssertEqual(version.layers.first?.rect.absolute.originX, 0.0)
        XCTAssertEqual(version.layers.first?.rect.absolute.originY, 0.0)
        XCTAssertEqual(version.layers.first?.fills?.first?.type, .color)
        XCTAssertEqual(version.layers.first?.fills?.first?.color?.red, 143)
        XCTAssertEqual(version.layers.first?.fills?.first?.color?.green, 152)
        XCTAssertEqual(version.layers.first?.fills?.first?.color?.blue, 5)
        XCTAssertEqual(version.layers.first?.fills?.first?.color?.alpha, 1.0)
        XCTAssertEqual(version.layers.first?.borders?.first?.thickness, 1.0)
        XCTAssertEqual(version.layers.first?.borders?.first?.position, .inside)
        XCTAssertEqual(version.layers.first?.borders?.first?.fill?.type, .color)
        XCTAssertEqual(version.layers.first?.borders?.first?.fill?.color?.red, 143)
        XCTAssertEqual(version.layers.first?.borders?.first?.fill?.color?.green, 152)
        XCTAssertEqual(version.layers.first?.borders?.first?.fill?.color?.blue, 5)
        XCTAssertEqual(version.layers.first?.borders?.first?.fill?.color?.alpha, 1.0)
        XCTAssertEqual(version.layers.first?.opacity, 1.0)
        XCTAssertEqual(version.layers.first?.blendMode, "normal")
        XCTAssertEqual(version.layers.first?.borderRadius, 0.0)
        XCTAssertEqual(version.layers.first?.rotation, 0.0)
        XCTAssertEqual(version.layers.first?.exportable, false)
        XCTAssertEqual(version.assets.first?.layerSourceID, "55CC0025-C3C1-429E-92B2-610D56368473")
        XCTAssertEqual(version.assets.first?.displayName, "rectangle")
        XCTAssertEqual(version.assets.first?.layerName, "Rectangle")
        XCTAssertEqual(version.assets.first?.contents.first?.url, "http://placekitten.com/100/200")
        XCTAssertEqual(version.assets.first?.contents.first?.format, .png)
        XCTAssertEqual(version.assets.first?.contents.first?.density, 1.0)
    }
}
