ARG TAG
FROM harness/delegate:$TAG
COPY install_tools.sh .
#RUN ls -ltr
USER root
RUN chmod +x install_tools.sh
RUN "./install_tools.sh"
USER harness
ENV PATH="${PATH}:/opt/harness-delegate/google-cloud-sdk/bin:/opt/gradle-4.10.2/bin"
