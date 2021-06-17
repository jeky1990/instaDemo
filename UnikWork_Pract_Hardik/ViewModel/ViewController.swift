
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var InstagramTableView: UITableView!
    let child = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        APIManager.sharedInstance.vc = self
        APIManager.sharedInstance.fetchDataFromURL(url: INSTA_DATA_FETCH_URL)
       
    }
    //MARK:- register table view cell
    func registerTableViewCell(){
        self.InstagramTableView.register(UINib(nibName: TABLEVIEW_CELL_IDENT, bundle: nil), forCellReuseIdentifier: TABLEVIEW_CELL_IDENT)
    }
    
    //MARK:- Start api call progress indicator
    func startAnimatingProgressView() {
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    //MARK:- stop progress indicator
    func stopAnimation() {
        // wait two seconds to simulate some work happening
        DispatchQueue.main.async {
            // then remove the spinner view controller
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}

//MARK:- TableView Delegate and DataSource
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIManager.sharedInstance.InstagramArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TABLEVIEW_CELL_IDENT, for: indexPath) as? InstagramCell{
            if APIManager.sharedInstance.InstagramArray.count > indexPath.count{
                let data = APIManager.sharedInstance.InstagramArray[indexPath.row]
                cell.configCellData(data: data)
                
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

