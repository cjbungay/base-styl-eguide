*&---------------------------------------------------------------------*
*& Report ycss_refactor_loop_body
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycss_refactor_loop_body.
type-pools:
  abap.

class file definition.
  public section.
    methods constructor importing file_in type string.
    methods can_write returning value(can) type  boolean.
    methods can_read returning value(can) type boolean.

  private section.
    data:
          file type string.
endclass.

class file implementation.
  method constructor.
    file = file_in.
  endmethod.

  method can_read.
    can = abap_true.
  endmethod.

  method can_write.
    can = abap_true.
  endmethod.
endclass.

class refactor_loop_body1 definition.
  public section.
    class-methods main.

    methods process_list.

  private section.
    data:
          list type ref to cl_object_collection.

    methods run.
endclass.

class refactor_loop_body1 implementation.
  method main.
    new refactor_loop_body1( )->run( ).
  endmethod.

  method process_list.
    data(iterator) = new cl_object_collection_iterator( collection = list ).

    while iterator->has_next( ).
      data(file) = cast file( iterator->get_next( ) ).
      data(read) = file->can_read( ).
      data(write) = file->can_write( ).
      " and more processing
    endwhile.
  endmethod.

  method run.
    data(f) = new file( file_in = 'C:\test\yada.txt' ).

    list = new cl_object_collection( ).
    list->add( f ).
    list->add( f ).
    list->add( f ).
    process_list( ).
  endmethod.
endclass.

class refactor_loop_body2 definition.
  public section.
    class-methods main.

    methods process_list.

  private section.
    data:
          list type ref to cl_object_collection.

    methods run.
    methods process_file importing file_in type ref to file.
endclass.

class refactor_loop_body2 implementation.
  method main.
    new refactor_loop_body2( )->run( ).
  endmethod.

  method process_list.
    data(iterator) = new cl_object_collection_iterator( collection = list ).

    while iterator->has_next( ).
      data(file) = cast file( iterator->get_next( ) ).
      process_file( file ). " functionality extracted into it's own private method
    endwhile.
  endmethod.

  method run.

    data(f) = new file( file_in = 'C:\test\yada.txt' ).

    process_file( f ).

    list = new cl_object_collection( ).
    list->add( f ).
    list->add( f ).
    list->add( f ).
    process_list( ).
  endmethod.

  method process_file.
    data(read) = file_in->can_read( ).
    data(write) = file_in->can_write( ).
    " and more processing
  endmethod.
endclass.

start-of-selection.

  refactor_loop_body1=>main( ).
  refactor_loop_body1=>main( ).

  message 'end of program' type 'S'.
