//
//  MapView.swift
//  Quest
//
//  Created by Romesh Singhabahu on 16/02/2019.
//  Copyright © 2019 devhubs. All rights reserved.
//

import MapKit

class MapView: MKMapView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let compassView = subviews.filter({ $0.isKind(of: NSClassFromString("MKCompassView")!) }).first
        {
         compassView.frame = CGRect(x: 16, y: 69, width: 40, height: 40)
        }
    }
}
