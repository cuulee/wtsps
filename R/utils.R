#' Send a HTTP request
#'
#' @description This function submits a HTTP request to a URL
#' 
#' @param http_request a HTTP request
#' @export
sendHttpRequest <- function(http_request) {
  
  tryCatch(http_response <- RCurl::getURL(http_request), # check if URL exists and perform the request
           error = function(e) { # error method
                e$message <- paste("HTTP request failed. The URL server may be incorrect or the service may be temporarily unavailable."); 
                stop(e); # stop with that message when no URL exists
          })
  
  return(http_response) # return http response
  
}

#' Parse a JSON response
#'
#' @description This function parses a JSON reponse
#' 
#' @param json_response a server response
#' @export
parseJsonResponse <- function(json_response) {
  
  if (jsonlite::validate(json_response)) { # if HTTP response contains a valid json
    json_list <- jsonlite::fromJSON(json_response) # parse json
    if("exception" %in% names(json_list)) stop(json_response) # in the case server has an error json response stop
    return(json_list) # otherwise return json as a list
  }
  else
    stop(json_response) # stop with a not valid json response
  
}