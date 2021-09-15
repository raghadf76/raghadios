//
//  ViewController.swift
//  iosexercise
//
//  Created by Raghad alfuhaid on 07/02/1443 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    
    
//    final let urlString = "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise"
    
    
    final let url = URL(string:"https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise")
    
     var articles = [Article]()
    
//    var titleArray = [String]()
//    var authorArray = [String]()
//    var contentArray = [String]()
//    var dateArray = [String]()
//    var webArray = [String]()
//    var imgURLArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.downloadJsonWithURL()
        
        downloadJson()

    }
    
    func downloadJson() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedArticles = try decoder.decode(Articles.self, from: data)
                
//                print(downloadedArticles.articles[0].authors)
                self.articles = downloadedArticles.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    
    
    
    
    
    
//    func downloadJsonWithURL() {
//        let url = NSURL(string: urlString)
//        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
//
//            print(data)
//
//
//            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//                print(jsonObj.value(forKey: "articles"))
//
//                if let articleArray = jsonObj.value(forKey: "articles") as? NSArray {
//                                    for article in articleArray {
//                                        if let articleDict =  article as? NSDictionary {
//                                            if let title = articleDict.value(forKey: "title") {
//                                                self.titleArray.append(title as! String)
//                                            }
//                                            if let author = articleDict.value(forKey: "authors") {
//                                                self.authorArray.append(author as! String)
//                                            }
//                                            if let img = articleDict.value(forKey: "image_url") {
//                                                self.imgURLArray.append(img as! String)
//                                            }
//
//                                            if let content = articleDict.value(forKey: "content") {
//                                                self.contentArray.append(content as! String)
//                                            }
//
//
//                                            if let date = articleDict.value(forKey: "date") {
//                                                self.dateArray.append(date as! String)
//                                            }
//
//                                            if let web = articleDict.value(forKey: "website") {
//                                                self.webArray.append(web as! String)
//                                            }
//
//
//                                        }
//
//                                    }
//
//
//                                }
//
//
//
//                OperationQueue.main.addOperation({
//                    self.tableView.reloadData()
//                })
//
//
//            }
//
//
//        }).resume()
//    }
    
    
//    func downloadJsonWithTask() {
//
//        let url = NSURL(string: urlString)
//
//        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
//
//        downloadTask.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
//
//            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//
//            print(jsonData)
//
//        }).resume()
//    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//
//
//
//        cell.cellTitleLabel.text = titleArray[indexPath.row]
//        cell.authorLabel.text = authorArray[indexPath.row]
//        cell.contentLabel.text = contentArray[indexPath.row]
///       cell.dateLabel.text = dateArray[indexPath.row]
//        cell.webLabel.text = webArray[indexPath.row]
//
//
//
//
//       let imgURL = NSURL(string: imgURLArray[indexPath.row])
//
//       print(imgURL)
//
//       if imgURL != nil {
//          let data = NSData(contentsOf: (imgURL as URL?)!)
//          cell.imageViewCell.image = UIImage(data: data! as Data)
//        }
//
//
//
//
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        
        cell.cellTitleLabel.text = articles[indexPath.row].title
        cell.authorLabel.text = articles[indexPath.row].authors
        cell.contentLabel.text = articles[indexPath.row].content
        cell.dateLabel.text = articles[indexPath.row].date
        cell.webLabel.text = articles[indexPath.row].website
        
        
//        cell.contentView.backgroundColor = UIColor.darkGray
//        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: articles[indexPath.row].image_url) {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageViewCell.image = image
                    }
                }
            }
        }
        return cell
    }
    
    


}

