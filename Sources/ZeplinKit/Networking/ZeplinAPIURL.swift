//
//  ZeplinAPIURL.swift
//  
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Fetcher
import Foundation

public typealias ProjectId = String
public typealias ScreenId = String
public typealias VersionId = String
public typealias NoteId = String
public typealias AccessCode = String
public typealias EmailAddress = String
public typealias Limit = Int
public typealias Offset = Int

public enum ZeplinAPIURL: APIURL {
    case getToken(AccessCode, ZeplinAPIConfiguration)
    case refreshToken(ZeplinAPIConfiguration)
    case getCurrentUser
    case getProjects(Limit, Offset)
    case getProject(ProjectId)
    case getProjectMembers(ZeplinProject, Limit, Offset)
    case inviteMember(ZeplinOrganizationSummary, EmailAddress)
    case updateMemberRole(ZeplinOrganizationSummary, ZeplinProjectMember, ZeplinRole)
    case removeMember(ZeplinOrganizationSummary, ZeplinProjectMember)
    case getScreens(ZeplinProject, Limit, Offset)
    case getScreen(ProjectId, ScreenId)
    case getSections(ZeplinProject, Limit, Offset)
    case getScreenVersions(ZeplinProject, ZeplinScreen, Limit, Offset)
    case getNotes(ZeplinProject, ZeplinScreen, Limit, Offset)
    case getNote(ZeplinProject, ZeplinScreen, NoteId)
    case addComment(ZeplinAddCommentRequest)
    case updateComment(ZeplinUpdateCommentRequest)
    case addNote(ZeplinAddNoteRequest)
    case updateNote(ZeplinUpdateNoteRequest)
    case getNotifications(Limit, Offset)
    case flagNotificationAsRead(String)
    case updateReadState([ZeplinNotificationRepresentation], Bool)
    case getScreenVersion(ProjectId, ScreenId, VersionId)

    public var path: String {
        switch self {
        case .getToken, .refreshToken:
            return "/oauth/token"
        case let .getProjects(limit, offset):
            return "/projects?limit=\(limit)&offset=\(offset)"
        case let .getProject(projectId):
            return "/projects/\(projectId)"
        case let .getProjectMembers(project, limit, offset):
            return "/projects/\(project.id)/members?limit=\(limit)&offset=\(offset)"
        case let .inviteMember(organization, _):
            return "/organizations/\(organization.id)/members"
        case let .updateMemberRole(organization, member, _):
            return "/organizations/\(organization.id)/members/\(member.user.id)"
        case let .removeMember(organization, member):
            return "/organizations/\(organization.id)/members/\(member.user.id)"
        case let .getScreens(project, limit, offset):
            return "/projects/\(project.id)/screens?sort=section&limit=\(limit)&offset=\(offset)"
        case let .getScreen(projectId, screenId):
            return "/projects/\(projectId)/screens/\(screenId)"
        case let .getSections(project, limit, offset):
            return "/projects/\(project.id)/screen_sections?limit=\(limit)&offset=\(offset)"
        case let .getScreenVersions(project, screen, limit, offset):
            return "/projects/\(project.id)/screens/\(screen.id)/versions?limit=\(limit)&offset=\(offset)"
        case let .getNotes(project, screen, limit, offset):
            return "/projects/\(project.id)/screens/\(screen.id)/notes?limit=\(limit)&offset=\(offset)"
        case let .getNote(project, screen, noteId):
            return "/projects/\(project.id)/screens/\(screen.id)/notes/\(noteId)"
        case let .addNote(request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes"
        case let .getNotifications(limit, offset):
            return "/users/me/notifications?limit=\(limit)&offset=\(offset)"
        case let .flagNotificationAsRead(id):
            return "/users/me/notifications/\(id)"
        case let .updateReadState(representations, _):
            let ids = representations.map(\.id).joined(separator: "&id=")
            return "/users/me/notifications?id=\(ids)"
        case let .updateNote(request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)"
        case let .addComment(request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)/comments"
        case let .updateComment(request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)/comments/\(request.comment.id)"
        case .getCurrentUser:
            return "/users/me"
        case let .getScreenVersion(projectId, screenId, versionId):
            return "/projects/\(projectId)/screens/\(screenId)/versions/\(versionId)"
        }
    }

    public var requestMethod: String {
        switch self {
        case .addComment, .addNote, .getToken, .refreshToken, .inviteMember:
            return "POST"
        case .updateComment, .updateNote, .flagNotificationAsRead, .updateReadState, .updateMemberRole:
            return "PATCH"
        case .removeMember:
            return "DELETE"
        default:
            return "GET"
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    public func bodyParams(token: Token?) -> [String: Any]? {
        switch self {
        case let .getToken(code, configuration):
            return [
                "client_id": configuration.clientId,
                "client_secret": configuration.clientSecret,
                "redirect_uri": configuration.redirectURI,
                "grant_type": "authorization_code",
                "code": code
            ]
        case .refreshToken(let configuration):
            guard let token = token else { return nil }
            return [
                "client_id": configuration.clientId,
                "client_secret": configuration.clientSecret,
                "refresh_token": token.refreshToken,
                "grant_type": "refresh_token"
            ]
        case let .addComment(request):
            return [
                "content": request.content
            ]
        case let .updateComment(request):
            return [
                "content": request.content
            ]
        case let .addNote(request):
            return [
                "content": request.content,
                "position": [
                    "x": request.position.originX,
                    "y": request.position.originY
                ],
                "color": request.color
            ]
        case let .updateNote(request):
            return [
                "status": request.status ?? request.note.status,
                "position": [
                    "x": request.position.originX,
                    "y": request.position.originY
                ],
                "color": request.note.color.name ?? ""
            ]
        case .flagNotificationAsRead:
            return [
                "is_read": true
            ]
        case let .updateReadState(_, isRead):
            return [
                "is_read": isRead
            ]
        case let .inviteMember(_, handle):
            return [
                "handle": handle,
                "role": "member",
                "restricted": true
            ]
        case let .updateMemberRole(_, _, role):
            return [
                "role": role.rawValue
            ]
        default:
            return nil
        }
    }

    public var url: URL? {
        return URL(string: "https://api.zeplin.dev/v1\(path)")
    }

    public func request(token: Token?) -> URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; application/json", forHTTPHeaderField: "Accept")
        request.addValue("UTF-8", forHTTPHeaderField: "Accept-Charset")
        request.httpMethod = requestMethod

        if let token = token {
            request.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }

        if let bodyParams = bodyParams(token: token),
           let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams) {
            request.httpBody = jsonData
        }

        return request
    }
}
