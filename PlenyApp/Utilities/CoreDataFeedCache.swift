//
//  CoreDataFeedCache.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 20/07/2025.
//

import Foundation
import CoreData

final class CoreDataFeedCache {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func save(posts: [Post]) {
        clear()

        posts.forEach { post in
            let cdPost = CDPost(context: context)
            cdPost.id = Int64(post.id ?? 0)
            cdPost.title = post.title
            cdPost.body = post.body
            cdPost.userId = Int64(post.userId ?? 0)
        }

        do {
            try context.save()
        } catch {
            print("❌ Failed to save posts to Core Data:", error)
        }
    }

    func fetch() -> [Post] {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()

        do {
            let cdPosts = try context.fetch(request)
            return cdPosts.map { cdPost in
                Post(
                    id: Int(cdPost.id),
                    body: cdPost.body,
                    title: cdPost.title,
                    userId: Int(cdPost.userId),
                    image: nil
                )
            }
        } catch {
            print("❌ Failed to fetch posts from Core Data:", error)
            return []
        }
    }

    func clear() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDPost.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("❌ Failed to clear Core Data cache:", error)
        }
    }
}
