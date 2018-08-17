FROM ubuntu:14.04
MAINTAINER Sylvain POULAIN <sylvain.poulain@giscan.com> /docker-micmac
#Install dependencies
RUN apt-get update && apt-get install -y --install-recommends \
x11proto-core-dev make cmake libx11-dev mercurial subversion imagemagick gcc g++ \
exiv2 libimage-exiftool-perl libgeo-proj4-perl \ 
mesa-common-dev libgl1-mesa-dev libglapi-mesa libglu1-mesa \
qt5-default doxygen opencl-headers
#Download setup.sh and run it to install MicMac
ADD setup.sh /setup.sh
ADD update_micmac.sh /update_micmac.sh
RUN chmod +x /setup.sh
RUN chmod +x /update_micmac.sh
RUN /setup.sh

ENV PATH="/micmac/bin:${PATH}"

#Mount /home (persistent data)
VOLUME /home
WORKDIR /home

# http://www.torkwrench.com/2011/12/16/d-bus-library-appears-to-be-incorrectly-set-up-failed-to-read-machine-uuid-failed-to-open-varlibdbusmachine-id/
RUN apt-get update && apt-get install -y dbus
RUN dbus-uuidgen > /var/lib/dbus/machine-id