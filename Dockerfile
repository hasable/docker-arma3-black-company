FROM hasable/a3-exile:1.0.3
LABEL maintainer='hasable'

WORKDIR /opt/arma3

COPY --chown=server resources/@A3XAI @A3XAI
COPY --chown=server resources/@AdminToolkitServer @AdminToolkitServer
COPY --chown=server resources/keys/admintoolkit.bikey keys/
COPY --chown=server resources/@ExileServer @ExileServer
COPY --chown=server resources/@ExAd @ExAd

COPY --chown=server resources/mpmissions mpmissions
COPY --chown=server resources/keys/badbenson.bikey resources/keys/cba_3.4.1.170912.bikey resources/keys/ds20_jul2017.bikey keys/

#COPY --chown=server resources/@AdvancedRappelling @AdvancedRappelling
#COPY --chown=server resources/keys/advancedrappelling.bikey keys/

#COPY --chown=server resources/@AdvancedServerScripts @AdvancedServerScripts

#COPY --chown=server resources/@AdvancedTowing AdvancedTowing
#COPY --chown=server resources/keys/advancedtowing.bikey keys/

#COPY --chown=server resources/@AdvancedUrbanRappelling @AdvancedUrbanRappelling
#COPY --chown=server resources/keys/advancedurbanrappelling.bikey keys/

USER server

CMD [	"\"-config=@ExileServer/config.cfg\"", \
		"\"-servermod=@ExileServer;@AdminToolkitServer;@ExAd;@A3XAI\"", \
		"\"-mod=@Exile;expansion;heli;jets;mark;@CBA_A3;@DynaSound2;@EnhancedMovement\"", \
		"-bepath=/opt/arma3/battleye", \
 		"-maxMem=3500", \
		"-world=empty", \
 		"-autoinit" ]
