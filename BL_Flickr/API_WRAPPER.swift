
import UIKit

struct API_WRAPPER {
    
}


//MARK: - GET PHOTO REQUESTS
extension API_WRAPPER {
    
    static func getPopularPhotosList(tag: String, page: Int, success1 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) -> URLSessionDataTask {
        
        

        
        let url = Constants.API_URLS.baseURL
        let params : [String: Any] = ["method" : "flickr.photos.search",
                                      "api_key" : Constants.API_params.apiKey,
                                      "tags": "\(tag)",
                                      "per_page": "",
                                      "page": "\(page)",
                                      "format": "json",
                                      "nojsoncallback": 1]
        
        
        let request = API_Configurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(withData: data, withError: error, success: success1, failure: failure)
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
}




