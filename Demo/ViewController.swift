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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        self.view.backgroundColor = .white
        self.title = "Items"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), style: .done, target: nil, action: nil)
        view.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3),
            
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        
    }
    
}

