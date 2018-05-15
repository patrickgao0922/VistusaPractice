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
    
    enum Segue:String {
        case showDetail
    }

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var layout:UICollectionViewFlowLayout!
    var viewModel:FactCollectionViewViewModel!
    var cellMaker:DependencyRegistry.FactCollectionViewCellMaker!
    fileprivate var disposeBag:DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupObservables()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func config(viewModel: FactCollectionViewViewModel,cellMaker:@escaping DependencyRegistry.FactCollectionViewCellMaker) {
        self.viewModel = viewModel
        self.viewModel.delegate = self
        self.cellMaker = cellMaker
        viewModel.fetchFact()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifierString = segue.identifier else {
            return
        }
        guard let segueIdentifier = Segue(rawValue: identifierString) else {
            return
        }
        
        switch segueIdentifier {
        case .showDetail:
            guard let indexPath = self.collectionView.indexPathsForSelectedItems?[0] else {
                return
            }
            guard let viewModel = self.viewModel.obtainViewModel(forCellAtIndexPath: indexPath) else {
                return
            }
            let destination = segue.destination as! DetailViewController
            destination.config(with: viewModel)
            
        }
    }
}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
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
        let cellViewModel = viewModel.obtainViewModel(forCellAtIndexPath: indexPath)
        let cell = cellMaker(collectionView,indexPath,viewModel.fact.value!.rows[indexPath.row],cellViewModel)
        if cellViewModel == nil {
            viewModel.addViewModel(forCellAtIndexPath: indexPath, viewModel: cell.returnCellViewModel())
        }
        return cell
    }

}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = viewModel.imageSize(at: indexPath) {
            return size
        }
//        return CGSize(width: 120, height: 30)
        return CGSize(width: 200, height: 200)
//        return viewModel.imageSize(at: indexPath)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startDownloadImagesOnScreen()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            startDownloadImagesOnScreen()
        }
    }
    
    func startDownloadImagesOnScreen() {
        let paths = collectionView.indexPathsForVisibleItems
        viewModel.startDownloadImage(atPaths: paths)
    }
}

// MARK: - Setup UI Layout
//extension ViewController {
//    func setupLayout() {
//        layout.estimatedItemSize = CGSize(width: 1, height: 1)
//    }
//}

// MARK: - Config Observables
extension ViewController {
    func setupObservables() {
        viewModel.fact.asDriver().asObservable().subscribe(onNext: { (_) in
            self.collectionView.performBatchUpdates({
//                let indexSet =
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }, completion: { (_) in
                self.startDownloadImagesOnScreen()
            })
            
            self.startDownloadImagesOnScreen()
        }).disposed(by: disposeBag)
    }
}

extension ViewController:FactCollectionViewDelegate {
    func reloadCell(at indexPath: IndexPath) {
        self.collectionView.reloadItems(at: [indexPath])
    }
    
    
}
