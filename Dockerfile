FROM hasable/exile:latest
LABEL maintainer='hasable'

USER server

WORKDIR /opt/arma3
COPY resources/@AdminToolkitServer @AdminToolkitServer
COPY resources/mpmissions/* mpmissions/
COPY resources/keys/* keys/

CMD ["\"-config=@ExileServer/config.cfg\"", "\"-servermod=@ExileServer;@AdminToolkitServer\"", "\"-mod=@Exile;expansion;heli;jets;mark\"", "-autoinit"]
