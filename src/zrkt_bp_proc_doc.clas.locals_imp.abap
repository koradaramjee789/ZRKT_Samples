CLASS lsc_zrkt_i_proc_doc DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save REDEFINITION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zrkt_i_proc_doc IMPLEMENTATION.

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
        REQUEST requested_authorizations FOR ProcDoc
        RESULT result,
      create FOR MODIFY
        IMPORTING entities FOR CREATE ProcDoc.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ProcDoc.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ProcDoc.

    METHODS read FOR READ
      IMPORTING keys FOR READ ProcDoc RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK ProcDoc.

*          METHODS set_pc_num FOR DETERMINE ON SAVE
*            IMPORTING keys FOR ProcDoc~set_pc_num.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD create.

    DATA ls_pur_con TYPE zrkt_proc_doc.

    READ TABLE entities ASSIGNING FIELD-SYMBOL(<fs_entity>) INDEX 1.
    IF sy-subrc EQ 0.

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
      ls_pur_con-zztemp_guid = <fs_entity>-TempGuid.
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

      INSERT zrkt_proc_doc FROM @ls_pur_con.

    ENDIF.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

*  METHOD set_pc_num.
*
*    TRY.
*        cl_numberrange_runtime=>number_get(
*          EXPORTING
**            ignore_buffer     =
*            nr_range_nr       = '01'
*            object            = 'ZRK_NR_PR'
*            quantity          = 1
**            subobject         =
**            toyear            =
*          IMPORTING
*                number            = DATA(number_range_key)
*                returncode        = DATA(number_range_return_code)
*                returned_quantity = DATA(number_range_returned_quantity)
*        ).
*      CATCH cx_number_ranges.
*        "handle exception
*    ENDTRY.
*    DATA(max_id) = number_range_key - number_range_returned_quantity.
*
*        READ ENTITIES OF ZRKT_I_PROC_DOC
*      IN LOCAL MODE
*      ENTITY ProcDoc
*      FIELDS ( ObjectId )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_con).
*
*    lt_con[ 1 ]-ObjectId = |PC{ max_id }|.
*
*    MODIFY ENTITIES OF ZRKT_I_PROC_DOC
*    IN LOCAL MODE
*    ENTITY ProcDoc
*    UPDATE FIELDS ( ObjectId Description ValidFrom ValidTo FisclYear Buyer CompCode )
*    WITH VALUE #( FOR <fs_con> IN lt_con ( %tky = <fs_con>-%tky
*                                             ObjectId = <fs_con>-ObjectId
*                                             Description = 'New PC'
*                                             ValidFrom = cl_abap_context_info=>get_system_date( )
*                                             ValidTo = cl_abap_context_info=>get_system_date(  ) + 364
*                                             Buyer = sy-uname
*                                             CompCode = 'CC28'
*                                             FisclYear = '2022'
*                                             CreatedBy = sy-uname ) ).
*  ENDMETHOD.

ENDCLASS.
