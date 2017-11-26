

import Foundation
//VC -> Presenter
protocol PhotoDetailPresenterInput: PhotoDetailVCOutput {
    
}

class PhotoDetailsPresenter: PhotoDetailPresenterInput {
    var photo: PhotoModel!
    //Presenter -> VC
    weak var view: PhotoDetailVCInput!
    
//Router(mainVC)->Presenter(PhotoDetailVC)
    func saveSelectedPhotoFromRouter(photo: PhotoModel) {
        self.photo = photo
    }
    
    func finalPhotoSend() {
        self.view.addPhoto(photo: photo)
    }
    
}
