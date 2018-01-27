FROM hasable/arma3-bots:latest
LABEL maintainer='hasable'

ARG USER_NAME=steamu

USER root
WORKDIR /home/steamu
COPY sources sources
RUN chown -R ${steamu}:${steamu} sources

# Server user
USER ${USER_NAME}
WORKDIR /opt/arma3
ENTRYPOINT ["/usr/local/bin/docker-entrypoint", "/opt/arma3/arma3server"]
CMD ["\"-config=conf/exile.cfg\"", \
		"\"-servermod=@ExileServer;@A3XAI;@AdminToolkitServer;@AdvancedRappelling;@AdvancedUrbanRappelling;@DMS;@Enigma;@ExAd;@Occupation;@VEMF;@ZCP\"", \
		"\"-mod=@Exile;@CBA_A3;@CUPWeapons;@CUPUnits;@CUPVehicles;@R3FArmes;@R3FUnites\"", \
		"-world=empty", \
		"-autoinit"]
