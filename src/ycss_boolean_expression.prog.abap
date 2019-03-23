*&---------------------------------------------------------------------*
*& Report ycss_boolean_expression
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_boolean_expression.
type-pools:
  abap.

class snippet definition.
  public section.
    methods constructor.
    methods is_empty returning value(empty) type boolean.

  private section.
    data:
          list type standard table of line.
endclass.

class snippet implementation.
  method constructor.

  endmethod.

  method is_empty.
    if lines( list ) = 0.
      empty = abap_true.
    else.
      empty = abap_false.
    endif.
  endmethod.

endclass.

class snippet_refactor definition.
  public section.
    methods constructor.
    methods is_empty returning value(empty) type boolean.

  private section.
    data:
          list type standard table of line.
endclass.

class snippet_refactor implementation.
  method constructor.

  endmethod.

  method is_empty.
    empty = boolc( lines( list ) = 0 ).
  endmethod.

endclass.

start-of-selection.
  data(boolean) = new snippet( )->is_empty( ).
  boolean = new snippet_refactor( )->is_empty( ).

  message 'end of program' type 'S'.
