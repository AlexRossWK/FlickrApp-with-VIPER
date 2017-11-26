//
//  PhotoSearchInteractor.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation
//Data manager -> Interactor
protocol PhotoSearchInteractorInput: class {
    func fetchAllPhotosFromDataManager(tag: String, page: Int)
}

//Interactor -> Presenter
protocol PhotoSearchInteractorOutput: class {
    func providedPhotos(photos: [PhotoModel], totalPages: Int)
    func serviceError()
}
class PhotoSearchInteractor: PhotoSearchInteractorInput {
    //Interactor -> Presenter
    weak var presenter: PhotoSearchInteractorOutput!
    
    //Interactor -> Data manager
    var apiDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(tag: String, page: Int) {
        apiDataManager.getList(tag: tag, page: page, success: { (photos) in
            
            self.presenter.providedPhotos(photos: photos, totalPages: TotalPages.share.totalAmountOfPages)
            
        }) { (error) in
            self.presenter.serviceError()
            
            print(error)
        }
    }
}
