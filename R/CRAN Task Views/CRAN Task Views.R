library(ctv)                                                                                         #to pull CRAN task views
library(tictoc)                                                                                      #to calculate elapsed time

# pulls a list of available tasks views (including package list) in CRAN
tic('list of available views')
   a <- available.views()
toc()
#running time: 0.06 sec elapsed

# extracts ONLY the name of all available views from a
for (i in 1:length(a)){
  a_ <- unlist(a[i])[1]
  if (i == 1){
    viewlist <- a_
  }
  else {
    viewlist <- rbind(viewlist, a_)
  }
}
viewlist <- as.vector(viewlist)
rm(a, a_, i)                                                                                         #remove variables not in use anymore

# ways to look at elements in the viewlist
# View(viewlist)
print(paste(viewlist, collapse=', '))    

# updating specific views
tic('list of available views')
#update.views(viewlist)                                                                              #not advisable: too many packages are being updated
update.views('MachineLearning')
toc()
#running time: 377.53 sec elapsed                                                                    #this may vary according to the view being updated

# pulls up summary info of the view
x <- read.ctv(system.file('ctv', 'MachineLearning.ctv', package = 'ctv'))
x

# stores the complete information of the view in an html 
y1 <- ctv2html(system.file('ctv', 'MachineLearning.ctv', package = 'ctv'), 
               file = 'D:/Work Files/Github/R/CRAN Task Views/Sample - Machine Learning.html')


