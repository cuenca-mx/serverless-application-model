target:
	$(info ${HELP_MESSAGE})
	@exit 0
	
init:
	pip install -e '.[dev]'

test:
	pytest --cov samtranslator --cov-report term-missing --cov-fail-under 95 tests/*

test-integ:
	pytest --no-cov tests_integ/*

black:
	black setup.py samtranslator/* tests/* tests_integ/* bin/*

black-check:
	black --check setup.py samtranslator/* tests/* tests_integ/* bin/*

# Command to run everytime you make changes to verify everything works
dev: test

# Verifications to run before sending a pull request
pr: black-check init dev

define HELP_MESSAGE

Usage: $ make [TARGETS]

TARGETS
	init        Initialize and install the requirements and dev-requirements for this project.
	test        Run the Unit tests.
	test-integ  Run the Integration tests.
	dev         Run all development tests after a change.
	pr          Perform all checks before submitting a Pull Request.

endef
