FROM hasable/a3-exile:latest
LABEL maintainer='hasable'

# Server user
ARG USER_NAME=steamu

USER root

WORKDIR /root
RUN apt-get install -y liblzo2-2 libvorbis0a libvorbisfile3 libvorbisenc2 libogg0 p7zip-full rename \
	&& wget https://armaservices.maverick-applications.com/Products/MikerosDosTools/DownloadFree.aspx?download=depbo-tools-0.6.54-linux-64bit.tgz -O depbo-tools-0.6.54-linux-64bit.tgz \
	&& tar xvfz depbo-tools-0.6.54-linux-64bit.tgz \ 
	&& cp depbo-tools-0.6.54/bin/* /usr/local/bin/ \
	&& cp depbo-tools-0.6.54/lib/libdepbo.so.0.6.54 /usr/local/lib/ \
	&& ln -s /usr/local/lib/libdepbo.so.0.6.54 /usr/local/lib/libdepbo.so.0 \
	&& ldconfig \
	&& rm -rf  depbo-tools-0.6.54*
	
WORKDIR /opt
COPY bin/docker-entrypoint.sh /opt
RUN chmod +x /opt/docker-entrypoint.sh
	
WORKDIR /opt/arma3
COPY resources/@A3XAI @A3XAI
COPY resources/@AdminToolkitServer @AdminToolkitServer
COPY resources/@AdvancedRappelling @AdvancedRappelling
COPY resources/@AdvancedServerScripts @AdvancedServerScripts
COPY resources/@AdvancedTowing @AdvancedTowing
COPY resources/@AdvancedUrbanRappelling @AdvancedUrbanRappelling
COPY resources/keys/* keys/

RUN chown -R ${USER_NAME}:${USER_NAME} @A3XAI @AdminToolkitServer @AdvancedRappelling @AdvancedServerScripts @AdvancedTowing @AdvancedUrbanRappelling @ExileServer keys 

WORKDIR /home/${USER_NAME}/sources
COPY sources ./
RUN cd .. && chown -R ${USER_NAME}:${USER_NAME} sources

USER ${USER_NAME}

WORKDIR /tmp
RUN wget -nv http://team-r3f.org/public/addons/R3F_ARMES_3.5.7z \
	&& p7zip -d R3F_ARMES_3.5.7z \
	&& cd \@R3F_ARMES \
		&& rm -f *.pdf *.url \
		&& mv Server_Key/r3f.bikey /opt/arma3/keys/r3fa.bikey && rmdir Server_Key \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
		&& cd .. \
	&& mv \@R3F_ARMES /opt/arma3/\@R3FArmes \
	&& wget -nv http://team-r3f.org/public/addons/R3F_UNITES_3.7.7z \
	&& p7zip -d R3F_UNITES_3.7.7z  \
	&& cd \@R3F_UNITES \
		&& rm -f *.pdf *.url \
		&& mv Server_Key/r3f.bikey /opt/arma3/keys/r3fu.bikey && rmdir Server_Key \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
		&& cd .. \
	&& mv \@R3F_UNITES /opt/arma3/\@R3FUnites
	
WORKDIR /home/${USER_NAME}/sources
RUN cd @ExileServer/addons && makepbo -N exile_server_config && mkdir -p /opt/arma3/@ExileServer/addons/ \
		&& mv exile_server_config.pbo /opt/arma3/@ExileServer/addons/exile_server_config.pbo \
		&& cd ../.. \
	&& cd @AdminToolkitServer/addons && makepbo -N admintoolkit_servercfg && mkdir -p /opt/arma3/@AdminToolkitServer/addons/ \
		&& mv admintoolkit_servercfg.pbo /opt/arma3/@AdminToolkitServer/addons/admintoolkit_servercfg.pbo \
		&& cd ../.. \
	&& cd @A3XAI/addons && makepbo -N a3xai_config && mkdir -p /opt/arma3/@A3XAI/addons/ \
		&& mv a3xai_config.pbo /opt/arma3/@A3XAI/addons/a3xai_config.pbo \
		&& cd ../..  && ls -l && ls -l /opt/arma3 && rm -rf @A3XAI \
	&& cd @DMS/addons && makepbo -N a3_dms && mkdir -p /opt/arma3/@DMS/addons/ \
		&& mv a3_dms.pbo /opt/arma3/@DMS/addons/a3_dms.pbo \
		&& cd ../.. && rm -rf @DMS \
	&& cd @ExAd/addons && mkdir -p /opt/arma3/@ExAd/addons/ \
		&& makepbo -N exad_core 	&& mv exad_core.pbo /opt/arma3/@ExAd/addons/exad_core.pbo \
		&& makepbo -N exad_dv 		&& mv exad_dv.pbo /opt/arma3/@ExAd/addons/exad_dv.pbo \
		&& makepbo -N exad_grinding && mv exad_grinding.pbo /opt/arma3/@ExAd/addons/exad_grinding.pbo \
		&& makepbo -N exad_hacking  && mv exad_hacking.pbo /opt/arma3/@ExAd/addons/exad_hacking.pbo \
		&& makepbo -N exad_vg 		&& mv exad_vg.pbo /opt/arma3/@ExAd/addons/exad_vg.pbo \
		&& cd ../.. && rm -rf @ExAd \
	&& cd @Occupation/addons && makepbo -N occupation && mkdir -p /opt/arma3/@Occupation/addons/ \
		&& mv occupation.pbo /opt/arma3/@Occupation/addons/occupation.pbo \
		&& cd ../.. && rm -rf @Occupation \
	&& cd mpmissions \
		&& for mission in *; do makepbo -N ${mission} && mv -f ${mission}.pbo /opt/arma3/mpmissions/; done \
		&& cd .. && rm -rf mpmissions
	
WORKDIR /opt/arma3

CMD ["\"-config=conf/exile.cfg\"", \
	"\"-servermod=@ExileServer;@A3XAI;@AdvancedTowing;@AdvancedServerScripts;@AdminToolkitServer;@DMS;@ExAd;@Occupation\"", \
	"\"-mod=@Exile;expansion;heli;jets;mark\"", \
	"-bepath=/opt/arma3/battleye", \
	"-world=empty", \
		"-autoinit"]

	
