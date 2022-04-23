//
//  FirebaseCommunity.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 2.02.22.
//

import Firebase

class FirebaseCommunity {

    let groupName: String
    let groupId: Int

/// Link for Reference
    let refer: DatabaseReference?

/// init property
    init(name: String, id: Int){
        self.refer = nil
        self.groupName = name
        self.groupId = id
    }

/// Pass the link with DataSnapshot
    init?(snapshot: DataSnapshot) {

        guard let value = snapshot.value as? [String: Any],
              let id = value["groupId"] as? Int,
              let name = value["groupName"] as? String else { return nil}

        self.refer = snapshot.ref
        self.groupId = id
        self.groupName = name
    }

    func toAnyObject() -> [String: Any] {
        return [
            "GroupId": groupId,
            "GroupName": groupName
        ]
    }
}
