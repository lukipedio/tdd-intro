library vunit_lib;
context vunit_lib.vunit_context;

use work.string_pkg.all;

entity tb_example is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_example is
begin

  main : process
    variable null_vector    : integer_vector(1 to 0);
    constant reverse_vector : integer_vector(1 downto 0) := (0, 100);
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test empty integer_vector") then
        check_equal(to_string(null_vector), "()");
      elsif run("Test vector with single element") then
        check_equal(to_string(integer_vector'(0 => 17)), "(17)");
      elsif run("Test vector with many elements") then
        check_equal(to_string(integer_vector'(0 => 17, 1 => - 21)), "(17, -21)");
      elsif run("Test vector with reverse range") then
        check_equal(to_string(reverse_vector), "(0, 100)");
      elsif run("Test vector with three elements") then
        check_equal(to_string(integer_vector'(0 => 17, 1 => - 21, 2 => 101)), "(17, -21, 101)");
      end if;
    end loop;

    test_runner_cleanup(runner);
  end process;
end architecture;