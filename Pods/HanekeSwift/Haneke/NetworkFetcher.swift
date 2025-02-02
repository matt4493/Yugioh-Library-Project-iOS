//
//  NetworkFetcher.swift
//  Haneke
//
//  Created by Hermes Pique on 9/12/14.
//  Copyright (c) 2014 Haneke. All rights reserved.
//

import UIKit

extension HanekeGlobals {
    
    // It'd be better to define this in the NetworkFetcher class but Swift doesn't allow to declare an enum in a generic type
    public struct NetworkFetcher {

        public enum ErrorCode : Int {
            case invalidData = -400
            case missingData = -401
            case invalidStatusCode = -402
        }
        
    }
    
}

open class NetworkFetcher<T : DataConvertible> : Fetcher<T> {
    
    let URL : Foundation.URL
    
    public init(URL : Foundation.URL) {
        self.URL = URL

        let key =  URL.absoluteString
        super.init(key: key)
    }
    
    open var session : URLSession { return URLSession.shared }
    
    var task : URLSessionDataTask? = nil
    
    var cancelled = false
    
    // MARK: Fetcher
    
    open override func fetch(failure fail : @escaping ((NSError?) -> ()), success succeed : @escaping (T.Result) -> ()) {
        self.cancelled = false
        self.task = self.session.dataTask(with: self.URL, completionHandler: {[weak self] (data, response, error) -> Void in
            if let strongSelf = self {
                strongSelf.onReceiveData(data, response: response, error: error as! NSError, failure: fail, success: succeed)
            }
        }) 
        self.task?.resume()
    }
    
    open override func cancelFetch() {
        self.task?.cancel()
        self.cancelled = true
    }
    
    // MARK: Private
    
    fileprivate func onReceiveData(_ data: Data!, response: URLResponse!, error: NSError!, failure fail: @escaping ((NSError?) -> ()), success succeed: @escaping (T.Result) -> ()) {

        if cancelled { return }
        
        let URL = self.URL
        
        if let error = error {
            if (error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled) { return }
            
            Log.debug("Request \(URL.absoluteString) failed", error)
            DispatchQueue.main.async(execute: { fail(error) })
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, !httpResponse.hnk_isValidStatusCode() {
            let description = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            self.failWithCode(.invalidStatusCode, localizedDescription: description, failure: fail)
            return
        }

        if !response.hnk_validateLengthOfData(data) {
            let localizedFormat = NSLocalizedString("Request expected %ld bytes and received %ld bytes", comment: "Error description")
            let description = String(format:localizedFormat, response.expectedContentLength, data.count)
            self.failWithCode(.missingData, localizedDescription: description, failure: fail)
            return
        }
        
        guard let value = T.convertFromData(data) else {
            let localizedFormat = NSLocalizedString("Failed to convert value from data at URL %@", comment: "Error description")
            let description = String(format:localizedFormat, URL.absoluteString)
            self.failWithCode(.InvalidData, localizedDescription: description, failure: fail)
            return
        }

        DispatchQueue.main.async { succeed(value) }

    }
    
    fileprivate func failWithCode(_ code: HanekeGlobals.NetworkFetcher.ErrorCode, localizedDescription: String, failure fail: @escaping ((NSError?) -> ())) {
        let error = errorWithCode(code.rawValue, description: localizedDescription)
        Log.debug(localizedDescription, error)
        DispatchQueue.main.async { fail(error) }
    }
}
