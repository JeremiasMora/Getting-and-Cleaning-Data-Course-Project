# CodeBook
In this markdown I explain the different step in the archive `run_analysis.R`, this archive has 6 steps.

##### Step 0: loading data set 
In this step, I load all the databases needed for the analysis and save them almost as their original name. For example:
* `x.train` = this data is train set
* `y.train` = this data is train label
* `subject.train` = this data is a train data about volunteer subjects
* `train` = this data is a merge about `x.train`, `y.train` and `subject.train`

In the case of test data set, is very similar:
* `x.test` = this data is test set
* `y.test` = this data is test label
* `subject.test` = this data is a test data about volunteer subjects
* `test` = this data is a merge about `x.test`, `y.tes`t and `subject.test`

And finally, the `activity_labels.txt` is loading in `activity`, and this data is a list of the different activities with your labels.

##### Step 1: Merge data
I merge the data defined above
* `x.data` = merge about `x.train` with `x.test`
* `y.data` = merge about `y.train` with `y.test`
* `subject.data` = merge about `subject.train` with `subject.test`
* `data` = merge about `test` with `train`

I determine a column name from `subject.data`, this name is "Subject".

##### Step 2: Mean and standard deviation for each measurement
* `features` = data of features
* `mean.std` = data of mean and standar desviation for each measurement


##### Step 3: Descriptive activity names
In this step, I determine a column name from `y.data`, this name is "Activity". Also, I obtain a `final.data`, this is a column merge about mean.std, y.data and `subject.data`


##### Step 4: Appropriately labels
In this step, I give the correct names to the descriptive variables.


##### Step 5: Create data
A `tidydataset.txt` is created based on everything developed in the previous steps, but specifically with step 4.


