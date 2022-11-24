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

    let scrollView: UIScrollView = {
        
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        
    }()
    
    lazy var horizontalCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FeaturedItemCell.self, forCellWithReuseIdentifier: FeaturedItemCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.contentInset = UIEdgeInsets(top: 0, left: view.width/20, bottom: 0, right: 0)
        return cv
        
    }()
    
    lazy var verticalCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CommonItemCell.self, forCellWithReuseIdentifier: CommonItemCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: view.width/20, bottom: 0, right: view.width/20)
        return cv
        
    }()
    
    let aView = UIView()
    
    var featuredItems = [FeaturedItem]()
    
   // var commonItems = [commonItems]()
    
    var heightConstraint = NSLayoutAnchor<NSLayoutDimension>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    func configure() {
        
        self.view.backgroundColor = .white
        self.title = "Items"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), style: .done, target: nil, action: nil)
        
        view.addSubview(lineView)
//        view.addSubview(popularItemsLabel)
//        view.addSubview(horizontalCollectionView)
//        view.addSubview(verticalCollectionView)
        view.addSubview(scrollView)
        scrollView.addSubview(popularItemsLabel)
        scrollView.addSubview(horizontalCollectionView)
        scrollView.addSubview(verticalCollectionView)
        scrollView.addSubview(aView)
        
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
        
        
        getData { [weak self] done in
            
            if done {
                
                DispatchQueue.main.async {
                    
                    self?.horizontalCollectionView.reloadData()
                   // self?.verticalCollectionView.reloadData()
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
            
            scrollView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            popularItemsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popularItemsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: popularItemsLabel.bottomAnchor, constant: 15),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 190),
            
            verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20),
            verticalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //verticalCollectionView.heightAnchor.constraint(equalToConstant: 1000),
            verticalCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        
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
        switch collectionView {
            
        case horizontalCollectionView:
            return featuredItems.count
            
        case verticalCollectionView:
            return 20
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case horizontalCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedItemCell.identifier, for: indexPath) as! FeaturedItemCell
            
            if !featuredItems.isEmpty {
                
                cell.configure(with: featuredItems[indexPath.item])
                
            }
            
            return cell
            
        case verticalCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonItemCell.identifier, for: indexPath) as! CommonItemCell
            
            return cell
        
        default:
            return UICollectionViewCell()
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case horizontalCollectionView:
            return CGSize(width: view.width/2.7, height: horizontalCollectionView.height)
            
        case verticalCollectionView:
            return CGSize(width: view.width/2, height: 200)
        default:
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.width/40
    }
}

