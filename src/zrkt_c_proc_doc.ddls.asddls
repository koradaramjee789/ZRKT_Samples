@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRKT_I_PROC_DOC'
define root view entity ZRKT_C_PROC_DOC
  as projection on ZRKT_I_PROC_DOC
{
  key TempGuid,
  objectid,
  description,
  buyer,
  supplier,
  supconid,
  sendvia,
  compcode,
  statcode,
  fisclyear,
  validfrom,
  validto,
  locllastchangedat
  
}
