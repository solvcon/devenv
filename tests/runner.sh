source ../scripts/init

final_ret=0

./test_init_var.sh ; if [ $? != 0 ] ; then final_ret=1 ; fi
./test_bash_utils.sh ; if [ $? != 0 ] ; then final_ret=1 ; fi
./test_devenv_impl.sh ; if [ $? != 0 ] ; then final_ret=1 ; fi
./test_init.sh ; if [ $? != 0 ] ; then final_ret=1 ; fi

exit $final_ret
