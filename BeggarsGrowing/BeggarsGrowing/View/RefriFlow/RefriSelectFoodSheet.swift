//
//  SelectFoodSheet.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/29/24.
//
import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

//struct IngredientSelectSheet: View {
//    @State private var isSheetPresented = false
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                isSheetPresented = true
//            }) {
//                Text("Show Ingredients")
//            }
//            .sheet(isPresented: $isSheetPresented) {
//                IngredientSheetView()
//                    .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
//            }
//        }
//    }
//}

struct RefriSelectFoodSheetView: View {
    @State private var searchText = ""
    @State private var selectedIngredients: Set<String> = []
    @Environment(\.presentationMode) var presentationMode
    
    let foods = FoodImageName().ingredients
    
    @Binding var selectedFoodsList: [Refrigerator]
    
    var filteredFoods: [Food] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter { $0.name.contains(searchText) }
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text("재료")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    // 완료 버튼 액션
                    DispatchQueue.main.async{
                        for food in selectedIngredients {
                            selectedFoodsList.append(Refrigerator(food: food, price: 0, amount: 100, freezing: false, date: Date()))
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("완료")
                        .foregroundColor(.orange)
                }
            }
            .padding()

            SearchBar(text: $searchText)

            ScrollView {
                VStack(spacing: 10) { // 요소 사이의 여백 설정
                    ForEach(filteredFoods, id: \.name) { food in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedIngredients.contains(food.name) ? Color.yellow.opacity(0.3) : Color(red: 242/255, green: 245/255, blue: 240/255))
                            
                            HStack {
                                Button(action: {
                                    if selectedIngredients.contains(food.name) {
                                        selectedIngredients.remove(food.name)
                                    } else {
                                        selectedIngredients.insert(food.name)
                                    }
                                }) {
                                    Image(systemName: selectedIngredients.contains(food.name) ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Image(food.imageName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading)
                                  
                                Text(food.name)
                                    .font(.body)
                                    .foregroundColor(.black)

                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage() // 위아래 Divider 없애기
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
//
//#Preview {
//    IngredientSelectSheet()
//}
