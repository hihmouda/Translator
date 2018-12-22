//
//  Loader.swift
//  Hypanion
//
//  Created by hadeel on 11/3/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import Foundation

enum RequestType:String {
    
    case POST           = "POST"
    case GET            = "GET"
    case PUT            = "PUT"
    case DELETE         = "DELETE"
}

enum RequestBodyType : String {
    
    case JSON                       = "application/json"
    
}

extension NSMutableURLRequest {
    
    override open func isEqual(_ object: Any?) -> Bool {
        
        if let inst = object as? URLRequest {
            
            if let URL = url, URL != inst.url && (URL != inst.url) {
                
                return false
            }
            
            if let mainDocumentURL = mainDocumentURL, mainDocumentURL != inst.mainDocumentURL && (mainDocumentURL != inst.mainDocumentURL) {
                
                return false
            }
            
            if httpMethod != inst.httpMethod {
                
                return false
            }
            
            if let HTTPBody = httpBody, HTTPBody != inst.httpBody && (HTTPBody != inst.httpBody) {
                
                return false
            }
            
            if let HTTPBodyStream = httpBodyStream, HTTPBodyStream != inst.httpBodyStream  && !HTTPBodyStream.isEqual(inst.httpBodyStream) {
                
                return false
            }
        }
        
        return true
    }
    
    override open var hash: Int {
        
        return (url as NSURL?)?.hash ?? 0
    }
}

/**
 * Loads data from URL.
 **/
class Loader : NSObject {
    
    // MARK: Loader
    
    fileprivate struct Static {
        
        static var failedRequests: [Loader] = []
        
        static var activeRequests: [String: [Loader]] = [:]
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let requestObject = object as? Loader {
            
            return (request?.isEqual(requestObject.request)) ?? false
        }
        
        return false
    }
    
    override var hash: Int {
        
        return request?.url?.absoluteString.hashValue ?? 0
    }
    // Boolean value to indicate if this loader failed.
    private var isFailed : Bool
    
    // Instance of NSURLConnection to establish remote connection.
    private var task: URLSessionDataTask?
    
    // Holds the HTTP request information
    private var request: NSMutableURLRequest?
    
    // Mutable data to hold retrieved data.
    private var bytes: NSMutableData
    
    // Should handle default error
    private let shouldHandleError = true
    
    // Handler to be invoked when data loading is done.
    private var completeHandler : ((_ isSuccess: Bool, _ response: Data?) -> ())?
    
    static weak var delegate : ErrorDialogDelegate?
    
    // Loader default initializer.
    override init() {
        
        self.bytes = NSMutableData()
        
        self.isFailed = false
    }
    
   
    /**
     * Loads content of provided URL asynchronously and invoke complete handler when done.
     **/
    class func loadContentOfUrl(_ url: String, requestType: RequestType, body: Data? = nil, bodyType: RequestBodyType? = nil,  isAuthenticated: Bool = true, authPrefix: String = "", timeout: Double = 20, completeHandler: ((_ isSuccess: Bool, _ response: Data?) -> ())?) {
        
        // Instantiate a Loader.
        let dataLoader = Loader()
        
        // Hold complete handler.
        dataLoader.completeHandler = completeHandler
        
        // Establish actual connection.
        if let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            
            if let url = URL(string: urlString) {
                
                let request = NSMutableURLRequest(url: url)
                
                request.timeoutInterval = timeout;
                
                if  let body = body {
                    
                    request.httpBody = body
                }
                
                if let bodyType = bodyType {
                    
                    request.addValue(bodyType.rawValue, forHTTPHeaderField: "Content-Type")
                    
                    request.addValue(bodyType.rawValue, forHTTPHeaderField: "Accept")
                }
                
                request.httpMethod = requestType.rawValue
                
                //TODO:
                if isAuthenticated {
                    
                    var authToken = ""
                    
                    request.addValue(authToken, forHTTPHeaderField: "Authorization")
                    
                }
                
                
                dataLoader.request = request
                
                issueRequest(dataLoader)
                
            }
            
        }
    }

    /**
     * Invoke the actual request
     */
    fileprivate class func issueRequest(_ dataLoader: Loader) {
        
        deleteLoaderFromFailedRequests(dataLoader)
        
        // issue the actual request
        if let request = dataLoader.request as URLRequest? {
            
            dataLoader.task?.cancel()
            
            dataLoader.task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let response = response, let data = data {
                    
                    dataLoader.didReceiveData(data: data)
                    
                    dataLoader.didReceiveReponse(response: response)
                    
                } else if let error = error {
                    
                    dataLoader.didFailWithError(error: error)
                }
            }
            
            dataLoader.task?.resume()
        }
    }
    
    fileprivate class func deleteLoaderFromFailedRequests(_ dataLoader:Loader) {
        
        Loader.Static.failedRequests = Loader.Static.failedRequests.filter({ !$0.isEqual(dataLoader) })
    }

    
    /**
     * Hold retrieve data.
     **/
    private func didReceiveData(data: Data) {
        
        self.bytes.append(data)
    }
    
    private func didReceiveReponse(response: URLResponse) {
        
        // Hold https response code
        let httpResponse = response as? HTTPURLResponse
        
        if let statusCode = httpResponse?.statusCode , let absoluteString = response.url?.absoluteString {
            
            print("Loader, connection didReceiveResponse: \(String(statusCode)) from: \(absoluteString)")
        }
        
        self.didFinishLoading()
    }
    
    /**
     * Handle connection errors.
     **/
    private func didFailWithError(error: Error) {
        //TOD00
        print("Loader connection: didFailWithError: \(error)")
        
        // Mark this loader as failed.
        self.isFailed = true
        
        if shouldHandleError {
            ///TODO:
          
        }
    }
    
    /**
     * ّInvoke complete handler with retrieved data.
     **/
    func didFinishLoading() {
        
        if let responseStr : String = String(data: bytes as Data, encoding: String.Encoding.utf8), isFailed {

            //TODO:
        }
        
        if self.isFailed && shouldHandleError {
            //TODO:
        }
        
        //return response as NSData
        self.didComplete(!self.isFailed, response: bytes as Data)
    }
    
    
    /**
     * A private internal completion handle to do common handling before calling the
     * external completion handler
     */
    fileprivate func didComplete(_ isSuccess: Bool, response: Data?) {
        
        if !isSuccess {
            
            Loader.deleteLoaderFromFailedRequests(self)
            
            Static.failedRequests.append(self)
            
            self.completeHandler?(isSuccess, response)
            
        } else {
            
            self.completeHandler?(isSuccess, response)
        }
    }
    
    deinit {
        
        print("Loader deinit ...")
    }
}
