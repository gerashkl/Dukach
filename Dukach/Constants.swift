import Foundation

struct Const {
   
    enum userAuthErrorMessage:String{
        case emptyField = "Not all fields are filled"
    }
    
    enum authSwitcher{
        case registration
        case login
    }
    static let unownName = "unown name"

    enum entity:String{
        case movie = "&entity=movie"
    }


    enum actionCase{
        case mediaInRealm
        case needSaveInRealm
        case needRemoveFromRealm
    }
    

    
    struct Request {
        
        static let errorMovieURL = "https://example.com/my-example-video.m3u8"

        static  let baseUrl = "https://itunes.apple.com/search?term="
    }
    
    

    
    static func bildSearchMovieUrl(SearchText:String) -> String{
        let SearchText = SearchText.replacingOccurrences(of: " ", with: "+")
        let url:String = Const.Request.baseUrl+SearchText+Const.entity.movie.rawValue
            return url
        }
}
