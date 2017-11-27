FROM hasable/a3-exile:latest
LABEL maintainer='hasable'

# Server user
ARG USER_NAME=steamu

USER root

WORKDIR /opt/arma3
COPY resources/@AdminToolkitServer @AdminToolkitServer
COPY resources/@A3XAI @A3XAI
COPY resources/@ExAd @ExAd
COPY resources/@ExileServer @ExileServer
COPY resources/mpmissions/* mpmissions/
COPY resources/keys/* keys/

RUN chown -R ${USER_NAME}:${USER_NAME} @AdminToolkitServer @A3XAI @ExAd @ExileServer mpmissions keys

USER ${USER_NAME}

CMD ["\"-config=conf/exile.cfg\"", \
	"\"-servermod=@ExileServer;@AdminToolkitServer;@ExAd;@A3XAI\"", \
	"\"-mod=@Exile;expansion;heli;jets;mark\"", \
	"-bepath=/opt/arma3/battleye", \
		"-world=empty", \
		"-autoinit"]
