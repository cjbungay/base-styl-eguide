*&---------------------------------------------------------------------*
*& Report YCSS_AVOID_COMPOUND_OR_AND_IF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YCSS_AVOID_COMPOUND_OR_AND_IF.
type-pools:
  abap.

class insurance_status definition.
  public section.
    class-data:
      cancelled   type i value 1 read-only,
      declined    type i value 2 read-only,
      file_closed type i value 3 read-only.

    methods constructor importing status_in type i.
    methods compare_to
      importing status_in type i
      returning value(compared) type i.
    methods get_status returning value(status_out) type i.
    methods is_active returning value(active) type boolean.

  private section.
    data:
          status type i.

endclass.

class insurance_status implementation.
  method constructor.
    status = status_in.
  endmethod.

  method compare_to.
    if status_in ne status.
      compared = 1.
    endif.
  endmethod.

  method is_active.

  endmethod.

  method get_status.
    status_out = status.
  endmethod.
endclass.

class insurance definition.
  public section.
    methods constructor.
    methods get_insurance_status returning value(status_out) type ref to insurance_status.
    methods is_active returning value(active) type boolean.

  private section.
    data:
          status type ref to insurance_status.
endclass.

class insurance implementation.
  method constructor.
    create object status exporting status_in = 1.
  endmethod.

  method get_insurance_status.
    status_out = status.
  endmethod.

  method is_active.
    active = abap_true.
  endmethod.
endclass.

class main definition.
  public section.
    methods run.

  private section.
    methods is_valid_open_status
      importing an_insurance_status type i
      returning value(valid) type boolean.

endclass.

class main implementation.
  method run.
    data(insurance) = new insurance( ).

    if insurance->get_insurance_status( )->compare_to( insurance_status=>cancelled ) = 0 or
       insurance->get_insurance_status( )->compare_to( insurance_status=>declined ) = 0 or
       insurance->get_insurance_status( )->compare_to( insurance_status=>file_closed ) = 0 .
      "Do something ...

    endif.

    if is_valid_open_status( insurance->get_insurance_status( )->get_status( ) ).
      "Do something ...
    endif.

     if insurance->get_insurance_status( )->is_active( ).
       "Do something ...
     endif.
  endmethod.

  method is_valid_open_status.
    if an_insurance_status = insurance_status=>cancelled.
      valid = abap_true.
      return.
    endif.

    if an_insurance_status = insurance_status=>declined.
      valid = abap_true.
      return.
    endif.

    if an_insurance_status = insurance_status=>file_closed.
      valid = abap_true.
      return.
    endif.
  endmethod.
endclass.

start-of-selection.

  new main( )->run( ).

  message 'end of program' type 'S'.
