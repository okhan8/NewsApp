//
//  ViewController.swift
//  NewsApp
//
//  Created by Osman Khan on 7/26/19.
//  Copyright © 2019 4491-IOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var articles:[Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchArticles()
    }
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=e62f1d8270ce492f810516b947af4827")!)
        let task = URLSession.shared.dataTask(with: urlRequest){
            (data,response,error) in
            if error != nil {
                print (error)
                return
            }
            
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.ImageUrl = urlToImage
                        }
                        
                        self.articles?.append(article)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print (error)
            }
        }
        
        task.resume()
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        if self.articles?[indexPath.item].ImageUrl != nil {
            cell.ImgView.downloadImage(from: (self.articles?[indexPath.item].ImageUrl!)!)
        }
        
        //cell.clipsToBounds = true
        return cell
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewViewController
        webVC.url = self.articles?[indexPath.item].url
        self.present(webVC, animated: true, completion: nil)
    }
    
}

extension UIImageView {
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            if error != nil {
                print (error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
            
        }
        task.resume()
}
}
