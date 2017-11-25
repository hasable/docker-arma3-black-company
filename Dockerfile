FROM hasable/a3-exile:1.0.3
LABEL maintainer='hasable'

USER root

WORKDIR /opt/arma3
COPY resources/@AdminToolkitServer @AdminToolkitServer
COPY resources/@A3XAI @A3XAI
COPY resources/@ExAd @ExAd
COPY resources/@ExileServer @ExileServer
COPY resources/mpmissions/* mpmissions/
COPY resources/keys/* keys/

RUN chown -R server:server @AdminToolkitServer @A3XAI @ExAd @ExileServer mpmissions keys

USER server

CMD ["\"-config=@ExileServer/config.cfg\"", \
	"\"-servermod=@ExileServer;@AdminToolkitServer;@ExAd;@A3XAI\"", \
	"\"-mod=@Exile;expansion;heli;jets;mark\"", \
	"-autoinit"]

