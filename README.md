# facerecognition_PCA
# Face Recognition using PCA in matlab #
* A set of 6 images of 15 subjects are  trained for face recognition using PCA method 
* Each image which is 243*320 pixels, is reshaped into a column vector is concatenated to matrix of size 77760*90
* Since each pixel is a variable, covariance matrix will make upto matrix of size 77760*77760, which will exceed the memory, therefore
each sample of a subject is used as observation to make covarince matrix of 6*6 for each person(subject)
* Each pixel is mean-shifted(subtracting the row by mean) and covariance matrix is computed using X'X
* Eigen value and eigen vector of the covariance matrix is computed 
* The original data is projected on the PC corresponding to the largest eigen value, that gives a single vector of each subject
know as the representative image vector
* The above step basically does a dimentionality reduction from a dimension 6 to 1
* The represetative image is used to predict the test data by computing the least eucleadin distance 
* The model was able to achieve a accuracy 65%
