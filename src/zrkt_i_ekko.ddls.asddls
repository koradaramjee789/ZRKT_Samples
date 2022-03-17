@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Test proc doc'
define root view entity ZRKT_I_EKKO
  as select from zrkt_ekko as Ekko
{
  key zztemp_guid as TempGuid, 
  object_id as ObjectID,
  description as Description,
  buyer as Buyer,
  supplier as Supplier,
  sup_con_id as SupConID,
  send_via as SendVia,
  comp_code as CompCode,
  stat_code as StatCode,
  fiscl_year as FisclYear,
  valid_from as ValidFrom,
  valid_to as ValidTo,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locl_last_changed_at as LoclLastChangedAt
  
}
