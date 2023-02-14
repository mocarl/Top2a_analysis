padNAcolumns <- function( string, tot.columns) {
  mydata = get(string)
  columnsneeeded = tot.columns - ncol(mydata)
  temp = data.frame(matrix(data = NA, nrow = nrow(mydata),ncol = columnsneeeded))
  offset = grep("X0", colnames(mydata))
  last.column = 
  start = grep(paste0("X",(length(mydata)-offset)), colnames(mydata))-offset+1
  
  end = tot.columns-offset
  colnames(temp) = sprintf("X%d",start:end)
  mydata = cbind(mydata, temp)
  return(assign(string, mydata, envir = parent.frame()))
}