*&---------------------------------------------------------------------*
*& Report ycss_unnecessary_parameters
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_unnecessary_parameters.
type-pools:
  abap.

class sap_component definition deferred.
class insurance_status_value_combox definition deferred.

class insurance_ui definition.
  public section.
    class-data:
                select_status type i value 1 read-only.

    methods constructor.
    methods set_insurance_status_vals importing component type ref to sap_component.
    methods get_resource importing status type i returning value(resource) type i.

  private section.
    data:
          is_insurance_status_selected type boolean,
          combox type ref to insurance_status_value_combox.
endclass.

class sap_component definition.

endclass.

class insurance_status_value_combox definition.
  public section.
    methods get_selected_index returning value(index) type i.
    methods set_error_state_on_val_field
      importing insurance type ref to insurance_ui
                resource  type i
      returning value(status) type boolean.

endclass.

class insurance_ui implementation.
  method constructor.
    create object combox.
  endmethod.

  method set_insurance_status_vals.

    if combox->get_selected_index( ) = 0.
      is_insurance_status_selected = combox->set_error_state_on_val_field( insurance = me resource = get_resource( select_status ) ).
    endif.
  endmethod.

  method get_resource.

  endmethod.
endclass.

class sap_component implementation.

endclass.

class insurance_status_value_combox implementation.
  method get_selected_index.
    index = 1.
  endmethod.

  method set_error_state_on_val_field.
    status = abap_true.
  endmethod.
endclass.

start-of-selection.

  new insurance_ui( )->set_insurance_status_vals( new sap_component( ) ).

  message 'end of program' type 'S'.
