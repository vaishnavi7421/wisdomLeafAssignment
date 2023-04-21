//
//  ViewController.swift
//  WisdomLeafAssignment
//
//  Created by Pranav Dhomne on 18/04/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var heros = [HeroStats]()
    var hero: HeroStats?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataInTableViewCell
        let hero = heros[indexPath.row]
        cell.titleData?.text = hero.localized_name
        //Concating two values just to show description sort of data
        cell.descrData?.text = hero.name + " " + hero.primary_attr
        let imgUrl = "https://api.opendota.com" + (hero.img)
               print(imgUrl)
        cell.imageData.downloaded(from: imgUrl)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let cell = tableView.cellForRow(at: indexPath) as! DataInTableViewCell
        if cell.checkBox.imageView?.image == UIImage(systemName: "square") {
                let alert = UIAlertController(title: "Disabled", message: "Please enable by clicking on check box", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // Code to run when the user taps the OK button
                    alert.dismiss(animated: true)
                }
                alert.addAction(okAction)
            present(alert, animated: true, completion: nil)

            } else {
                let desc = heros[indexPath.row]
                
                let alert = UIAlertController(title: "Description data", message: "\(desc.name)  \(desc.primary_attr)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // Code to run when the user taps the OK button
                    alert.dismiss(animated: true)
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)

            }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        print(UIDevice.current.userInterfaceIdiom)
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 100
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return 180
        } else {
            return 80
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) selected")
    }
    func downloadJson(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { data, reponse, errors in
            if errors == nil {
                do {
                    self.heros = try JSONDecoder().decode([HeroStats].self, from:  data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error is existing")
                }
            }
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        print("TableView Controller dataCell")
        downloadJson {
            self.tableView.reloadData()
                       print("success")
        }
                tableView.delegate = self
                tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @objc func refresh(_ sender: UIRefreshControl) {
          // Perform your data fetching or reloading here
          // When your data fetching or reloading is complete, end refreshing
          tableView.reloadData()
          sender.endRefreshing()
      }

}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
