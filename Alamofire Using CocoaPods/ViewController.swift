//
//  ViewController.swift
//  Alamofire Using CocoaPods
//
//  Created by Sharetrip-iOS on 18/08/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://httpbin.org/get"
        
        //Simple request
        AF.request(urlString).response { (response) in
            debugPrint(response)
        }
        
        //Request with method get,post,put,delete
        AF.request(urlString,method: .get).response { (response) in
            debugPrint(response)
        }
        AF.request(urlString,method: .post).response { (response) in
            debugPrint(response)
        }
        AF.request(urlString,method: .put).response { (response) in
            debugPrint(response)
        }
        AF.request(urlString,method: .delete).response { (response
        ) in
            debugPrint(response)
        }
        
        
        //Requeest with parameter
        let parameter = ["category":"Movies","genre":"Action"]
        AF.request(urlString,parameters: parameter).response { (response) in
            debugPrint(response)
        }
        
        
        //Http Headers
        let headers : HTTPHeaders = [.authorization(username: "test@gmail.com", password: "testpassword"),.accept("application/json")]
        
        
        AF.request(urlString,parameters: parameter, headers: headers).responseJSON { (response) in
           debugPrint(response)
        }
        
        //Authentication using Credential
        
        let user = "test@gmail.com"
        let pw = "testpassword"
        
        let credential = URLCredential(user: user, password: pw, persistence: .forSession)
        AF.request("https://httpbin.org/basic-auth/\(user)/\(pw)").authenticate(with: credential).responseJSON { (response) in
            debugPrint(response)
        }
        
        
        
        //Basic Response
        AF.request(urlString).response { (response) in
            debugPrint(response)
        }
        
        //JSONResponse
        
        AF.request(urlString).responseJSON { (response) in
            debugPrint(response)
        }
        
        //Data Response
        
        AF.request(urlString).responseData { (response) in
            debugPrint(response)
        }
        
        //String Response
        
        AF.request(urlString).responseString { (response) in
            debugPrint(response)
        }
        
        //Decodable Response
        
        struct urlStruct : Decodable{
            
            let url : String
        }
        
        AF.request(urlString).responseDecodable(of: urlStruct.self) { (response) in
            debugPrint(response)
        }
        
        //Download data in memory
//        AF.download("https://httpbin.org/image/png").responseData { (response) in
//            if let data = response.value{
//                self.imageView.image = UIImage(data: data)
//            }
//
//        }
        
        //Download Locally
        
        let destination : DownloadRequest.Destination = {_,_ in
            let fileUrl = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0].appendingPathComponent("image.png")
            return (fileUrl,[.removePreviousFile,.createIntermediateDirectories])
            
            
    
        }
        
        AF.download("https://httpbin.org/image/png",to: destination).response { (response) in
            
            if response.error == nil,let imgPath = response.fileURL?.path{
                let image = UIImage(contentsOfFile: imgPath)
                self.imageView.image = image
            }
        }
        
        //Upload file
        
        let fileUrl = Bundle.main.url(forResource: "video", withExtension: "mp4")
        
        guard  let url = fileUrl else {
            return
        }
        AF.upload(url, to: "https://httpbin.org/post").responseJSON { (response) in
            debugPrint(response)
        }
        
        
       
    }


}

