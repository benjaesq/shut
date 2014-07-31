# benjaesq@me.com

# positive test
test_first_001()
{
    inittest
    sh_test "test 1"
}

# negative test
test_first_002()
{
    inittest
    sh_neg_test "test"
}

# failing test
test_first_003()
{
    inittest
    sh_test "test"
}

# positive test with step
test_first_004()
{
    inittest
    sh_step "echo first step"
    sh_test "test 1"
}

# test with failing step
test_first_005()
{
    inittest
    sh_step "echo first step" || return
    sh_step "test" || return
    sh_test "test 1" #unreachable step
}

#TODO: replace functions and inittest calls for a simpler call at shest
#TODO: simplify the || return at shest
#TODO: set the test root dir in a variable
#TODO: create logic to identify test cases
#TODO: list test cases
#TODO: show summary at the end of the testing
