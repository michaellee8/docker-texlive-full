# docker-texlive-full
Docker image for texlive-full with support for cross-architecture and latest texlive version.

## Features
- Cross architecture support (both x86_64 and aarch64), works on Apple Silicons machines.
- Automatically uses latest texlive version with PATH proper;y configured.
- (Optional) Image for VS Code Dev Containers with some additional utilities built-in.

## Notes
```Dockerfile
# fixing dvisvgm kpathsea search path
ENV TEXMFCNF=${TEXMFCNF}:/usr/local/texlive/currentversion-dist/web2c
RUN mv -f $(which dvisvgm) $(kpsewhich -var-value SELFAUTOLOC)
```

## License
MIT License
