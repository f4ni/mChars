//
//  ViewController.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//

import Kingfisher


class ViewController: UITableViewController {
    
    var characters = [CharacterViewModel]()
    var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Marvel Characters"
        
        fetchData(offset: self.offset)
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellID")
    }
    
    func fetchData(offset: Int) {
        APIService.instance.fetchCharacterts(offset: offset) { result in
            switch result {
            
            case .success(let data ):
                let dWrapper = data as! MCharacterWrapper
                if let chars = dWrapper.data?.results {
                    let charVM = chars.map({ return CharacterViewModel(model: $0)})
                    self.offset == 0 ? self.characters = charVM : self.characters.append(contentsOf: charVM)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.endUpdates()
                        self.offset = self.characters.count
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let count = characters.count
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableCell
        
        cell.textLabel?.text = characters[indexPath.row].name
        
        let url = URL(string: characters[indexPath.row].thumbnail ?? "") 
            
            cell.imageV.kf.setImage(with: url)
            
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        if indexPath.row ==  characters.count - 1 {
            print(offset, "offset")
            
            self.fetchData(offset: offset)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let char = characters[indexPath.row]
        let vc = DetailViewController()
        
        vc.character = char
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

