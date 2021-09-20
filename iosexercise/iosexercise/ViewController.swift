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
    var articlesWithoutNull = [Article]()
    var exeTitle : String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        tableView.tableFooterView = UIView()
        tableView.dataSource=self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Each row should be the right height to display its own content and no taller. No content  should be clipped. This means some rows will be larger than others.
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
            
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedArticles = try decoder.decode(Articles.self, from: data)
                print(downloadedArticles.title)
                self.articles = downloadedArticles.articles


                // delete the null value
                let actualArticleNum = self.articles.count
                var stopLoop = 0
                var stopSecondLoop = 0
                while(stopLoop<actualArticleNum ){
                  
                    if(downloadedArticles.articles[stopLoop].title != ""){
                       
                        self.articlesWithoutNull.append(downloadedArticles.articles[stopLoop])
                        print(self.articlesWithoutNull[stopLoop] )

                    }
                    
                    stopLoop=stopLoop+1
                    stopSecondLoop=stopSecondLoop+1
                }
            
            // sorted the array
            self.articlesWithoutNull=self.sortArticles(articlesWithoutNull)
                

            DispatchQueue.main.async {
                self.title=downloadedArticles.title
                    self.tableView.reloadData()
//                print(self.articlesWithoutNull.count)
                }
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    
    
    
    
    // The sort orders are primarily based on the created date, title, and author of the article.
    
    func sortArticles(_ articlesWithoutNull: [Article]) -> [Article] {
        articlesWithoutNull.sorted { articleA, articleB in
            if articleA.date == articleB.date  {
                
                if articleA.title == articleB.title{
                    return articleA.authors < articleB.authors
                }
                
                else{
                    return articleA.title < articleB.title
                }
                
            }
            return articleA.date > articleB.date

            
        }
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articlesWithoutNull.count)
        return articlesWithoutNull.count
        
    }
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.cellTitleLabel.text = articlesWithoutNull[indexPath.row].title
        cell.authorLabel.text = "Author : "  + articlesWithoutNull[indexPath.row].authors
        
        cell.dateLabel.text = "Date : "  + articlesWithoutNull[indexPath.row].date
  
        
        if let imageURL = URL(string: articlesWithoutNull[indexPath.row].image_url) {
            DispatchQueue.global().async {
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
    

    
    // go to details screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? DetailsViewController{
            destination.articleDetails = articlesWithoutNull[(tableView.indexPathForSelectedRow?.row)!]
        }
        
        
    }

}

