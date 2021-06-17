
import Foundation
import UIKit

class APIManager{
    
    //Singletone instance
    static let sharedInstance = APIManager()
    
    //Store data array
    var InstagramArray = [InstagramData]()
    
    //pass controller ref for update UIView
    var vc = ViewController()
    
    //get All post data
    func fetchDataFromURL(url : String){
        if let url = URL(string: url){
            vc.startAnimatingProgressView()
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    do {
                        if let fetchData = data{
                            let data = try JSONDecoder().decode([InstagramData].self, from: fetchData)
                            self.InstagramArray = data
                            DispatchQueue.main.async {
                                self.vc.stopAnimation()
                                self.vc.InstagramTableView.reloadData()
                            }
                        }
                    } catch let err {
                        print(err.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
