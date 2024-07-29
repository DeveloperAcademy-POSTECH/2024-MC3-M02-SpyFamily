//
//  IngredientSelectSheet.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/29/24.
//
import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct IngredientSelectSheet: View {
    @State private var isSheetPresented = false

    var body: some View {
        VStack {
            Button(action: {
                isSheetPresented = true
            }) {
                Text("Show Ingredients")
            }
            .sheet(isPresented: $isSheetPresented) {
                IngredientSheetView()
                    .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
            }
        }
    }
}

struct IngredientSheetView: View {
    @State private var searchText = ""
    @State private var selectedIngredients: Set<UUID> = []
    @Environment(\.presentationMode) var presentationMode
    
    let ingredients = [
        Ingredient(name: "사과", imageName: "apple"),
        Ingredient(name: "당근", imageName: "carrot"),
        Ingredient(name: "계란", imageName: "egg"),
        Ingredient(name: "사과", imageName: "apple"),
        Ingredient(name: "당근", imageName: "carrot"),
        Ingredient(name: "계란", imageName: "egg"),
        Ingredient(name: "사과", imageName: "apple")
    ]

    var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.name.contains(searchText) }
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
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("완료")
                        .foregroundColor(.orange)
                }
            }
            .padding()

            SearchBar(text: $searchText)

            ScrollView {
                VStack(spacing: 10) { // 요소 사이의 여백 설정
                    ForEach(filteredIngredients) { ingredient in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedIngredients.contains(ingredient.id) ? Color.yellow.opacity(0.3) : Color(red: 242/255, green: 245/255, blue: 240/255))
                            
                            HStack {
                                Button(action: {
                                    if selectedIngredients.contains(ingredient.id) {
                                        selectedIngredients.remove(ingredient.id)
                                    } else {
                                        selectedIngredients.insert(ingredient.id)
                                    }
                                }) {
                                    Image(systemName: selectedIngredients.contains(ingredient.id) ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                        
                                        
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Image(ingredient.imageName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading)
                                  

                                Text(ingredient.name)
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

#Preview {
    IngredientSelectSheet()
}
