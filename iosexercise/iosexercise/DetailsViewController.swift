//
//  DetailsViewController.swift
//  iosexercise
//
//  Created by Raghad alfuhaid on 09/02/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var articleDetails:Article?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var webLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title=articleDetails!.authors
        
        designCell()
        let screenSize: CGRect = UIScreen.main.bounds
        
        print(screenSize.height*0.25)
        // Do any additional setup after loading the view.
    }
    
    
    func designCell(){
        //support multiple line
        titleLabel.numberOfLines = 0
        authorLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        webLabel.numberOfLines = 0
        
        
        titleLabel.text=articleDetails!.title
        authorLabel.text="Author : "+articleDetails!.authors
        contentLabel.text="Content : "+articleDetails!.content
        dateLabel.text="Date : "+articleDetails!.date
        webLabel.text="Website : "+articleDetails!.website
        
        let neededHeight = UIScreen.main.bounds.height * 0.25
        imageView.frame.size.height = neededHeight
        imageView.frame.size.width=UIScreen.main.bounds.width
        
        print(neededHeight)
        

        if let imageURL = URL(string:articleDetails!.image_url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {

                        self.imageView.image = image
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
