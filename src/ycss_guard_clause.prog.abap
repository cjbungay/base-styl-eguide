*&---------------------------------------------------------------------*
*& Report ycss_guard_clause
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_guard_clause.
type-pools:
  abap.

class snippet definition.
  public section.
    methods draw.

  private section.
    methods is_visible returning value(visible) type boolean.
endclass.

class snippet implementation.
  method draw.
    if is_visible( ).
      "10 lines (the rest) of the draw code comes here.
    endif.
  endmethod.

  method is_visible.
    visible = abap_true.
  endmethod.
endclass.

class snippet_refactor definition.
  public section.
    methods draw.

  private section.
    methods is_visible returning value(visible) type boolean.
endclass.

class snippet_refactor implementation.
  method draw.
    if not is_visible( ).
      return.
    endif.

    "10 lines (the rest) of the draw code comes here.
  endmethod.

  method is_visible.
    visible = abap_true.
  endmethod.
endclass.

start-of-selection.
  new snippet( )->draw( ).
  new snippet_refactor( )->draw( ).

  message 'end of program' type 'S'.
