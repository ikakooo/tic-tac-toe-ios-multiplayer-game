//
//  OnlineGameBoardDataService.swift
//  tic-tac-toe-ios-multiplayer-game
//
//  Created by MacBook Pro on 01.12.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OnlineGameBoardDataService:NSObject , UICollectionViewDataSource {
    
    private unowned var controller: UIViewController!
    private unowned var collectionView: UICollectionView!
    private unowned var viewModel: OnlineGameBoardViewModelProtocol!
    private unowned var onlinePlayerToe: UIImageView!
    private unowned var appUserToe: UIImageView!
    private var playerEnemy:PlayerModel!
    
    let appUserUid = Auth.auth().currentUser?.uid ?? "error"
    
    var myToeDetected = false
    var myToe = "O"
    
    private var toes = [String](){
        
        willSet {
            
        }
        didSet {
            collectionView.reloadData()
            viewModel.setToes(newToes: toes)
            checkForWinner()
        }
    }
    
    init(withController: UIViewController,
         with collectionView: UICollectionView,
         onlinePlayerToe: UIImageView,
         appUserToe: UIImageView,
         playerEnemy: PlayerModel,
         viewModel: OnlineGameBoardViewModelProtocol)
    {
        super.init()
        unowned let this =  self
        self.controller = withController
        self.collectionView = collectionView
        self.onlinePlayerToe = onlinePlayerToe
        self.appUserToe = appUserToe
        self.playerEnemy = playerEnemy
        self.collectionView.dataSource = this
        self.collectionView.delegate = this
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.registerNib(class: ToeCollectionViewCell.self)
        
        self.viewModel = viewModel
    }
    
    func refreshAndEtechOnlinePlayer() {
        
        viewModel.atachOnlinePlayer(enemy: playerEnemy)
        
        toes = viewModel.getToes()
        collectionView.reloadData()
        subscribeLiveGameBoardUpdates()
    }
    
    func playerActiveStatus(isActive: Bool) {
        let myNewRef = Database.database().reference(withPath:"Players/\(appUserUid)/activeStatus")
        myNewRef.setValue(isActive)
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

extension OnlineGameBoardDataService: UICollectionViewDelegateFlowLayout {
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
            viewModel.isPlayerTurn(){[unowned self] turn , toe in
                
                if turn {
                    
                    if self.toes[indexPath.row] == "" {
                        self.toes[indexPath.row] = toe
                        
                        if !myToeDetected {
                            myToeDetected = true
                            myToe = toe
                            switch toe {
                            case "X":  onlinePlayerToe.image = UIImage.init(named: "toe_o")
                                appUserToe.image = UIImage.init(named: "toe_x")
                            case "O": onlinePlayerToe.image = UIImage.init(named: "toe_x")
                                appUserToe.image = UIImage.init(named: "toe_o")
                            default: return
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func subscribeLiveGameBoardUpdates(){
        let   gameSessionID =  String("\(appUserUid)\(playerEnemy.uid ?? "null")".sorted())
        let  myRefGameSession =  Database.database().reference(withPath:"Players_GameSessions/\(gameSessionID)")
        myRefGameSession.observe(.value) {[weak self] liveSnapshot in
            if liveSnapshot.exists() {
                let value =   liveSnapshot.value as? NSArray
                
                //print(value)
                guard let boardtoes = value as? Array<Array<String>> else {return}
                
                if self?.toes != Array(boardtoes.joined()) as Array<String>{
                    self?.toes = Array(boardtoes.joined())
                }
                
            } else {
                // self.onlineUserCount.title = "0" Array(value.chunked(into: 3).joined())
            }
        }
    }
    
    
    func checkForWinner(){
        
        viewModel.checkForWinner(toesOnBoard: toes){ [unowned self] winner in
            print(winner)
            
            switch winner {
            case myToe:
                self.controller.openAlert(title: "You Won!", message: "", closeButtonTitle: "Restart"){
                    self.toes = ["","","","","","","","",""]
                    self.controller.navigationController?.popViewController(animated: true)
                }
                
            case "Drow":
                self.controller.openAlert(title: winner, message: "", closeButtonTitle: "Restart"){
                    self.toes = ["","","","","","","","",""]
                    self.controller.navigationController?.popViewController(animated: true)
                }
                
            default:
                self.controller.openAlert(title: "You Loose!", message: "", closeButtonTitle: "Restart"){
                    self.toes = ["","","","","","","","",""]
                    self.controller.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
