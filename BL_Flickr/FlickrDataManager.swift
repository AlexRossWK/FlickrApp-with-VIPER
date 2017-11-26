//
//  FlickrDataManager.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 24.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol FlickrPhotoSearchProtocol: class {
    func getList(tag: String, page: Int, success: @escaping (_ photos: [PhotoModel] ) -> Void, failure: @escaping (_ errorDescription: String) -> Void)
}

class FlickrDataManager: FlickrPhotoSearchProtocol {
  
     func getList(tag: String, page: Int, success: @escaping (_ photos: [PhotoModel] ) -> Void, failure: @escaping (_ errorDescription: String) -> Void) {
        
        _ = API_WRAPPER.getPopularPhotosList(tag: tag, page: page, success1: { (response) in
            
            var photosArray = [PhotoModel]()
            let jsonResponse = JSON(response)
            
            TotalPages.share.totalAmountOfPages = jsonResponse["photos"]["total"].intValue
            
            let arrayOfJSONPhotos = jsonResponse["photos"]["photo"].arrayValue
            
            for photo in arrayOfJSONPhotos {
                
                let secret = photo["secret"].stringValue
                let server = photo["server"].stringValue
                let photoId = photo["id"].stringValue
                let farm = photo["farm"].intValue
                let title = photo["title"].stringValue
                
                let newPhoto = PhotoModel(secret: secret, server: server, photoId: photoId, farm: farm, title: title)
                
                
                photosArray.append(newPhoto)
                
            }
            
            success(photosArray)
            
            
        }) { (errorDescrption) in
            
            failure(errorDescrption)
            
        }
        
    }
    

    
}
