//
//  ViewController.swift
//  Demo
//
//  Created by RCD on 23/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let lineView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let popularItemsLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Popular Items"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    let scrollView = UIScrollView()
    
    lazy var horizontalCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.contentInset = UIEdgeInsets(top: 0, left: view.width/20, bottom: 0, right: 0)
        return cv
        
    }()
    

    
    var featuredItems = [FeaturedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    func configure() {
        
        self.view.backgroundColor = .white
        self.title = "Items"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), style: .done, target: nil, action: nil)
        
        view.addSubview(lineView)
        view.addSubview(popularItemsLabel)
        view.addSubview(horizontalCollectionView)
        view.addSubview(scrollView)
        setConstraints()
        
        
        getData { [weak self] done in
            
            if done {
                
                DispatchQueue.main.async {
                    
                    self?.horizontalCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3),
            
            
            popularItemsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popularItemsLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: popularItemsLabel.bottomAnchor, constant: 15),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 180),
        
        ])
        
    }
    
    func getData(completion: @escaping ((Bool) ->Void)) {
        
        featuredItems.removeAll()
        let urlObject = URL(string: "https://884a2603-1fae-4203-8f48-067456afd15b.mock.pstmn.io/testUrl1")
        
        URLSession.shared.request(url: urlObject, expecting: MainData.self) { [weak self] result in
            
            switch result {
                
            case .success(let data):
    
                for item in  data.result.featuredItems {
                    
                    self?.featuredItems.append(FeaturedItem(photo: item.pic, sameDayDelivery: item.sameDayDelivery, itemName: item.itemName, shopName: item.shopName, itemPrice: item.price))
                   
                }
                
                completion(true)
                
            case .failure(let error):
                
                print(error)
                completion(false)
            }
        }
    }
    
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        
        if !featuredItems.isEmpty {
            
            cell.configure(with: featuredItems[indexPath.item])
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width/2.7, height: horizontalCollectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.width/40
    }
}

