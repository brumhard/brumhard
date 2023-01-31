VERSION 0.6

FROM debian:stable-slim

deps:
    RUN apt update && apt install -y curl git cowsay
    SAVE ARTIFACT /usr/games/cowsay

hello:
    # using a patched vhs version to set no-sandbox go-rod option
    # could be replaced if https://github.com/charmbracelet/vhs/pull/195 is merged
    # maybe then also using the nix package works
    FROM ghcr.io/charmbracelet/vhs@sha256:018e10d9a61d7fe7e2fd76cfd3103211fc1a558d8c38d781bd2421fbe7230ac2
    COPY +deps/cowsay /usr/local/bin
    # enable chromium no-sandbox
    ENV VHS_NO_SANDBOX="true"
    COPY greet-visitor.sh .
    COPY hello.tape .
    RUN vhs hello.tape
    SAVE ARTIFACT hello.gif AS LOCAL hello.gif

skyline:
    FROM +deps
    RUN apt update && apt install -y curl
    RUN echo $(( $(date +%Y)-1)) > last_year
    RUN curl -sSfLo skyline.svg "https://skylines.brumhard.com/brumhard/$(cat last_year)?type=svg"
    SAVE ARTIFACT skyline.svg AS LOCAL skyline.svg

update-repo:
    FROM +deps
    COPY +skyline/skyline.svg .
    COPY +hello/hello.gif .
    RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
    RUN git config --global user.email "ci@brumhard.com" && \
        git config --global user.name "brumhard-ci-bot" && \
        git config --global url.ssh://git@github.com.insteadof https://github.com
    COPY --dir .git .
    RUN git checkout -q main && \
        git add hello.gif skyline.svg && \
        git commit -m "Regenerate files" 
    RUN --push --ssh git push