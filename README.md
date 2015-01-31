# Scrumbag

Remembers what you did yesterday so you don't have to

## Requirements

* Node.js / NPM

## Installation

* `git clone https://github.com/mwise/Scrumbag.git`
* `cd Scrumbag`
* `npm install`
* `grunt build`
* `npm start`

## Usage

* enter your Pivotal Tracker API Token

## Hacking on Scrumbag

Make code changes in `./src` and they will be compiled to `./app` via the `watch` task.

```bash
grunt watch
```

## Running the built in webserver

Scrumbag ships with a simple static site server via Express:

```bash
grunt build
npm start
```

The site will served out of `./app` and be available at `http://localhost:8080`

## Deployment

Deployment is done via the grunt-rsync plugin.

* copy `secret.dist.json` to `secret.json`
* update values in `secret.json`
* `grunt deploy`

## License

MIT
