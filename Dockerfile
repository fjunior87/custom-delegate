FROM harness/delegate:23.11.81601
COPY install_tools.sh .
#RUN ls -ltr
RUN microdnf install sudo
RUN sudo chmod +x install_tools.sh
RUN "./install_tools.sh"
