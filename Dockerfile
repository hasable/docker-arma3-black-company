FROM hasable/a3-exile:latest
LABEL maintainer='hasable'

# Server user
ARG USER_NAME=steamu

USER root

WORKDIR /root
RUN apt-get update \
	&& apt-get install -y curl liblzo2-2 libvorbis0a libvorbisfile3 libvorbisenc2 libogg0 p7zip-full rename \
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

RUN chown -R ${USER_NAME}:${USER_NAME} @A3XAI @AdminToolkitServer @AdvancedRappelling @AdvancedServerScripts @AdvancedTowing @AdvancedUrbanRappelling keys 

WORKDIR /home/${USER_NAME}/sources
COPY sources ./
RUN cd .. && chown -R ${USER_NAME}:${USER_NAME} sources

USER ${USER_NAME}

WORKDIR /tmp

# Install CBA_A3
RUN wget -nv https://github.com/CBATeam/CBA_A3/releases/download/v3.5.0.171204/CBA_A3_v3.5.0.zip \
	&& unzip CBA_A3_v3.5.0.zip && rm -f CBA_A3_v3.5.0.zip \
	&& cd \@CBA_A3 \
		&& rm -f *.md \
		&& mv keys/* /opt/arma3/keys && rmdir keys \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
		&& cd .. \
	&& mv \@CBA_A3 /opt/arma3/@\CBA_A3

# Install CUP Weapons
RUN ggID=0By04o_GxOry3eHppeUpoNTZ6SjQ \
		&& ggURL=https://drive.google.com/uc?export=download \
		&& curl -sc /tmp/gcookie "${ggURL}&id=${ggID}" >/dev/null \
		&& ggCode="$(awk '/_warning_/ {print $NF}' /tmp/gcookie)"  \
		&& curl -LOJb /tmp/gcookie "${ggURL}&confirm=${ggCode}&id=${ggID}" \
	&& unzip \@CUP_Weapons-1.10.0.zip && rm -f \@CUP_Weapons-1.10.0.zip \
	&& cd \@CUP_Weapons \
		&& mv Keys/cup_weapons-1.10.0.bikey /opt/arma3/keys/cup_weapons-1.10.0.bikey \
		&& rm -rf *.txt *.sha1 Keys \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
		&& cd .. \
	&& mv \@CUP_Weapons /opt/arma3/\@CUPWeapons

# Install CUP Units	
RUN ggID=0By04o_GxOry3cm5TVXV4LXhuLVE \
		&& ggURL=https://drive.google.com/uc?export=download \
		&& curl -sc /tmp/gcookie "${ggURL}&id=${ggID}" >/dev/null \
		&& ggCode="$(awk '/_warning_/ {print $NF}' /tmp/gcookie)"  \
		&& curl -LOJb /tmp/gcookie "${ggURL}&confirm=${ggCode}&id=${ggID}" \
	&& unzip \@CUP_Units-1.10.0.zip && rm -f \@CUP_Units-1.10.0.zip \
	&& cd \@CUP_Units \
		&& mv Keys/cup_units-1.10.0.bikey /opt/arma3/keys/cup_units-1.10.0.bikey \
		&& rm -rf *.txt *.sha1 Keys \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
	&& cd .. \
	&& mv \@CUP_Units /opt/arma3/\@CUPUnits
	
# Install CUP Vehicles	
RUN ggID=0By04o_GxOry3OG1qcC1oUEwyUXM \
		&& ggURL=https://drive.google.com/uc?export=download \
		&& curl -sc /tmp/gcookie "${ggURL}&id=${ggID}" >/dev/null \
		&& ggCode="$(awk '/_warning_/ {print $NF}' /tmp/gcookie)"  \
		&& curl -LOJb /tmp/gcookie "${ggURL}&confirm=${ggCode}&id=${ggID}" \
	&& unzip \@CUP_Vehicles-1.10.0.zip && rm -f \@CUP_Vehicles-1.10.0.zip \
	&& cd \@CUP_Vehicles \
		&& mv Keys/cup_vehicles-1.10.0.bikey /opt/arma3/keys/cup_vehicles-1.10.0.bikey \
		&& rm -rf *.txt *.sha1 Keys \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
	&& cd .. \
	&& mv \@CUP_Vehicles /opt/arma3/\@CUPVehicles

# Install R3F Weapons	
RUN wget -nv http://team-r3f.org/public/addons/R3F_ARMES_3.5.7z \
	&& p7zip -d R3F_ARMES_3.5.7z \
	&& cd \@R3F_ARMES \
		&& rm -f *.pdf *.url \
		&& mv Server_Key/r3f.bikey /opt/arma3/keys/r3fa.bikey && rmdir Server_Key \
		&& find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \; \
		&& cd .. \
	&& mv \@R3F_ARMES /opt/arma3/\@R3FArmes
	
# Install R3F Units
RUN wget -nv http://team-r3f.org/public/addons/R3F_UNITES_3.7.7z \
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
	&& cd @ZCP/addons && makepbo -N a3_zcp_exile && mkdir -p /opt/arma3/@ZCP/addons/ \
		&& mv a3_zcp_exile.pbo /opt/arma3/@ZCP/addons/a3_zcp_exile.pbo \
		&& cd ../.. && rm -rf @ZCP \
	&& cd mpmissions \
		&& for mission in *; do makepbo -N ${mission} && mv -f ${mission}.pbo /opt/arma3/mpmissions/; done \
		&& cd .. && rm -rf mpmissions
		
WORKDIR /opt/arma3

CMD ["\"-config=conf/exile.cfg\"", \
	"\"-servermod=@ExileServer;@A3XAI;@AdvancedTowing;@AdvancedServerScripts;@AdminToolkitServer;@DMS;@ExAd;@Occupation;@ZCP\"", \
	"\"-mod=@Exile;@CBA_A3;@CUPWeapons;@CUPUnits;@CUPVehicles;@R3FArmes;@R3FUnites;expansion;heli;jets;mark\"", \
	"-bepath=/opt/arma3/battleye", \
	"-world=empty", \
		"-autoinit"]

	
	
