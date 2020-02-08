run-app:
	@echo "Starting visits recorder app"

	@sudo docker-compose build
	@sudo docker-compose up -d

	@sleep 15

	@echo "Fetching and populating data"

	@sudo docker-compose exec shastic_challenge bundle exec ruby -r './app.rb' -e 'call'
	@echo "Visits and pageviews recorded successfully"

remove-containers:
	@sudo docker-compose down -v
