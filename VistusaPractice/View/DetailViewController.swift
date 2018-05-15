//
//  DetailViewController.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 15/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    weak var viewModel:FactCollectionViewCellViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        setupObservable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func config(with viewModel:FactCollectionViewCellViewModel) {
        self.viewModel = viewModel
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - setup Observable
extension DetailViewController {
    func setupUI() {
        self.detailLabel.sizeToFit()
        self.navigationItem.title = self.viewModel?.title
        self.detailLabel.text = self.viewModel?.description
    }
    func setupObservable() {
        viewModel?.image.asDriver().drive(imageView.rx.image).disposed(by: disposeBag)
    }
}
