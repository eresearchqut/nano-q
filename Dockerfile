FROM alpine:latest as decomp
RUN apk add git
RUN mkdir /opt/ ; \
  git clone https://github.com/PrestonLeung/Nano-Q.git /opt/ ; git checkout f1ebf0cb5a972417340b6e2bb4b93089d3b9ca78 ; dos2unix /opt/*.py; chmod +x /opt/*.py


FROM continuumio/miniconda3:4.12.0

RUN conda install mamba -n base -c conda-forge
COPY packages.txt /
RUN mamba install --file /packages.txt -c bioconda -c conda-forge

COPY --from=decomp /opt/ /usr/local/bin/
RUN ln -s $(which python) /usr/bin/python

