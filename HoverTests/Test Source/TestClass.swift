//
//  TestClass.swift
//  Acc
//
//  Created by Onur Hüseyin Çantay on 8.07.2019.
//  Copyright © 2019 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
import Combine
@testable import Hover

typealias PostCompletion = (Result<PostResponseElement,ProviderError>) -> Void
typealias PostsCompletion = (Result<PostsResponse, ProviderError>) -> Void
typealias CommentsCompletion = (Result<CommentsResponse,ProviderError>) -> Void
typealias VoidCompletion = (Result<URLResponse,ProviderError>) -> Void

class TestClass {
    let provider = HoverProvider()
    var postsSubscriber: AnyPublisher<PostsResponse, ProviderError>?
    var postSubscriber: AnyPublisher<PostResponseElement,ProviderError>?
    var commentSubscriber: AnyPublisher<CommentsResponse,ProviderError>?
    var noBodySubscriber: AnyPublisher<URLResponse,ProviderError>?
    var subscriber = CommentSubscriber()
    
}



// MARK: - Publisher Test Functions
extension TestClass {
    func fetchPosts() {
        postsSubscriber = provider.request(
            with: TestTarget.fetchAllPosts,
            class: PostsResponse.self
        )
    }
    
    func fetchPostById(_ id: Int = 1) {
        postSubscriber = provider.request(
            with: TestTarget.fetchPostById(id: id),
            class: PostResponseElement.self
        )
    }
    
    func fetchPostsByUserId(userId: Int = 1)  {
        postsSubscriber = provider.request(
            with: TestTarget.fetchPostsByUserId(userId: userId),
            class: PostsResponse.self
        )
    }
    
    func createPost(title: String = "Foo", body: String = "Bar", userId: Int = 1) {
        postSubscriber = provider.request(
            with: TestTarget.createPost(
                title: title,
                body: body,
                userId: userId
            ),
            class: PostResponseElement.self
        )
    }
    
    func updatePostWithPut(postId: Int = 1, userId: Int = 1, title: String = "Foo", body: String = "Bar") {
        postSubscriber = provider.request(
            with: TestTarget.updatePostById(
                postId: postId,
                title: title,
                body: body,
                userId: userId
            ),
            class: PostResponseElement.self)
    }
    
    func updatePostWithPatch(postId: Int = 1, title: String = "") {
        postSubscriber = provider.request(
            with: TestTarget.updatePostPartly(
                postId: postId,
                title: title
            ),
            class: PostResponseElement.self)
    }
    
    func deletePost(with id: Int = 1) {
        noBodySubscriber = provider.request(with: TestTarget.deletePostById(postId: id))
    }
    
    func fetchCommentsWithPostId(_ id: Int = 1) {
        commentSubscriber = provider.request(
            with: TestTarget.fetchCommentsByPostId(postId: id),
            class: CommentsResponse.self
        )
    }
    
    func fetchCommentsWithSubscriber(_ id: Int = 1) {
        provider.request(with: TestTarget.fetchCommentsByPostId(postId: id), class: CommentsResponse.self, subscriber: self.subscriber)
    }
    
}

// MARK: - Completion Test Functions
extension TestClass {
    
    func fetchPosts(result: @escaping PostsCompletion) {
        provider.request(with: TestTarget.fetchAllPosts, class: PostsResponse.self, result: result)
    }
    
    func fetchPostById(with id: Int = 1, result: @escaping PostCompletion) {
        provider.request(with: TestTarget.fetchPostById(id: id), class: PostResponseElement.self, result: result)
    }
    
    func fetchPostsByUserId(_ userId: Int = 1, result: @escaping PostsCompletion)  {
        provider.request(with: TestTarget.fetchPostsByUserId(userId: userId), class: PostsResponse.self, result: result)
    }
    
    func createPost(title: String = "Foo", body: String = "Bar", userId: Int = 1, result: @escaping PostCompletion) {
        provider.request(with: TestTarget.createPost(title: title, body: body, userId: userId), class: PostResponseElement.self, result: result)
    }
    
    func updatePostWithPut(postId: Int = 1, userId: Int = 1, title: String = "Foo", body: String = "Bar", result: @escaping PostCompletion) {
        provider.request(with: TestTarget.updatePostById(postId: postId, title: title, body: body, userId: userId), class: PostResponseElement.self, result: result)
    }
    
    func updatePostWithPatch(postId: Int = 1, title: String = "", result: @escaping PostCompletion) {
        provider.request(with: TestTarget.updatePostPartly(postId: postId, title: title), class: PostResponseElement.self, result: result)
    }
    
    func deletePost(with id: Int = 1, result: @escaping VoidCompletion ) {
        provider.request(with: TestTarget.deletePostById(postId: id), result: result)
    }
    
    func fetchCommentsWithPostId(_ id: Int = 1, result: @escaping CommentsCompletion) {
        provider.request(with: TestTarget.fetchCommentsByPostId(postId: id), class: CommentsResponse.self, result: result)
    }
}
