#Code Book For Tidy Data

#####Variable 01          
    subject      
      Description: subject is an integer with a range from 1 to 30 used to represent one of the 30 subjects  
      in the study.  
      
      Data Prep Note: subject was taken from one of two separate text files and combined with the larger data  
      set via the cbind() function. Used in combination with the activity field to determine the subset used  
      to generate the aggregate mean value for each of the 66 variables (#03-#68) representing a mean value  
      or standard deviation recording.
      
#####Variable 02          
    activity          
      Description: activity is an character string used to represent one of the six activities (e.g. 'Walking')     
      in the study.  
      
      Data Prep Note: activity was taken from one of two separate text files and combined with the larger data  
      set via the cbind() function. Used in combination with the subject field to determine the subset used  
      to generate the aggregate mean value for each of the 66 variables (#03-#68) representing a mean value  
      or standard deviation recording.     
