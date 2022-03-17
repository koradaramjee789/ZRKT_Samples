CLASS lsc_zrkt_i_ekko DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

    METHODS save REDEFINITION.

ENDCLASS.

CLASS lsc_zrkt_i_ekko IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

  METHOD save.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Ekko
        RESULT result,
      create FOR MODIFY
        IMPORTING entities FOR CREATE Ekko.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Ekko.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Ekko.

    METHODS read FOR READ
      IMPORTING keys FOR READ Ekko RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Ekko.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD create.

          DATA ls_pur_con TYPE zrkt_proc_doc.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

        TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*            ignore_buffer     =
            nr_range_nr       = '01'
            object            = 'ZRK_NR_PR'
            quantity          = 1
*            subobject         =
*            toyear            =
          IMPORTING
                number            = DATA(number_range_key)
                returncode        = DATA(number_range_return_code)
                returned_quantity = DATA(number_range_returned_quantity)
        ).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.
    DATA(max_id) = number_range_key - number_range_returned_quantity.

      ls_pur_con-client = sy-mandt.
      ls_pur_con-object_id = |PC{ max_id }| .
      ls_pur_con-description = <fs_entity>-Description .
      ls_pur_con-buyer = <fs_entity>-Buyer .
      ls_pur_con-supplier = <fs_entity>-Supplier .
      ls_pur_con-sup_con_id = <fs_entity>-SupConId .
      ls_pur_con-comp_code = <fs_entity>-CompCode .
      ls_pur_con-stat_code = <fs_entity>-StatCode .
      ls_pur_con-valid_from = <fs_entity>-Validfrom .
      ls_pur_con-valid_to = <fs_entity>-ValidTo .
      ls_pur_con-fiscl_year = <fs_entity>-FisclYear .
      ls_pur_con-created_at = <fs_entity>-CreatedAt .
      ls_pur_con-created_by = <fs_entity>-CreatedBy .

      INSERT zrkt_ekko from @ls_pur_con.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.
