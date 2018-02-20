# Helm Local Plugin

Run Tiller as a local daemon.

```
  helm local start
  helm local COMMAND
```

You can setup environment variables to run helm commands directly.

```
  source <(helm local env)
  helm list

```

## Usage

```
helm local [command]

Environment:
  TILLER_ADDR   address:port to listen on (default ":44134")
  TILLER_ARGS   extra args to pass to Tiller
  TILLER_BIN    Tiller binary to use
  TILLER_LOG    log to file (default: "/tmp/tiller.log")

Available Commands:
  env           setup environment variables
  kill          kill running instance of Tiller
  start         start a local Tiller instance
  status        get status of running Tiller
```

## Install

```
$ helm plugin install https://github.com/adamreese/helm-local
Installed plugin: local
```

