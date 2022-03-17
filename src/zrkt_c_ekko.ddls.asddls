@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRKT_I_EKKO'
define root view entity ZRKT_C_EKKO
  as projection on ZRKT_I_EKKO
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
