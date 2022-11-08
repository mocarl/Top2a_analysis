### Rename Global var,

### Takes a string vector of variable names and concatenates a given 
##  string first or last to the variable name

add_prefix_varname <- function(var, string){
  for(i in var){
    if(inherits(get(i),'data.frame')){
      # obviously you want a better newName than 'foo'
      # bind the value x to the new name in the global environment
      assign(paste(string,"_",i, sep = ""),get(i),envir=.GlobalEnv)
      # delete the binding to the old name in the global environment
      rm(list=i,envir=.GlobalEnv)
    }
  }
}