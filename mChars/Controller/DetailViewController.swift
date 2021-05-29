//
//  DetailViewController.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var mainViewController: ViewController!
    
    var character: CharacterViewModel!
    {
        didSet{
     
            if let  url = URL(string: character.thumbnail ?? "") {
                
                self.posterIV.kf.setImage(with: url)
                
            }
   
            self.titleLbl.text = character.name
            self.charDesc.text = character.description
            
            if let id = character.id {
                fetchComics(id: id)
            }

        }
    }
    
    var comics: [MComics]?{
        didSet{
            
        }
    }
    
    let posterIV: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        return v
    }()
    
    
    var titleLbl: UILabel = {
      let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 2
        
        return l
    }()
    
    var charDesc: UITextView = {
       let v = UITextView()
        v.font = UIFont.systemFont(ofSize: 18)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var mainStackView: UIStackView = {
       let v = UIStackView()
        v.axis = .vertical
        v.translatesAutoresizingMaskIntoConstraints = false
        v.spacing = .pi
        return v
    }()
    
    lazy var tableView: UITableView = {
       let t = UITableView()
        t.dataSource = self
        t.delegate = self
        return t
    }()
    
    override func viewDidLoad() {

        setupViews()

    }


    func setupViews() {
        
                
        view.backgroundColor = .white
        
        self.view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(posterIV)
        mainStackView.addArrangedSubview(titleLbl)
        mainStackView.addArrangedSubview(charDesc)
        mainStackView.addArrangedSubview(tableView)
        
        mainStackView.snp.makeConstraints { mk in
            mk.left.right.top.bottom.equalToSuperview()
        }

        posterIV.snp.makeConstraints { mk in
            mk.leading.trailing.equalToSuperview()
            mk.height.equalTo(350)
        }
        
        titleLbl.snp.makeConstraints { mk in
            mk.leading.trailing.equalToSuperview().offset(10)
            mk.top.equalTo(self.posterIV.snp.bottom).offset(16)
            
        }
        
        charDesc.snp.makeConstraints { mk in
            mk.leading.trailing.equalToSuperview().offset(10)
            mk.height.equalTo(140)
        }
 
    }
    
    func fetchComics(id: Int){
        APIService.instance.fetchComics(id: id) { result in
            switch result {

            case .success(let data):
                let comicsWrp = data as! MComicsWrapper
                let comics = comicsWrp.data?.results
                self.comics = comics
                self.tableView.reloadData()
                self.tableView.endUpdates()
                break
            case .failure(_):
                break
            }
        }
     
    }
}



extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = comics?.count else { return 0  }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.comics?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comics"
    }
    
}
