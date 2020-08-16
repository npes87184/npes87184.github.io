FROM jekyll/jekyll

COPY --chown=jekyll:jekyll Gemfile .

RUN bundle install

CMD ["jekyll", "serve"]
