#!/usr/bin/env bash

Usage="Usage: tachyon-stop.sh [-h] [component] 
Where component is one of:
  all\t\t\tStop local master/worker and remote workers. Default.
  master\t\tStop local master.
  worker\t\tStop local worker.
  workers\t\tStop local worker and all remote workers.

-h  display this help."
bin=`cd "$( dirname "$0" )"; pwd`

kill_master() {
  $bin/tachyon killAll tachyon.master.TachyonMaster
}

kill_worker() {
  $bin/tachyon killAll tachyon.worker.TachyonWorker
}

kill_remote_workers() {
  $bin/tachyon-workers.sh $bin/tachyon killAll tachyon.worker.TachyonWorker
}

WHAT=${1:-all}

case "$WHAT" in
  master)
    kill_master
    ;;
  worker)
    kill_worker
    ;;
  workers)
    kill_worker
    kill_remote_workers
    ;;
  all)
    kill_master
    kill_worker
    kill_remote_workers
    ;;
  -h)
    echo -e "$Usage"
    exit 0
    ;;
  *)
    echo "Error: Invalid component: $WHAT"
    echo -e "$Usage"
    exit 1
    ;;
esac

