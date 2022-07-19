//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/03.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.Title)
                .bold()
                .font(.body)
                .lineLimit(1)
                .frame(width: 150, alignment: .leading)
                .allowsTightening(true)
                
                
                
            HStack {
                Text(memo.insertDate, style: .date)
                    .font(.caption)
                .foregroundColor(.secondary)
                Text(Image(systemName: "star.fill"))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(Date(), style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
        }
    }
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(Title: "Test", content: "123"))
    }
}
