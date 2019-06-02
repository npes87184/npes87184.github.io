My Blog
=====

[LINK](https://npes87184.github.io/)

### Establish environment by docker:

1. Make sure [Docker](https://www.docker.com/) installed.

2. Clone repository locally.

    ```bash
    git clone https://github.com/npes87184/npes87184.github.io.git
    ```

3. Run the following shell commands to build the docker image and start the container for the first time:

    ```bash
    cd <repository_folder>
    docker build -t beautiful-jekyll "$PWD"
    docker run -d -p 4000:4000 --name beautiful-jekyll -v "$PWD":/srv/jekyll beautiful-jekyll
    ```

Note: If you encounter write permission problems with `Gemfile.lock`, try:

```bash
touch Gemfile.lock
chmod a+w Gemfile.lock
```

Now that Docker is set up, you do not need to run the above steps again. You can now view your website at http://localhost:4000/. You can start the container again in the future with:

```bash
docker start beautiful-jekyll
```

And you can stop the server with:

```bash
docker stop beautiful-jekyll
```

Whenever you make any changes to `_config.yml`, you must stop and re-start the server for the new config settings to take effect.
