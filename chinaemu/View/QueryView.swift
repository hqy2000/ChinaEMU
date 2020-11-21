//
//  QueryView.swift
//  chinaemu
//
//  Created by Qingyang Hu on 11/20/20.
//

import Foundation
import SwiftUI

struct QueryView: View {
    @State var query = ""
    @State var departure = ""
    @State var arrival = ""
    @State var date = Date()
    @ObservedObject var provider = StationProvider.shared
    var body: some View {
        List {
            Section(header: Text("车组号/车次查询")) {
                TextField("CRH2A2001", text: $query)
                NavigationLink(
                    destination: MoerailView(query),
                    label: {
                        Text("查询")
                    })
            }
            Section(header: Text("发着查询")) {
                Picker("出发地", selection: $departure) {
                    ForEach(provider.stations, id: \.code) { station in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(station.name)
                                Text(station.pinyin).font(.caption2)
                            }
                            Spacer()
                            Text(station.code).font(.system(.body, design: .monospaced))
                        }
                    }.navigationTitle("出发地选择")
                }
                Picker("目的地", selection: $arrival) {
                    ForEach(provider.stations, id: \.code) { station in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(station.name)
                                Text(station.pinyin).font(.caption2)
                            }
                            Spacer()
                            Text(station.code).font(.system(.body, design: .monospaced))
                        }
                    }.navigationTitle("目的地选择")
                }
                DatePicker("出发日期", selection: $date, displayedComponents: .date)
                NavigationLink("查询", destination: LeftTicketsView())
                
            }
        }.listStyle(InsetGroupedListStyle())
        
    }
}
