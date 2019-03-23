*&---------------------------------------------------------------------*
*& Report ycss_avoid_superfluous_else
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_avoid_superfluous_else.
type-pools:
  abap.

class snippet definition.
  public section.
    methods has_serverside_validate_errors returning value(errors) type boolean.

  private section.
    methods is_custcenter_offered_selected returning value(selected) type boolean.
    methods is_insurance_type_selected returning value(selected) type boolean.
    methods is_insurance_product_selected returning value(selected) type boolean.
endclass.

class snippet implementation.
  method has_serverside_validate_errors.
    if is_custcenter_offered_selected( ).
      errors = is_custcenter_offered_selected( ).
    elseif is_insurance_type_selected( ).
      errors = is_insurance_type_selected( ).
    elseif is_insurance_product_selected( ).
      errors = is_insurance_product_selected( ).
    else.
      errors = abap_true.
    endif.
  endmethod.

  method is_custcenter_offered_selected.
    selected = abap_false.
  endmethod.

  method is_insurance_type_selected.
    selected = abap_true.
  endmethod.

  method is_insurance_product_selected.
    selected = abap_true.
  endmethod.
endclass.

start-of-selection.
  data(has_errors) = new snippet( )->has_serverside_validate_errors( ).

  message 'end of program' type 'S'.
