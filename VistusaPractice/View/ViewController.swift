//
//  ViewController.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 11/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var layout:UICollectionViewFlowLayout!
    var viewModel:FactCollectionViewViewModel!
    var cellMaker:DependencyRegistry.FactCollectionViewCellMaker!
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        setupObservables()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func config(viewModel: FactCollectionViewViewModel,cellMaker:@escaping DependencyRegistry.FactCollectionViewCellMaker) {
        self.viewModel = viewModel
        self.cellMaker = cellMaker
        viewModel.fetchFact()
    }
}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rowNumber = viewModel.fact.value?.rows.count else {
            return 0
        }
        return rowNumber
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellMaker(collectionView,indexPath,viewModel.fact.value!.rows[indexPath.row],nil)
        return cell
    }

}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - Setup UI Layout
extension ViewController {
    func setupLayout() {
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
    }
}

// MARK: - Config Observables
extension ViewController {
    func setupObservables() {
        viewModel.fact.asDriver().asObservable().subscribe(onNext: { (_) in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}
