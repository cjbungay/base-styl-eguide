*&---------------------------------------------------------------------*
*& Report ycss_internal_documentation
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_internal_documentation.
class snippet definition.
  public section.
    methods do_something.

  private section.
    data:
          a   type f value '2.0',
          b   type f value '3.0'.
endclass.

class snippet implementation.
  method do_something.
    " These next 4 lines calculate the hypotenuse of a triangle()

    data(aa) = a * b.
    data(bb) = b * b.
    data(h) = sqrt( aa + bb ).
    " ...
  endmethod.
endclass.

class snippet_refactor definition.
  public section.
    methods do_something.

  private section.
    data:
          a   type f value '2.0',
          b   type f value '3.0'.

    methods get_hypotenuse returning value(hypotenuse) type f.
endclass.

class snippet_refactor implementation.
  method do_something.
    data hypotenuse type f.

    hypotenuse = get_hypotenuse( ).
    " ...
  endmethod.

  method get_hypotenuse.
    data(square_a) = a * b.
    data(square_b) = b * b.
    hypotenuse = sqrt( square_a + square_b ).
    " ...
  endmethod.
endclass.

start-of-selection.
  new snippet( )->do_something( ).
  new snippet_refactor( )->do_something( ).

  message 'end of program' type 'S'.
