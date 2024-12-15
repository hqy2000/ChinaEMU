//
//  SingleTrainView.swift
//  EMURoutingTracker
//
//  Created by Qingyang Hu on 11/15/20.
//

import SwiftUI

struct TrainList: View {
    @EnvironmentObject var vm: EMUTrainViewModel
    @Binding var path: NavigationPath

    var body: some View {
        List {
            ForEach(vm.emuTrainAssocList, id: \.id) { emu in
                TrainRow(train: emu, path: $path)
            }
        }
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    if let trainInfo = self.vm.emuTrainAssocList.first?.trainInfo {
                        Text("\(self.vm.query)").font(.headline)
                        Text("\(trainInfo.from) ⇀ \(trainInfo.to)").font(.caption2)
                    } else {
                        Text(self.vm.query).font(.headline)
                    }
                }
            }
        }
        .navigationBarItems(trailing: HStack {
            ScanQRCodeButton().environmentObject(self.vm)
            if let train = self.vm.emuTrainAssocList.first?.singleTrain {
                FavoriteButton(trainOrEMU: train, provider: FavoritesProvider.trains)
            }
            
        })
    }
}

struct SingleTrainView_Previews: PreviewProvider {
    static var previews: some View {
        TrainList(path: Binding.constant(NavigationPath()))
    }
}
