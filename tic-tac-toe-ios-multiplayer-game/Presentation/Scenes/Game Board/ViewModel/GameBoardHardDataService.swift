//
//  GameBoardHardDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by Irakli Chkhitunidzde on 10.04.22.
//

import UIKit

class GameBoardHardDataService: NSObject, UICollectionViewDataSource {
    
    private var controller: UIViewController!
    private var collectionView: UICollectionView!
    private var viewModel: GameBoardViewModelProtocol!
    private var toes = [String](){
        
        willSet {
           
        }
        didSet {
            collectionView.reloadData()
            viewModel.setToes(newToes: toes)
        }
    }
    
    init(withController: UIViewController,
         with collectionView: UICollectionView,
         viewModel: GameBoardViewModelProtocol)
    {
        super.init()
        self.controller = withController
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        //self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.registerNib(class: ToeCollectionViewCell.self)
        
        self.viewModel = viewModel
    }
    
    func refresh() {
        let new = viewModel.getToes()
        let old = toes
        toes = viewModel.getToes()
        //collectionView.reloadData()
        for index in new.indices  {
            if new[index] != old[index]{
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.deque(class: ToeCollectionViewCell.self, for: indexPath)
        cell.configure(with: toes[indexPath.row])
        return cell
    }
}


extension GameBoardHardDataService: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 30) / 3, height: (collectionView.bounds.size.height - 30) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
        
        if toes[indexPath.row] == "" {
            toes[indexPath.row] = "X"
            viewModel.easyZeroPlayerMove(){[weak self] newToes in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self?.toes = newToes
                    self?.checkForWinner()
                }
            }
        }
        checkForWinner()
        
    }
    
    func checkForWinner(){
        viewModel.checkForWinner(toesOnBoard: toes){ [unowned self] winner in
            print(winner)
            switch winner {
            case "X":
                self.controller.openAlert(title: "You Won!", message: "", closeButtonTitle: "Restart"){
                self.controller.navigationController?.popViewController(animated: true)
            }
            case "O":
                self.controller.openAlert(title: "You Loose!", message: "", closeButtonTitle: "Restart"){
                self.controller.navigationController?.popViewController(animated: true)
            }
            case "Drow":
                self.controller.openAlert(title: winner, message: "", closeButtonTitle: "Restart"){
                self.controller.navigationController?.popViewController(animated: true)
            }
                
            default: break
            }
            
           
        }
    }
}




