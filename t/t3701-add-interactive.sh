. "$TEST_DIRECTORY"/lib-terminal.sh
	printf "%s\n" s e     q n q q |
test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
	cat >test <<-\EOF &&
	5
	10
	20
	21
	30
	31
	40
	50
	60
	EOF
	git reset &&
	# test sequence is s(plit), n(o), y(es), e(dit)
	# q n q q is there to make sure we exit at the end.
	printf "%s\n" s n y e   q n q q |
	EDITOR=: git add -p 2>error &&
	test_must_be_empty error &&
	git diff >actual &&
	! grep "^+31" actual
'
