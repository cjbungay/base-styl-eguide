*&---------------------------------------------------------------------*
*& Report ycss_special_semantics_on_null
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_special_semantics_on_null.
type-pools:
  abap.

class query definition.
  public section.
    methods get_result_set returning value(result) type ref to cl_object_collection.
endclass.

class query implementation.
  method get_result_set.
    create object result.
  endmethod.
endclass.

class customer definition.
  public section.

endclass.

class customer implementation.

endclass.

class snippet definition.
  public section.
    methods constructor.

    methods get_total_worth
      importing accounts type ref to cl_object_collection
      returning value(total) type i.

    methods get_customer
      importing customer_id type n
      returning value(customer) type ref to customer.

  private section.
    data:
          query type ref to query.
endclass.

class snippet implementation.
  method constructor.
    create object query.
  endmethod.

  method get_total_worth.
    data:
          sum type i.

    if accounts is not bound.
      total = 0. " this should throw an exception.
      return.
    endif.

    "Rest of code here summing up some total
    total = sum.
  endmethod.

  method get_customer.

    "code here to find customer
    if query->get_result_set( )->is_empty( ).
      return. "This represents CustomerNotFound - should throw an exception or return an Optional
    endif.

    customer ?= query->get_result_set( )->get( 1 ).
  endmethod.
endclass.

start-of-selection.

  new snippet( )->get_total_worth( new cl_object_collection( ) ).

  message 'end of program' type 'S'.
