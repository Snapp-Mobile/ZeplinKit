//
//  ZeplinKitURLMock.swift
//
//
//  Created by Ilian Konchev on 9.02.22.
//

import Fetcher
import Foundation
import ZeplinKit

enum ZeplinKitURLMock: String, CaseIterable {
    case getScreen, getScreens, getProject, getProjects, getNotes, getCurrentUser, getProjectMembers, getSections,
        getScreenVersions, getNotifications, updateNotification, updateNotifications, flagNotificationsAsUnread,
        getScreenVersion, inviteMember, updateMemberRole, removeMember, getToken, refreshToken,
        getNote, createNote, updateNote, createComment, updateComment

    var apiURL: APIURL {
        switch self {
        case .getScreen:
            return ZeplinAPIURL.getScreen(ZeplinKitMocks.project.id, ZeplinKitMocks.screen.id)
        case .getScreens:
            return ZeplinAPIURL.getScreens(ZeplinKitMocks.project, 1, 0)
        case .getProject:
            return ZeplinAPIURL.getProject(ZeplinKitMocks.project.id)
        case .getProjects:
            return ZeplinAPIURL.getProjects(1, 0)
        case .getNotes:
            return ZeplinAPIURL.getNotes(ZeplinKitMocks.project, ZeplinKitMocks.screen, 1, 0)
        case .getCurrentUser:
            return ZeplinAPIURL.getCurrentUser
        case .getProjectMembers:
            return ZeplinAPIURL.getProjectMembers(ZeplinKitMocks.project, 1, 0)
        case .getSections:
            return ZeplinAPIURL.getSections(ZeplinKitMocks.project, 1, 0)
        case .getScreenVersions:
            return ZeplinAPIURL.getScreenVersions(ZeplinKitMocks.project, ZeplinKitMocks.screen, 1, 0)
        case .getNotifications:
            return ZeplinAPIURL.getNotifications(1, 0)
        case .updateNotification:
            return ZeplinAPIURL.flagNotificationAsRead(ZeplinKitMocks.notificationId)
        case .updateNotifications:
            return ZeplinAPIURL.updateReadState(ZeplinKitMocks.notifications, true)
        case .flagNotificationsAsUnread:
            return ZeplinAPIURL.updateReadState(ZeplinKitMocks.notificationsAlt, false)
        case .getScreenVersion:
            return ZeplinAPIURL.getScreenVersion(ZeplinKitMocks.project.id, ZeplinKitMocks.screen.id, "latest")
        case .inviteMember:
            return ZeplinAPIURL.inviteMember(ZeplinKitMocks.organization, ZeplinKitMocks.user.email)
        case .updateMemberRole:
            return ZeplinAPIURL.updateMemberRole(ZeplinKitMocks.organization, ZeplinKitMocks.member, .admin)
        case .removeMember:
            return ZeplinAPIURL.removeMember(ZeplinKitMocks.organization, ZeplinKitMocks.member)
        case .getToken:
            return ZeplinAPIURL.getToken(ZeplinKitMocks.code, ZeplinKitMocks.zeplinAPIConfiguration)
        case .refreshToken:
            return ZeplinAPIURL.refreshToken(ZeplinKitMocks.zeplinAPIConfiguration)
        case .getNote:
            return ZeplinAPIURL.getNote(ZeplinKitMocks.project, ZeplinKitMocks.screen, ZeplinKitMocks.note.id)
        case .createNote:
            return ZeplinAPIURL.addNote(ZeplinKitMocks.addNoteRequest)
        case .updateNote:
            return ZeplinAPIURL.updateNote(ZeplinKitMocks.updateNoteRequest)
        case .createComment:
            return ZeplinAPIURL.addComment(ZeplinKitMocks.addCommentRequest)
        case .updateComment:
            return ZeplinAPIURL.updateComment(ZeplinKitMocks.updateCommentRequest)
        }
    }

    var responseCode: Int {
        switch self {
        case .createNote, .inviteMember, .createComment:
            return 201
        case .updateNote, .updateComment, .updateNotification, .updateNotifications, .flagNotificationsAsUnread, .updateMemberRole,
            .removeMember:
            return 204
        default:
            return 200
        }
    }

    var fileName: String? {
        switch self {
        case .updateNote, .updateComment, .updateNotification, .updateNotifications, .flagNotificationsAsUnread, .updateMemberRole,
            .removeMember:
            return "emptyResponse"
        default:
            return rawValue
        }
    }

}
