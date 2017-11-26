//
//  PhotoSearchPresenter.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import UIKit

//VC -> Presenter, Interactor -> Presenter
protocol PhotoSearchPresenterInput: PhotoVCOutput, PhotoSearchInteractorOutput {
    
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    var interactor: PhotoSearchInteractorInput!
    var view: PhotoVCInput!
    var router: photoSearchRouterInput!
    
    func fetchPhotos(tag: String, page: Int) {
        if view.getPhotoCount() == 0 {
            view.showWaitingView()
        }
        
        interactor.fetchAllPhotosFromDataManager(tag: tag, page: page)
    }
    
    func providedPhotos(photos: [PhotoModel], totalPages: Int) {
        
        view.hideWaitingView()
        
        self.view.displayFetchedPhotos(photos: photos, totalPages: totalPages)
    }
    
    func serviceError(){
        self.view.diplayErrorView(message: "error")
    }
    
    
    func goToPhotoDetailView() {
        self.router.goToPhotoDetail()
    }
    
    
    
    func passPhotoToDetailViewContr(_ segue: UIStoryboardSegue) {
        self.router.passPhotoToDetailViewContrRout(segue)
        
    }
    
}
