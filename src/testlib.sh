# benjaesq@me.com

dashn=
expected=0

log()
{
    echo ${dashn} "$1" >> ${logfile}
}

log_n()
{
    dashn="-n"
    log "$1"
    dashn=
}

log2()
{
    log "$1"
    echo ${dashn} "$1"
}

log2_n()
{
    dashn="-n"
    log2 "$1"
    dashn=
}

warn() { echo ${dashn} "WARN: $@" 1>&2; }

err() { echo ${dashn} "ERROR: $@" 1>&2; }

fatal() { echo ${dashn} "FATAL: $@" 1>&2; }

verbose() { echo -e "VERB: $@"; }

debug() { echo "DEBUG: $@"; }

print_test_name()
{
    echo -n "${testname}: "
    log "--${testname}: START"
}

inittest()
{
    testname="${FUNCNAME[1]}"
    print_test_name
}

print_eqtest_result()
{
    if [[ "X"$1 == "X"$2 ]]; then
        log "--${testname}: PASS"
        echo "PASS"
    else
        log "--${testname}: FAILED exit code ($1), expecting ($2)"
        echo "FAILED exit code ($1), expecting ($2)"
    fi
}

print_neqtest_result()
{
    if [[ "X"$1 != "X"$2 ]]; then
        log "--${testname}: PASS (negtest)"
        echo "PASS"
    else
        log "--${testname}: FAILED exit code ($1), expecting (0)"
        echo "FAILED exit code ($1), expecting (0)"
    fi
}

print_zero_result()
{
    print_eqtest_result $1 0
}

print_nonzero_result()
{
    print_neqtest_result $1 0
}

sh_test()
{
    $1 >> ${logfile} 2>&1
    print_zero_result $?
}

sh_neg_test(){
    $1 >> ${logfile} 2>&1
    print_nonzero_result $?
}

sh_exit()
{
    exit $1
}

print_error_step()
{
    log_n "--${testname}: "
    log2 "Step error"
    log "$2"
    log "Step exit code: $1"
}

sh_step()
{
    $1 >> ${logfile} 2>&1
    sh_res=$?
    if [[ "X"${sh_res} != "X0" ]]; then
        print_error_step ${sh_res} "$1"
    fi
    return ${sh_res}
}
