#baby step
a <- 4
a 

v <- c(0, 1, 2, 3, 4)

is.vector(v)
mean(v)
var(v) # variance
median(v) # median
sum(v) # sum all elements
prod(v + 1) # multiply
length(v) # how many elements in the vector

a <- 5
is.vector(a)
v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)

v2 <- character(3) # an empty vector 'character' with 3 elements
v2

MyList <- list(species=c("Quercus robur","Fraxinus excelsior"), age=c(123, 84))
MyList

pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops