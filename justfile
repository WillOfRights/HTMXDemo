RUN_DIR:="./run"
TARGET_DIR:="./backend/target"
PID_FILE:="./run/pid"
LOG_FILE:="../run/servlet.log"

SPRING_RUN:="cd backend && ./mvnw spring-boot:run"
WATCH_BACKEND:="cd backend && watchexec -r --postpone -d 1000 -e html,css './mvnw resources:resources'"

run: stop
  @echo "Starting running spring boot"
  {{SPRING_RUN}} >> {{LOG_FILE}} 2>&1 & echo $! >> {{PID_FILE}}
  @echo "Processes started. PIDs saved in {{PID_FILE}}."

run-watch: stop
  @echo "Starting running spring boot and watching file changes"
  {{SPRING_RUN}} >> {{LOG_FILE}} 2>&1 & echo $! >> {{PID_FILE}}
  {{WATCH_BACKEND}} >> {{LOG_FILE}} 2>&1 & echo $! >> {{PID_FILE}}
  @echo "Processes started. PIDs saved in {{PID_FILE}}."

stop:
  @if [ -f {{PID_FILE}} ]; then \
    echo "Stopping processes..."; \
    cat {{PID_FILE}} | xargs kill; \
    rm {{PID_FILE}}; \
      echo "Processes stopped."; \
    else \
      echo "No PID file found. Nothing to stop."; \
    fi

clean:
  @echo "Cleaning target and run directories"
  rm -rf {{TARGET_DIR}}
  rm -rf {{RUN_DIR}}/*
  @echo "Directories cleaned"
