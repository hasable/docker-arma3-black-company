FROM hasable/a3-exile:1.0.3
LABEL maintainer='hasable'

WORKDIR /opt/arma3

USER root

COPY resources/@A3XAI @A3XAI
COPY resources/@AdminToolkitServer @AdminToolkitServer
COPY resources/keys/admintoolkit.bikey keys/
COPY resources/@ExileServer @ExileServer
COPY resources/@ExAd @ExAd

COPY resources/mpmissions mpmissions
COPY resources/keys/badbenson.bikey resources/keys/cba_3.4.1.170912.bikey resources/keys/ds20_jul2017.bikey keys/

# COPY --chown=server <src> <dest> is available on last version of docker, but not on dockerhub...
RUN chown -R server:server @A3XAI @AdminToolkitServer @ExileServer @ExAd keys mpmissions \
	&& chmod -R 755 @A3XAI @AdminToolkitServer @ExileServer @ExAd keys mpmissions

#COPY resources/@AdvancedRappelling @AdvancedRappelling
#COPY resources/keys/advancedrappelling.bikey keys/

#COPY resources/@AdvancedServerScripts @AdvancedServerScripts

#COPY resources/@AdvancedTowing AdvancedTowing
#COPY resources/keys/advancedtowing.bikey keys/

#COPY resources/@AdvancedUrbanRappelling @AdvancedUrbanRappelling
#COPY resources/keys/advancedurbanrappelling.bikey keys/

USER server

CMD [	"\"-config=@ExileServer/config.cfg\"", \
		"\"-servermod=@ExileServer;@AdminToolkitServer;@ExAd;@A3XAI\"", \
		"\"-mod=@Exile;expansion;heli;jets;mark;@CBA_A3;@DynaSound2;@EnhancedMovement\"", \
		"-bepath=/opt/arma3/battleye", \
 		"-maxMem=3500", \
		"-world=empty", \
 		"-autoinit" ]
