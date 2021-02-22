//
//  ContributeData.swift
//  jandi
//
//  Created by daehyun han on 2021/02/22.
//

import Foundation

class ContributeData {
    let count : Int
    let weekend : String
    let date : String
    private var friendContributeData : ContributeData?
    
    init(count: Int, weekend: String, date: String) {
            self.count   = count
            self.weekend = weekend
            self.date  = date
        }
    
    public func showStatusDetail() -> String {
        let emoji = count.getEmoji()
        var textString = "\(date) (\(weekend)) - \(emoji) \(count)"
        
        if self.friendContributeData != nil {
            guard let friendContributeData = self.friendContributeData else {return textString}
            textString += " vs \(friendContributeData.count) \(friendContributeData.count.getEmoji())"
        }
        return textString
    }
    
    func getAttributes() -> [NSAttributedString.Key : Any] {
        return (count == .zero) ? Attributes.red : Attributes.green
    }
    
    public func getStatusDetailAttributedString() -> NSAttributedString {
        let statusDetailAttributedString = NSMutableAttributedString()
        let emoji = count.getEmoji()
        let textString = "\(date) (\(weekend)) - \(emoji) \(count)"
        
        let attributedString = NSAttributedString(string: textString, attributes: getAttributes())
        statusDetailAttributedString.append(attributedString)
        
        if self.friendContributeData != nil {
            guard let friendContributeData = self.friendContributeData else {return statusDetailAttributedString}
            
            statusDetailAttributedString.append(NSAttributedString(string: " vs ", attributes: Attributes.black))
            
            let AddedTextString = "\(friendContributeData.count) \(friendContributeData.count.getEmoji())"
            let addedAttributedString = NSAttributedString(string: AddedTextString, attributes: friendContributeData.getAttributes())
            statusDetailAttributedString.append(addedAttributedString)
        }
        
        return statusDetailAttributedString
    }

    public func attributedString(textString: String) -> NSAttributedString {
        let attributes = (count == .zero) ? Attributes.red : Attributes.green
        return NSAttributedString(string: textString, attributes: attributes)
    }
    

    public func showStatusBar() -> String {
        let emoji = count.getEmoji()
        var textString = "\(emoji) \(count)"
        
        if self.friendContributeData != nil {
            guard let friendContributeData = self.friendContributeData else {return textString}
            textString += " vs \(friendContributeData.count) \(friendContributeData.count.getEmoji())"
        }
        return textString
    }
    
    public func getStatusBarAttributedString() -> NSAttributedString {
        let statusDetailAttributedString = NSMutableAttributedString()
        let emoji = count.getEmoji()
        let textString = "\(emoji) \(count)"
        
        let attributedString = NSAttributedString(string: textString, attributes: getAttributes())
        statusDetailAttributedString.append(attributedString)
        
        if self.friendContributeData != nil {
            guard let friendContributeData = self.friendContributeData else {return statusDetailAttributedString}
            let AddedTextString = "\(friendContributeData.count) \(friendContributeData.count.getEmoji())"
            
            statusDetailAttributedString.append(NSAttributedString(string: " vs ", attributes: Attributes.white))
            
            let addedAttributedString = NSAttributedString(string: AddedTextString, attributes: friendContributeData.getAttributes())
            statusDetailAttributedString.append(addedAttributedString)
        }
        
        return statusDetailAttributedString
    }
    
    public func merge(contributeData: ContributeData) {
        self.friendContributeData = contributeData
    }
}
