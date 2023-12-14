FROM harness/delegate:23.11.81601
COPY install_tools.sh .
#RUN ls -ltr
RUN chmod +x install_tools.sh
RUN "./install_tools.sh"
