##  If a content of a matrix is not changing and compute the inverse
##  repeatedly (e.g. in a loop) is needed, these functions cache the 
##  value of the inverse. In this way, when we need it again, it can
##  be looked up in the cache rather than recomputed.

## makeCacheMatrix creates a special "matrix", which is really a 
## list containing a function to
## 	- set the value of the matrix
## 	- get the value of the matrix
## 	- set the value of the inverse
## 	- get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
	inv <- NULL
	set <- function(y){
		x <<- y
		inv <<- NULL
	}
	get <- function() x
	setinv <- function(inv_) inv <<- inv_
	getinv <- function() inv
	list(set=set, get=get, setinv = setinv, getinv = getinv)

}


## cacheSolve calculates the inverse of the special "matrix" created
## with makeCacheMatrix. However, it first checks to see if the 
## inverse has already been calculated. If so, it gets the inverse 
## from the cache and skips the computation. Otherwise, it calculates 
## the inverse of the data and sets the value of the inverse in the 
## cache via the setinv function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
	inv <- x$getinv()
	if(!is.null(inv)){
		message("getting cached data")
		return(inv)
	}
	data <- x$get()
	inv <- solve(data)
	x$setinv(inv)
	inv
}