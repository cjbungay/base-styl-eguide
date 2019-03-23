*&---------------------------------------------------------------------*
*& Report ycss_no_redundant_code
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_no_redundant_code.
class snippet_super definition.
  public section.
    methods some_method.
endclass.

class snippet_super implementation.
  method some_method.

  endmethod.
endclass.

class snippet definition inheriting from snippet_super.
  public section.
    methods some_method redefinition.
    methods do_something returning value(x) type i.
    methods example.

  private section.
    data x type i.
endclass.

class snippet implementation.
  method some_method.
    super->some_method( ).
  endmethod.

  method do_something.
    x = 1.
  endmethod.

  method example.
    "
    x = me->do_something( )."me-> is unnecessary
    "can be written like
    x = do_something( ).

  endmethod.
endclass.

start-of-selection.
  new snippet( )->do_something( ).

  message 'end of program' type 'S'.
