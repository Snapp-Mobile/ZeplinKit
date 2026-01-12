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
        case .getProjects(let limit, let offset):
            return "/projects?limit=\(limit)&offset=\(offset)"
        case .getProject(let projectId):
            return "/projects/\(projectId)"
        case .getProjectMembers(let project, let limit, let offset):
            return "/projects/\(project.id)/members?limit=\(limit)&offset=\(offset)"
        case .inviteMember(let organization, _):
            return "/organizations/\(organization.id)/members"
        case .updateMemberRole(let organization, let member, _):
            return "/organizations/\(organization.id)/members/\(member.user.id)"
        case .removeMember(let organization, let member):
            return "/organizations/\(organization.id)/members/\(member.user.id)"
        case .getScreens(let project, let limit, let offset):
            return "/projects/\(project.id)/screens?sort=section&limit=\(limit)&offset=\(offset)"
        case .getScreen(let projectId, let screenId):
            return "/projects/\(projectId)/screens/\(screenId)"
        case .getSections(let project, let limit, let offset):
            return "/projects/\(project.id)/screen_sections?limit=\(limit)&offset=\(offset)"
        case .getScreenVersions(let project, let screen, let limit, let offset):
            return "/projects/\(project.id)/screens/\(screen.id)/versions?limit=\(limit)&offset=\(offset)"
        case .getNotes(let project, let screen, let limit, let offset):
            return "/projects/\(project.id)/screens/\(screen.id)/notes?limit=\(limit)&offset=\(offset)"
        case .getNote(let project, let screen, let noteId):
            return "/projects/\(project.id)/screens/\(screen.id)/notes/\(noteId)"
        case .addNote(let request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes"
        case .getNotifications(let limit, let offset):
            return "/users/me/notifications?limit=\(limit)&offset=\(offset)"
        case .flagNotificationAsRead(let id):
            return "/users/me/notifications/\(id)"
        case .updateReadState(let representations, _):
            let ids = representations.map(\.id).joined(separator: "&id=")
            return "/users/me/notifications?id=\(ids)"
        case .updateNote(let request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)"
        case .addComment(let request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)/comments"
        case .updateComment(let request):
            return "/projects/\(request.project.id)/screens/\(request.screen.id)/notes/\(request.note.id)/comments/\(request.comment.id)"
        case .getCurrentUser:
            return "/users/me"
        case .getScreenVersion(let projectId, let screenId, let versionId):
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
        case .getToken(let code, let configuration):
            return [
                "client_id": configuration.clientId,
                "client_secret": configuration.clientSecret,
                "redirect_uri": configuration.redirectURI,
                "grant_type": "authorization_code",
                "code": code,
            ]
        case .refreshToken(let configuration):
            guard let token = token else { return nil }
            return [
                "client_id": configuration.clientId,
                "client_secret": configuration.clientSecret,
                "refresh_token": token.refreshToken,
                "grant_type": "refresh_token",
            ]
        case .addComment(let request):
            return [
                "content": request.content
            ]
        case .updateComment(let request):
            return [
                "content": request.content
            ]
        case .addNote(let request):
            return [
                "content": request.content,
                "position": [
                    "x": request.position.originX,
                    "y": request.position.originY,
                ],
                "color": request.color,
            ]
        case .updateNote(let request):
            return [
                "status": request.status ?? request.note.status,
                "position": [
                    "x": request.position.originX,
                    "y": request.position.originY,
                ],
                "color": request.note.color.name ?? "",
            ]
        case .flagNotificationAsRead:
            return [
                "is_read": true
            ]
        case .updateReadState(_, let isRead):
            return [
                "is_read": isRead
            ]
        case .inviteMember(_, let handle):
            return [
                "handle": handle,
                "role": "member",
                "restricted": true,
            ]
        case .updateMemberRole(_, _, let role):
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
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams)
        {
            request.httpBody = jsonData
        }

        return request
    }
}
