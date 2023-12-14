FROM harness/delegate:23.12.81604
COPY install_tools.sh .
#RUN ls -ltr
USER root
RUN chmod +x install_tools.sh
RUN "./install_tools.sh"
USER harness
ENV PATH="${PATH}:/opt/harness-delegate/google-cloud-sdk/bin:/opt/gradle-4.10.2/bin"
