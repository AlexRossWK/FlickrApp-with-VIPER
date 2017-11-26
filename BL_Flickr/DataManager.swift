
import Foundation


//singleton
class DataManager {
    //точка входа через которую будем обращаться к снглтону
    static let shared = DataManager()
    
    //vars
    var dataSource = [PhotoModel]()
    
}
