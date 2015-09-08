CREATE OR REPLACE PACKAGE BODY testschema.my_package
IS

  FUNCTION do_something (
    p_param_one VARCHAR2
  , p_param_too NUMBER
  )
  IS
    l_some_var VARCHAR2(10);
  BEGIN

    SELECT dummy
    INTO l_some_var
    FROM dual;

    dbms_output.put_line('Hello, World!');

    INSERT INTO testschema.some_table (
      id
    , date
    , comment
    , user_id
    ) VALUES (
      1
    , SYSDATE
    , l_some_var || p_param_one || p_param_too
    , 666
    );

    COMMIT;

  END do_something;

  PROCEDURE do_something_else (
    p_param_one VARCHAR2
  , p_param_too NUMBER
  )
  IS
    l_some_var VARCHAR2(10);
  BEGIN

    SELECT dummy || 'X'
    INTO l_some_var
    FROM dual;

    dbms_output.put_line('Hello, World!');

    INSERT INTO testschema.some_table (
      id
    , date
    , comment
    , user_id
    ) VALUES (
      1
    , SYSDATE
    , l_some_var || p_param_one || p_param_too
    , 666
    );

    COMMIT;

  END do_something_else;

END my_package;
/
