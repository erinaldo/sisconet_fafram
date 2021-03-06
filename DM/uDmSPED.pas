unit uDmSPED;

interface

uses
  SysUtils, Classes, IniFiles, Windows, DB, SqlExpr,
  Messages, Variants, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask,
  DBCtrls, ExtCtrls, ComCtrls, FMTBcd, DBClient, Provider, uRotinas_EFD,
  uRotinas_PisCofins, ACBrValidador;


type
  TDmSPED = class(TDataModule)
    QryEmpresa: TSQLQuery;
    DspEmpresa: TDataSetProvider;
    CdsEmpresa: TClientDataSet;
    QryContador: TSQLQuery;
    DspContador: TDataSetProvider;
    CdsContabil: TClientDataSet;
    QryClientes: TSQLQuery;
    DspClientes: TDataSetProvider;
    CdsClientes: TClientDataSet;
    QryFornecedor: TSQLQuery;
    DspFornecedor: TDataSetProvider;
    CdsFornecedor: TClientDataSet;
    QryClientesID: TIntegerField;
    QryClientesNOME: TStringField;
    QryClientesCNPJ_CPF: TStringField;
    QryClientesINSC_RG: TStringField;
    QryClientesCODCIDADE: TStringField;
    QryClientesENDERECO: TStringField;
    QryClientesNUM_END: TStringField;
    QryClientesBAIRRO_END: TStringField;
    QryClientesUF_END: TStringField;
    QryClientesSTATUS_NFE: TStringField;
    CdsClientesID: TIntegerField;
    CdsClientesNOME: TStringField;
    CdsClientesCNPJ_CPF: TStringField;
    CdsClientesINSC_RG: TStringField;
    CdsClientesCODCIDADE: TStringField;
    CdsClientesENDERECO: TStringField;
    CdsClientesNUM_END: TStringField;
    CdsClientesBAIRRO_END: TStringField;
    CdsClientesUF_END: TStringField;
    CdsClientesSTATUS_NFE: TStringField;
    QryFornecedorID: TIntegerField;
    QryFornecedorNOME: TStringField;
    QryFornecedorCNPJ_CPF: TStringField;
    QryFornecedorINSC_RG: TStringField;
    QryFornecedorCODCIDADE: TStringField;
    QryFornecedorENDERECO: TStringField;
    QryFornecedorNUM_END: TStringField;
    QryFornecedorBAIRRO_END: TStringField;
    QryFornecedorUF_END: TStringField;
    QryFornecedorSTATUS_NFE: TStringField;
    CdsFornecedorID: TIntegerField;
    CdsFornecedorNOME: TStringField;
    CdsFornecedorCNPJ_CPF: TStringField;
    CdsFornecedorINSC_RG: TStringField;
    CdsFornecedorCODCIDADE: TStringField;
    CdsFornecedorENDERECO: TStringField;
    CdsFornecedorNUM_END: TStringField;
    CdsFornecedorBAIRRO_END: TStringField;
    CdsFornecedorUF_END: TStringField;
    CdsFornecedorSTATUS_NFE: TStringField;
    QryContadorID: TIntegerField;
    QryContadorCONTABILIDADE: TStringField;
    QryContadorENDERECO: TStringField;
    QryContadorEND_NUM: TStringField;
    QryContadorEND_COMPL: TStringField;
    QryContadorBAIRRO: TStringField;
    QryContadorCIDADE: TStringField;
    QryContadorUF: TStringField;
    QryContadorCEP: TStringField;
    QryContadorCOD_MUNICIPIO: TStringField;
    QryContadorCNPJ: TStringField;
    QryContadorREGISTRO: TStringField;
    QryContadorCONTADOR: TStringField;
    QryContadorFONE: TStringField;
    QryContadorFAX: TStringField;
    QryContadorCPF_CONTADOR: TStringField;
    QryContadorCRC_CONTADOR: TStringField;
    QryContadorEMAIL: TStringField;
    QryContadorSITE: TStringField;
    CdsContabilID: TIntegerField;
    CdsContabilCONTABILIDADE: TStringField;
    CdsContabilENDERECO: TStringField;
    CdsContabilEND_NUM: TStringField;
    CdsContabilEND_COMPL: TStringField;
    CdsContabilBAIRRO: TStringField;
    CdsContabilCIDADE: TStringField;
    CdsContabilUF: TStringField;
    CdsContabilCEP: TStringField;
    CdsContabilCOD_MUNICIPIO: TStringField;
    CdsContabilCNPJ: TStringField;
    CdsContabilREGISTRO: TStringField;
    CdsContabilCONTADOR: TStringField;
    CdsContabilFONE: TStringField;
    CdsContabilFAX: TStringField;
    CdsContabilCPF_CONTADOR: TStringField;
    CdsContabilCRC_CONTADOR: TStringField;
    CdsContabilEMAIL: TStringField;
    CdsContabilSITE: TStringField;
    QryEmpresaID: TIntegerField;
    QryEmpresaRAZAO_SOCIAL: TStringField;
    QryEmpresaENDERECO: TStringField;
    QryEmpresaNUMERO: TStringField;
    QryEmpresaCOMPLEMENTO: TStringField;
    QryEmpresaBAIRRO: TStringField;
    QryEmpresaCIDADE: TStringField;
    QryEmpresaUF: TStringField;
    QryEmpresaCEP: TStringField;
    QryEmpresaCNPJ_CPF: TStringField;
    QryEmpresaINSCRICAO_RG: TStringField;
    QryEmpresaTELEFONE: TStringField;
    QryEmpresaTELEFAX: TStringField;
    QryEmpresaCONTATO: TStringField;
    QryEmpresaEMAIL: TStringField;
    QryEmpresaSITE: TStringField;
    QryEmpresaINSC_MUNIC: TStringField;
    QryEmpresaFANTASIA: TStringField;
    QryEmpresaCOD_MUNICIPIO: TStringField;
    QryEmpresaIDCONTADOR: TIntegerField;
    QryEmpresaCRT: TIntegerField;
    QryEmpresaCOD_SUFRAMA: TStringField;
    QryEmpresaID_EMPRESA: TIntegerField;
    QryEmpresaTIPO_EMPRESA: TIntegerField;
    QryEmpresaTIPO_BUSCA_CLIENTE: TIntegerField;
    QryEmpresaCONF_LANC_CAIXA: TStringField;
    QryEmpresaTIPODOC_PADRAO: TIntegerField;
    QryEmpresaEXIBIR: TIntegerField;
    QryEmpresaCADASTRAR_CHEQUES: TStringField;
    QryEmpresaPATHLOGOMARCA: TStringField;
    QryEmpresaTELAVENDAPADRAO: TIntegerField;
    QryEmpresaCLIENTE_PADRAO: TIntegerField;
    QryEmpresaVENDEDOR_PADRAO: TIntegerField;
    QryEmpresaCLASSIFICA_PADRAO: TIntegerField;
    QryEmpresaFORMAPAG_PADRAO: TIntegerField;
    QryEmpresaINDICE_TIJOLO: TFloatField;
    QryEmpresaINDICE_ISOPOR: TFloatField;
    QryEmpresaGRUPO_PADRAO: TIntegerField;
    QryEmpresaTIPO_COMISSAO: TIntegerField;
    QryEmpresaINDICE_OUTROS: TFloatField;
    QryEmpresaMARGEM_LUCRO: TFloatField;
    QryEmpresaTIPO_CALC_PERC: TIntegerField;
    QryEmpresaESTOQUE_NEGATICO: TStringField;
    QryEmpresaPERMITIRVALORNEGATIVO: TStringField;
    QryEmpresaNUMPED_SEQ: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_SEG: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_TER: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_QUA: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_QUI: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_SEX: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_SAB: TStringField;
    QryEmpresaCOMISSAO_INTEGRAL_DOM: TStringField;
    QryEmpresaATUALIZAR_PRECO: TStringField;
    QryEmpresaCONTROLAR_ESTCOMP: TStringField;
    QryEmpresaVERSAO_LAYOUT: TStringField;
    QryEmpresaPERFIL_APRESENTA: TStringField;
    QryEmpresaINDICADOR_ATV: TIntegerField;
    QryEmpresaCOD_PAIS: TStringField;
    QryEmpresaDIAS_AGENDA: TIntegerField;
    QryEmpresaMODELO_PEDIDO: TIntegerField;
    QryEmpresaPED_EDITAR_CLI: TStringField;
    QryEmpresaEXIBE_IMPOSTO: TStringField;
    QryEmpresaIMPOSTO_MENSAGEM: TStringField;
    QryEmpresaCOD_RECEITA: TStringField;
    CdsEmpresaID: TIntegerField;
    CdsEmpresaRAZAO_SOCIAL: TStringField;
    CdsEmpresaENDERECO: TStringField;
    CdsEmpresaNUMERO: TStringField;
    CdsEmpresaCOMPLEMENTO: TStringField;
    CdsEmpresaBAIRRO: TStringField;
    CdsEmpresaCIDADE: TStringField;
    CdsEmpresaUF: TStringField;
    CdsEmpresaCEP: TStringField;
    CdsEmpresaCNPJ_CPF: TStringField;
    CdsEmpresaINSCRICAO_RG: TStringField;
    CdsEmpresaTELEFONE: TStringField;
    CdsEmpresaTELEFAX: TStringField;
    CdsEmpresaCONTATO: TStringField;
    CdsEmpresaEMAIL: TStringField;
    CdsEmpresaSITE: TStringField;
    CdsEmpresaINSC_MUNIC: TStringField;
    CdsEmpresaFANTASIA: TStringField;
    CdsEmpresaCOD_MUNICIPIO: TStringField;
    CdsEmpresaIDCONTADOR: TIntegerField;
    CdsEmpresaCRT: TIntegerField;
    CdsEmpresaCOD_SUFRAMA: TStringField;
    CdsEmpresaID_EMPRESA: TIntegerField;
    CdsEmpresaTIPO_EMPRESA: TIntegerField;
    CdsEmpresaTIPO_BUSCA_CLIENTE: TIntegerField;
    CdsEmpresaCONF_LANC_CAIXA: TStringField;
    CdsEmpresaTIPODOC_PADRAO: TIntegerField;
    CdsEmpresaEXIBIR: TIntegerField;
    CdsEmpresaCADASTRAR_CHEQUES: TStringField;
    CdsEmpresaPATHLOGOMARCA: TStringField;
    CdsEmpresaTELAVENDAPADRAO: TIntegerField;
    CdsEmpresaCLIENTE_PADRAO: TIntegerField;
    CdsEmpresaVENDEDOR_PADRAO: TIntegerField;
    CdsEmpresaCLASSIFICA_PADRAO: TIntegerField;
    CdsEmpresaFORMAPAG_PADRAO: TIntegerField;
    CdsEmpresaINDICE_TIJOLO: TFloatField;
    CdsEmpresaINDICE_ISOPOR: TFloatField;
    CdsEmpresaGRUPO_PADRAO: TIntegerField;
    CdsEmpresaTIPO_COMISSAO: TIntegerField;
    CdsEmpresaINDICE_OUTROS: TFloatField;
    CdsEmpresaMARGEM_LUCRO: TFloatField;
    CdsEmpresaTIPO_CALC_PERC: TIntegerField;
    CdsEmpresaESTOQUE_NEGATICO: TStringField;
    CdsEmpresaPERMITIRVALORNEGATIVO: TStringField;
    CdsEmpresaNUMPED_SEQ: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_SEG: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_TER: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_QUA: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_QUI: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_SEX: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_SAB: TStringField;
    CdsEmpresaCOMISSAO_INTEGRAL_DOM: TStringField;
    CdsEmpresaATUALIZAR_PRECO: TStringField;
    CdsEmpresaCONTROLAR_ESTCOMP: TStringField;
    CdsEmpresaVERSAO_LAYOUT: TStringField;
    CdsEmpresaPERFIL_APRESENTA: TStringField;
    CdsEmpresaINDICADOR_ATV: TIntegerField;
    CdsEmpresaCOD_PAIS: TStringField;
    CdsEmpresaDIAS_AGENDA: TIntegerField;
    CdsEmpresaMODELO_PEDIDO: TIntegerField;
    CdsEmpresaPED_EDITAR_CLI: TStringField;
    CdsEmpresaEXIBE_IMPOSTO: TStringField;
    CdsEmpresaIMPOSTO_MENSAGEM: TStringField;
    CdsEmpresaCOD_RECEITA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    ArqIni : TIniFile;
  public
    { Public declarations }
    oSpedEFD : TSPED_EFD;
    oSpedPC  : TSPED_PC;
    sBUF_LINHA, sBUF_NOTA,sNOTA, sPATH, sCodRec : String;
    sCOD_VER,sCOD_VERPC, sCOD_FIN , sPERFIL, sINDICADOR : Integer;
    sSitEspecial, sIndicadorPC, sTpEscrituracao, sEscrituracao : Integer;
    sNatureza,sIncidencia,sAproCred,sContrApur,sEscrApur : Integer;
    sExibeEFD, sExibeCont : Boolean;
    sSenhaAcesso : String;
    sTruncado : Boolean;
    procedure GravaIni;
    procedure LeIni;
    function Dados_Empresa(pCodEmpresa:Integer):Boolean;
    function Dados_Contador(pCodigo:Integer):Boolean;
    function Dados_Clientes(pDatai,pDataf:TDateTime;pEmpresa:Integer):Boolean;
    function Dados_Fornecedores(pDatai,pDataf:TDateTime;pEmpresa:Integer):Boolean;
    function Inscricao(Inscricao,UF:String): Boolean;

  end;

var
  DmSPED: TDmSPED;

implementation

uses uDmConexao, uLibrary, uDmAcBr;

{$R *.dfm}

function TDmSPED.Dados_Empresa(pCodEmpresa: Integer): Boolean;
begin
  CdsEmpresa.Close;
  CdsEmpresa.Params.ParamByName('pCdEmp').AsInteger := pCodEmpresa;
  CdsEmpresa.Open;
  // resultado
  Result := false;
  if CdsEmpresa.RecordCount > 0 then
     Result := true;
     
end;

function TDmSPED.Dados_Contador(pCodigo: Integer): Boolean;
begin
  CdsContabil.Close;
  CdsContabil.Params.ParamByName('pCodigo').AsInteger := pCodigo;
  CdsContabil.Open;
  // resultado
  Result := false;
  if CdsContabil.RecordCount > 0 then
     Result := true;
     
end;

function TDmSPED.Dados_Clientes(pDatai, pDataf: TDateTime;pEmpresa:Integer): Boolean;
begin
  CdsClientes.Close;
  CdsClientes.Params.ParamByName('pDatai').AsDateTime  := pDatai;
  CdsClientes.Params.ParamByName('pDataf').AsDateTime  := pDataf;
  CdsClientes.Params.ParamByName('pEmpresa').AsInteger := pEmpresa;
  CdsClientes.Open;
  // resultado
  Result := false;
  if CdsClientes.RecordCount > 0 then
     Result := true;

end;

function TDmSPED.Dados_Fornecedores(pDatai, pDataf: TDateTime;pEmpresa:Integer): Boolean;
begin
  CdsFornecedor.Close;
  CdsFornecedor.Params.ParamByName('pDatai').AsDateTime  := pDatai;
  CdsFornecedor.Params.ParamByName('pDataf').AsDateTime  := pDataf;
  CdsFornecedor.Params.ParamByName('pEmpresa').AsInteger := pEmpresa;
  CdsFornecedor.Open;
  // resultado
  Result := false;
  if CdsFornecedor.RecordCount > 0 then
     Result := true;

end;

function TDmSPED.Inscricao(Inscricao,UF:String) : Boolean;
var Aux : String;
Begin
  try
    with DmAcBr.ACBrValidador1 do
    begin
      TipoDocto := docInscEst;
      Documento := Inscricao;
      Complemento := UF;
      // formata o campo
      Aux := Formatar;
      Documento := Aux;
      IgnorarChar := './-';
      Result := Validar;
    end;
  except
    Result := False;
  end;
end;

procedure TDmSPED.GravaIni;
begin
  if sSenhaAcesso = '' then
     sSenhaAcesso := Criptografa('123',10);
  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  ArqINI.WriteInteger('SPED','COD_VER',sCOD_VER);
  ArqINI.WriteInteger('SPED','COD_FIN',sCOD_FIN);
  ArqINI.WriteInteger('SPED','PERFIL',sPERFIL);
  ArqINI.WriteInteger('SPED','INDICADOR',sINDICADOR);
  ArqINI.WriteString('SPED','BUF_LINHA',sBUF_LINHA);
  ArqINI.WriteString('SPED','BUF_NOTA',sBUF_NOTA);
  ArqINI.WriteString('SPED','NOTA',sNOTA);
  ArqINI.WriteString('SPED','PATH',sPATH);
  ArqINI.WriteString('SPED','CODREC',sCodRec);
  ArqINI.WriteBool('SPED','EXIBE_EFD',sExibeEFD);
  ArqINI.WriteBool('SPED','EXIBE_CONT',sExibeCont);
  ArqINI.WriteBool('SPED','TRUNCADO',sTruncado);
  ArqINI.WriteString('SENHA','PASSWORD',sSenhaAcesso);
  ArqINI.WriteInteger('SPEDPC','COD_VERPC',sCOD_VERPC);
  ArqINI.WriteInteger('SPEDPC','SITESPECIAL',sSitEspecial);
  ArqINI.WriteInteger('SPEDPC','INDICADORPC',sIndicadorPC);
  ArqINI.WriteInteger('SPEDPC','TPESCRITURACAO',sTpEscrituracao);
  ArqINI.WriteInteger('SPEDPC','ESCRITURACAO',sEscrituracao);
  ArqINI.WriteInteger('SPEDPC','NATUREZA',sNatureza);
    // Regime Apura��o
  ArqINI.WriteInteger('REGIME_APURACAO','INCIDENCIA',sIncidencia);
  ArqINI.WriteInteger('REGIME_APURACAO','APROPRIACRED',sAproCred);
  ArqINI.WriteInteger('REGIME_APURACAO','CONTROLEAPUR',sContrApur);
  ArqINI.WriteInteger('REGIME_APURACAO','ESCRITURAAPUR',sEscrApur);
  ArqIni.Free;
end;

procedure TDmSPED.LeIni;
begin
  ArqIni     := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  sCOD_VER   := ArqINI.ReadInteger('SPED','COD_VER',0);
  sCOD_FIN   := ArqINI.ReadInteger('SPED','COD_FIN',0);
  sPERFIL    := ArqINI.ReadInteger('SPED','PERFIL',0);
  sINDICADOR := ArqINI.ReadInteger('SPED','INDICADOR',0);
  sBUF_LINHA := ArqINI.ReadString('SPED','BUF_LINHA','1000');
  sBUF_NOTA  := ArqINI.ReadString('SPED','BUF_NOTA','1000');
  sNOTA      := ArqINI.ReadString('SPED','NOTA','10');
  sPATH      := ArqINI.ReadString('SPED','PATH','C:\');
  sCodRec    := ArqINI.ReadString('SPED','CODREC','');
  sTruncado  := ArqINI.ReadBool('SPED','TRUNCADO',FALSE);
  sExibeEFD  := ArqINI.ReadBool('SPED','EXIBE_EFD',TRUE);
  sExibeCont := ArqINI.ReadBool('SPED','EXIBE_CONT',TRUE);
  sSenhaAcesso    := ArqINI.ReadString('SENHA','PASSWORD','');
  sCOD_VERPC      := ArqINI.ReadInteger('SPEDPC','COD_VERPC',0);
  sSitEspecial    := ArqINI.ReadInteger('SPEDPC','SITESPECIAL',0);
  sIndicadorPC    := ArqINI.ReadInteger('SPEDPC','INDICADORPC',0);
  sTpEscrituracao := ArqINI.ReadInteger('SPEDPC','TPESCRITURACAO',0);
  sEscrituracao   := ArqINI.ReadInteger('SPEDPC','ESCRITURACAO',0);
  sNatureza       := ArqINI.ReadInteger('SPEDPC','NATUREZA',0);
  if sSenhaAcesso = '' then
     sSenhaAcesso := Criptografa('123',10);
    // Regime Apura��o
  sIncidencia := ArqINI.ReadInteger('REGIME_APURACAO','INCIDENCIA',0);
  sAproCred   := ArqINI.ReadInteger('REGIME_APURACAO','APROPRIACRED',0);
  sContrApur  := ArqINI.ReadInteger('REGIME_APURACAO','CONTROLEAPUR',0);
  sEscrApur   := ArqINI.ReadInteger('REGIME_APURACAO','ESCRITURAAPUR',0);
  ArqIni.Free;
end;


procedure TDmSPED.DataModuleCreate(Sender: TObject);
begin
  oSpedEFD := TSPED_EFD.CrieInstancia;
  oSpedPC  := TSPED_PC.CrieInstancia;

end;

procedure TDmSPED.DataModuleDestroy(Sender: TObject);
begin
  oSpedEFD.DestruaInstancia;
  oSpedPC.DestruaInstancia;

end;

end.
