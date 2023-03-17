//
//  Errors.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/17/23.
//

import Foundation

enum FirebaseErrors : Error {
    case FetchingPostsError
    case NilImageData
    case NilDownloadURL
    case DocumentWritingError
    case ImageUploadingError
    case DeletingPostError
    case ImageDeletionError
    case PermissionDenied
    case CreatingUserError
    case AddingDisplayNameError
    case LoginError
    case SignOutError
}
