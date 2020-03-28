unit uDmRelatorios;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, Datasnap.DBClient, Datasnap.Provider,
  frxClass, frxDBSet;

type
  TDmRelatorios = class(TDataModule)
    QryEntrada: TSQLQuery;
    QrySaidas: TSQLQuery;
    QryComissoes: TSQLQuery;
    DataComissao: TDataSource;
    QryRelatorios: TSQLQuery;
    DspRelatorios: TDataSetProvider;
    CdsRelatorios: TClientDataSet;
    frxGeral: TfrxReport;
    frxDBGeral: TfrxDBDataset;
    frxDBEmpresa: TfrxDBDataset;
    frxDBItens: TfrxDBDataset;
    CdsPeriodo: TClientDataSet;
    CdsPeriododata_inicio: TDateField;
    CdsPeriododata_final: TDateField;
    frxDBPeriodo: TfrxDBDataset;
    QryHorasTrab: TSQLQuery;
    DspHorasTrab: TDataSetProvider;
    CdsHorasTrab: TClientDataSet;
    QryOrdServ: TSQLQuery;
    DspOrdServ: TDataSetProvider;
    CdsOrdServ: TClientDataSet;
    QryOrdServID: TIntegerField;
    QryOrdServN_CONTROLE: TStringField;
    QryOrdServID_CONTATO: TIntegerField;
    QryOrdServCONTATO: TStringField;
    QryOrdServDATA_OS: TSQLTimeStampField;
    QryOrdServHORA_OS: TSQLTimeStampField;
    QryOrdServRECLAMADO: TMemoField;
    QryOrdServCONSTATADO: TMemoField;
    QryOrdServREALIZADO: TMemoField;
    QryOrdServDATA_INICIO: TSQLTimeStampField;
    QryOrdServHORA_INICIO: TSQLTimeStampField;
    QryOrdServDATA_FIM: TSQLTimeStampField;
    QryOrdServHORA_FIM: TSQLTimeStampField;
    QryOrdServTEMPO_GASTO: TSQLTimeStampField;
    QryOrdServVALOR_COBRADO: TFloatField;
    QryOrdServDESCONTO: TFloatField;
    QryOrdServACRESCIMO: TFloatField;
    QryOrdServOUTROS: TFloatField;
    QryOrdServVALOR_PAGO: TFloatField;
    QryOrdServFORMAPAGTO: TIntegerField;
    QryOrdServDOCUMENTO: TIntegerField;
    QryOrdServENDERECO: TStringField;
    QryOrdServNUMERO: TStringField;
    QryOrdServCOMPLEMENTO: TStringField;
    QryOrdServBAIRRO: TStringField;
    QryOrdServCIDADE: TStringField;
    QryOrdServUF: TStringField;
    QryOrdServCEP: TStringField;
    QryOrdServTELEFONE: TStringField;
    QryOrdServCELULAR: TStringField;
    QryOrdServCNPJCPF: TStringField;
    QryOrdServINSCRICAORG: TStringField;
    QryOrdServSTATUS: TIntegerField;
    QryOrdServIDEMPRESA: TIntegerField;
    QryHorasTrabID: TIntegerField;
    QryHorasTrabID_OS: TIntegerField;
    QryHorasTrabID_FUNCIONARIO: TIntegerField;
    QryHorasTrabDATA_OS: TSQLTimeStampField;
    QryHorasTrabDATA_TRAB: TSQLTimeStampField;
    QryHorasTrabHORA_INICIO: TSQLTimeStampField;
    QryHorasTrabHORA_FIM: TSQLTimeStampField;
    QryHorasTrabTEMPO_GASTO: TSQLTimeStampField;
    QryHorasTrabREALIZADO: TMemoField;
    QryHorasTrabNOME: TStringField;
    CdsHorasTrabID: TIntegerField;
    CdsHorasTrabID_OS: TIntegerField;
    CdsHorasTrabID_FUNCIONARIO: TIntegerField;
    CdsHorasTrabDATA_OS: TSQLTimeStampField;
    CdsHorasTrabDATA_TRAB: TSQLTimeStampField;
    CdsHorasTrabHORA_INICIO: TSQLTimeStampField;
    CdsHorasTrabHORA_FIM: TSQLTimeStampField;
    CdsHorasTrabTEMPO_GASTO: TSQLTimeStampField;
    CdsHorasTrabREALIZADO: TMemoField;
    CdsHorasTrabNOME: TStringField;
    frxDBDOrdServ: TfrxDBDataset;
    DataOrdServ: TDataSource;
    frxDBHoras: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PassaPeriodoRelatorio(pDatai,pDataf:TdateTime);
  end;

var
  DmRelatorios: TDmRelatorios;

implementation

Uses uLibrary,uDmConexao, uDmWorkCom;

{$R *.dfm}

{ TDmRelatorios }

procedure TDmRelatorios.PassaPeriodoRelatorio(pDatai,pDataf:TdateTime);
begin
  with CdsPeriodo do
  begin
    if not Active then
    begin
       CreateDataSet;
       EmptyDataSet;
    end
    else EmptyDataSet;
    Append;
    FieldByName('data_inicio').AsDateTime := pDatai;
    FieldByName('data_final').AsDateTime := pDataf;
    Post;
  end;

end;

end.
