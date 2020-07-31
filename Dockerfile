# This dockerfile, when run, will by default download and process uc data into a feather format.
FROM rocker/tidyverse
RUN mkdir /data

COPY unemploymentDataProcessor.R config.yml /Rscripts/

# /data should be a volume mount, where the dataprocessor will write.

RUN install2.r RCurl zoo config &&\
    installGithub.r https://github.com/sboysel/fredr.git 
RUN chmod u+x /Rscripts/unemploymentDataProcessor.R
WORKDIR /RScripts
CMD ["Rscript","/Rscripts/unemploymentDataProcessor.R"]
