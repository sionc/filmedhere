@films = Film.all
Rails.cache.write('films', @films)
Rails.logger.info "Writing 'films' to rails cache"

@films_as_json = @films.as_json(:include => :locations)
Rails.cache.write('films_as_json', @films_as_json)
Rails.logger.info "Writing 'films_as_json' to rails cache"