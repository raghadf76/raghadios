//
//  ViewController.swift
//  iosexercise
//
//  Created by Raghad alfuhaid on 07/02/1443 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    final let url = URL(string:"https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise")
    
     var articles = [Article]()
    var exeTitle : String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadJson()
        tableView.tableFooterView = UIView()
//        tableView.delegate=self
        tableView.dataSource=self
        
//        self.title = "iOS Exercise"
        
//            "iOS Exercise"
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight=UITableView.automaticDimension
        


    }
    
    func downloadJson() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { [self] data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                
                return
            }
            
            

            
            
//            print(decoder.decode(Articles.self, from: data))
            
            
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                
                
                let downloadedArticles = try decoder.decode(Articles.self, from: data)
                
                
                
                
                print(downloadedArticles.title)
                self.articles = downloadedArticles.articles
                
                                
                
//                for i in articles{
//                    if(downloadedArticles.articles[i].authors == " "){
//
//
//                    }
//                }
                

            DispatchQueue.main.async {
                self.title=downloadedArticles.title
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.cellTitleLabel.text = articles[indexPath.row].title
        cell.authorLabel.text = " Author : "  + articles[indexPath.row].authors
        
        cell.dateLabel.text = " Date : "  + articles[indexPath.row].date
  
        
        if let imageURL = URL(string: articles[indexPath.row].image_url) {
//            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {

                        cell.imageViewCell.image = image
                    }
                }
//            }
        }
        
        
        
  


        
        
//        cell.contentView.backgroundColor = UIColor.darkGray
//        cell.backgroundColor = UIColor.darkGray
        
        let imageView = UIImageView(frame: CGRect(x: 190, y: 70, width: cell.frame.width - 160, height: cell.frame.height - 30))
        let image = UIImage(named: "threeCircle")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        
       
        
       
        


        return cell
    }
    
    
    
   
    
    
    
    


//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? DetailsViewController{
            destination.articleDetails = articles[(tableView.indexPathForSelectedRow?.row)!]
        }
        
        
    }

}

