code_ud <- function(x, y =list(0.1, -0.1)){
  max1 <- max(as.numeric(y))
  min1 <- min(as.numeric(y))
  
  if (x > max1){
    2
  } else if (x > min1) {
    1
  } else {
    0
  }
}

# ---
apply(ret, 1, code_ud)

# 001 002 010 012 020 021 022
# 100 101 102 110 112 121 122
# 200 201 202 210 212 221 222

