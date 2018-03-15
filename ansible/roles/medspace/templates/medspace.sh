export RAILS_ENV=production
export RAILS_LOG_TO_STDOUT=true
export FCREPO_URL=http://127.0.0.1:8080/fcrepo/rest
export SOLR_URL=http://127.0.0.1:8983/solr/medspace
export REDIS_HOST=127.0.0.1
export SECRET_KEY_BASE="{{ medspace_secret_key_base }}"
export DEVISE_SECRET_KEY="{{ medspace_devise_secret_key }}"
export DATABASE_URL={{ medspace_database_url }}