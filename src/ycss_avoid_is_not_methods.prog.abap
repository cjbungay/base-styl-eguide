*&---------------------------------------------------------------------*
*& Report YCSS_AVOID_IS_NOT_METHODS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YCSS_AVOID_IS_NOT_METHODS.
type-pools:
  abap.

class snippet definition.
  public section.
    methods is_not_valid returning value(not_valid) type  boolean.
    methods is_valid returning value(valid) type  boolean.

  private section.
    data:
          code type string.
endclass.

class snippet implementation.
  method is_not_valid.
    if code eq 'Good'.
      not_valid = abap_false.
      return.
    endif.

    not_valid = abap_true.
  endmethod.

  method is_valid.
    if code eq 'Good'.
      valid = abap_true.
      return.
    endif.

    valid = abap_false.
  endmethod.
endclass.

class snippet_refactor definition.
  public section.
    methods is_valid returning value(valid) type  boolean.

  private section.
    data:
          code type string.
endclass.

class snippet_refactor implementation.
  method is_valid.
    valid = boolc( code eq 'Good' ).
  endmethod.
endclass.

start-of-selection.

  data(boolean) = new snippet( )->is_not_valid( ).
  boolean = new snippet( )->is_valid( ).
  boolean = new snippet_refactor( )->is_valid( ).

  message 'end of program' type 'S'.
