//
//  ContentView.swift
//  randomPhotoApp
//
//  Created by Macintosh on 21/11/2565 BE.
//

import SwiftUI

class ViewModal: ObservableObject {
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string:"https://random.imagecdn.app/500/500") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {return}
                self.image = Image(uiImage:uiImage)
            }
        }
        task.resume()
    }
}


struct ContentView: View {
   @StateObject var viewModal = ViewModal()
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                if let image = viewModal.image{
                        image
                            .resizable()
                            .foregroundColor(Color.pink)
                            .frame(width: 200, height: 200)
                            .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                Spacer()
                Button(action: {
                    viewModal.fetchNewImage()
                }, label: {
                    Text("New image!")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding()
                })
            }
            .navigationTitle("Photo Random")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
