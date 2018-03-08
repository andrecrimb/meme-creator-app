//
//  SentMemesTVC.swift
//  ioMeme
//
//  Created by Andre Rosa on 21/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class SentMemesTVC: UITableViewController {
    
    var memes = [Meme]()
    
    let emptyTablePlaceholder: UIView? = Bundle.main.loadNibNamed("EmptyTablePlaceholder", owner: nil, options: nil)?.first as? UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        
        reloadTable()
      
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: NOTIF_RELOAD_TABLE), object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_MEME_DETAIL{
            if let memeDetail = segue.destination as? MemeDetailVC{
                if let meme = sender as? Meme{
                    memeDetail.meme = meme
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as? MemeTableCell{
            let memeCell = memes[indexPath.row]
            cell.configureCell(meme: memeCell)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme: Meme = memes[indexPath.row]
        performSegue(withIdentifier: TO_MEME_DETAIL, sender: meme)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    @objc func reloadTable(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
        if memes.count > 0{
            self.tableView.backgroundView = nil
        } else {
            self.tableView.backgroundView = emptyTablePlaceholder
        }
    }
    
    @IBAction func toMemeEditor(_ sender: Any){
        performSegue(withIdentifier: TO_MEME_EDITOR, sender: nil)
    }
    
}
