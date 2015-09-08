CREATE OR REPLACE PACKAGE testschema.my_package
IS

  FUNCTION do_something (
    p_param_one VARCHAR2
  , p_param_too NUMBER
  );

  PROCEDURE do_something_else (
    p_param_one VARCHAR2
  , p_param_too NUMBER
  );

END my_package;
/
