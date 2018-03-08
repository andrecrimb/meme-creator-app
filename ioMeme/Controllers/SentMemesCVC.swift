//
//  SentMemesCVC.swift
//  ioMeme
//
//  Created by Andre Rosa on 21/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionCell"

class SentMemesCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var memes = [Meme]()
    
    let emptyTablePlaceholder: UIView? = Bundle.main.loadNibNamed("EmptyTablePlaceholder", owner: nil, options: nil)?.first as? UIView
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTable()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: NOTIF_RELOAD_TABLE), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_MEME_EDITOR{
            if let memeEditor = segue.destination as? MemeMainVC{
                if let meme = sender as? Meme{
                    memeEditor.meme = meme
                }
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as? MemeCollectionCell {
            let memeCell = memes[indexPath.row]
            cell.configureCell(meme: memeCell)
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme: Meme =  memes[indexPath.row]
        performSegue(withIdentifier: TO_MEME_EDITOR, sender: meme)
    }
    
    @objc func reloadTable(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
        if memes.count > 0{
            self.collectionView?.backgroundView = nil
        } else {
            self.collectionView?.backgroundView = emptyTablePlaceholder
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIScreen.main.bounds.width < 321 {
            let numOfColumns: CGFloat = 3
            let spaceBetweenCells: CGFloat = 10
            let padding: CGFloat = 40
            let cellDimention = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
            
            return CGSize(width: cellDimention, height: cellDimention)
        }
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func toMemeEditor(_ sender: Any) {
        performSegue(withIdentifier: TO_MEME_EDITOR, sender: nil)
    }
    

}
