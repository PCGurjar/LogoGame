//
//  GuessLogoViewController.swift
//  LogoGame
//
//  Created by Poonamchand on 14/08/21.
//

import UIKit

class GuessLogoViewController: UIViewController {

    var logoVm = LogoViewModel()
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var collectionCorrectName: UICollectionView!
    @IBOutlet weak var collectionSelectWord: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.collectionCorrectName.register(UINib(nibName: "CellNameWords", bundle: nil), forCellWithReuseIdentifier: "CellNameWords")
        self.collectionSelectWord.register(UINib(nibName: "CellSelectWord", bundle: nil), forCellWithReuseIdentifier: "CellSelectWord")
        
        collectionCorrectName.delegate = self
        collectionCorrectName.dataSource = self
        collectionSelectWord.delegate = self
        collectionSelectWord.dataSource = self
        
        logoVm.getLogos { logos in
            logoVm.initializeScoreModel()
            
            logoVm.currentIndex = 0
            showImage()
            collectionCorrectName.reloadData()
        }
    }
    
    func showImage() {
        if logoVm.arrLogos.count > 0  && logoVm.currentIndex < logoVm.arrLogos.count{
            let m = logoVm.arrLogos[logoVm.currentIndex]
            imgLogo.loadImageUsingCache(withUrl: m.imgURL)
        }
    }
    
    @IBAction func btnPreviousClick(_ sender: Any) {
        if logoVm.arrLogos.count > 0 && logoVm.currentIndex > 0{
            logoVm.currentIndex -= 1
            collectionCorrectName.reloadData()
            showImage()
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        if logoVm.arrLogos.count > 0  && logoVm.currentIndex < logoVm.arrLogos.count{
            logoVm.currentIndex += 1
            collectionCorrectName.reloadData()
            showImage()
        }
    }
    
    @IBAction func btnTryAgainClick(_ sender: Any) {
        collectionCorrectName.reloadData()
        logoVm.reInitializeLogos()
        logoVm.initializeScoreModel()
        logoVm.currentIndex = 0
        showImage()
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        logoVm.updateScoreOnFinish()
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController {
            vc.scoreModel = logoVm.scoreModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension GuessLogoViewController: UICollectionViewDelegate
                                   , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let m = logoVm.arrLogos[logoVm.currentIndex].name
        
        if collectionView == collectionCorrectName {
            return m.count
        }else{
            return logoVm.arrWord.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionCorrectName {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellNameWords", for: indexPath) as! CellNameWords
            let m = logoVm.arrLogos[logoVm.currentIndex].answer ?? ""
            let arr = Array(m)
            
            if arr.count > indexPath.row {
                cell.labelWord.text = "\(arr[indexPath.row])"
            }else{
                cell.labelWord.text = ""
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSelectWord", for: indexPath) as! CellSelectWord
            let word = logoVm.arrWord[indexPath.row]
            cell.labelWord.text = word
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionSelectWord {
            
            let w = logoVm.arrWord[indexPath.row]
            var m = logoVm.arrLogos[logoVm.currentIndex].answer ?? ""
            m += w
            
            logoVm.arrLogos[logoVm.currentIndex].answer = m
            collectionCorrectName.reloadData()
        }
        
    }
}
