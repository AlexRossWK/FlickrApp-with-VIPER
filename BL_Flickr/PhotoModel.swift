//
//  PhotoModel.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation
import UIKit

class PhotoModel {
    
    let secret: String
    let server: String
    let photoId: String
    let farm: Int
    let title: String
    
    var smallPhotoUrl: URL {
        return createFlickrImageURL()
    }
    
    var largePhotoUrl: URL {
        return createFlickrImageURL(size: "b")
    }
    
    //URL for photo
    private func createFlickrImageURL(size: String = "m") -> URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }
    
    init(secret: String, server: String, photoId: String, farm: Int, title: String) {

        self.secret = secret
        self.server = server
        self.photoId = photoId
        self.farm = farm
        self.title = title

    }
    
}
