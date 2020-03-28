{$I ACBr.inc}

unit uFrmGeraNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids,
  DBGrids, FMTBcd, DB, DBClient, Provider, SqlExpr, pcnConversao, Menus, Clipbrd,
  Mask, DBCtrls;

type
  TFrmGeraNFe = class(TFrmPadrao)
    GroupBox1: TGroupBox;
    RadioOpcao: TRadioGroup;
    GroupBox2: TGroupBox;
    DataIni: TDateTimePicker;
    DataFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BtnLocalizar: TBitBtn;
    GroupBox3: TGroupBox;
    GridNFe: TDBGrid;
    QryNFe: TSQLQuery;
    DspNFe: TDataSetProvider;
    CdsNFe: TClientDataSet;
    DataNFe: TDataSource;
    Panel1: TPanel;
    BtnValidarNFe: TBitBtn;
    GroupBox4: TGroupBox;
    EdtDados: TEdit;
    BtnStatusServ: TBitBtn;
    BtnConsultaRecLote: TBitBtn;
    BtnEnviarNFe: TBitBtn;
    BtnImprimirDanfe: TBitBtn;
    BtnEnviarEmail: TBitBtn;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    EdtNumLote: TEdit;
    ChApropria: TCheckBox;
    QryNFeID: TIntegerField;
    QryNFePEDIDO_NUM: TStringField;
    QryNFeIDCLIENTE: TIntegerField;
    QryNFeID_VENDEDOR: TIntegerField;
    QryNFeDATA_PEDIDO: TSQLTimeStampField;
    QryNFeHORA_PEDIDO: TSQLTimeStampField;
    QryNFeDATA_ENTREGA: TSQLTimeStampField;
    QryNFeHORA_ENTREGA: TSQLTimeStampField;
    QryNFeID_CLASSIFICACAO: TIntegerField;
    QryNFeCONFIRMADA: TStringField;
    QryNFeENTREGUE: TStringField;
    QryNFeVALOR: TFloatField;
    QryNFeDESCONTO: TFloatField;
    QryNFeACRESCIMO: TFloatField;
    QryNFeOUTRAS_DESPESAS: TFloatField;
    QryNFeVALOR_TOTAL: TFloatField;
    QryNFeCANCELADO: TStringField;
    QryNFeID_FORMAPAG: TIntegerField;
    QryNFeEND_ENTREGA: TStringField;
    QryNFeNUM_END_ENTREGA: TStringField;
    QryNFeCOMPL_END_ENTREGA: TStringField;
    QryNFeBAIRRO_END_ENTREGA: TStringField;
    QryNFeCID_END_ENTREGA: TStringField;
    QryNFeUF_END_ENTREGA: TStringField;
    QryNFeCEP_END_ENTREGA: TStringField;
    QryNFeCLIENTE: TStringField;
    QryNFeTIPODOC: TIntegerField;
    QryNFeTIPO_PEDIDO: TIntegerField;
    QryNFeVALOR_REAL: TFloatField;
    QryNFeMARGEM_VENDA: TFloatField;
    QryNFeVALOR_COMISSAO: TFloatField;
    QryNFeTOTAL_GERAL: TFloatField;
    QryNFeCOO: TIntegerField;
    QryNFeCCF: TIntegerField;
    QryNFeGNF: TIntegerField;
    QryNFeDAV: TStringField;
    QryNFeCNPJCPF: TStringField;
    QryNFeINSCEST: TStringField;
    QryNFeVALOR_TROCO: TFloatField;
    QryNFeCAIXA: TStringField;
    QryNFeIDEMPRESA: TIntegerField;
    QryNFeDAV_IMPRESSO: TIntegerField;
    QryNFeNATOP: TStringField;
    QryNFeALIQ_ICMS: TFloatField;
    QryNFeBASE_ICMS: TFloatField;
    QryNFeVALOR_ICMS: TFloatField;
    QryNFeALIQ_ICMS_ST: TFloatField;
    QryNFeBASE_ICMS_ST: TFloatField;
    QryNFeVALOR_ICMS_ST: TFloatField;
    QryNFeVALOR_PIS: TFloatField;
    QryNFeVALOR_COFINS: TFloatField;
    QryNFeVALOR_IPI: TFloatField;
    QryNFeMD5REGISTRO: TStringField;
    QryNFeNUMPV: TStringField;
    QryNFeCER: TIntegerField;
    QryNFeID_MESA: TIntegerField;
    QryNFeABASTECIMENTO: TStringField;
    QryNFeSTATUS_ABASTEC: TIntegerField;
    QryNFeNUMSERIEECF: TStringField;
    QryNFePLACA_VEIC: TStringField;
    QryNFeODOMETRO: TStringField;
    QryNFeCHAVE_NFE: TStringField;
    QryNFeSTATUS_NFE: TStringField;
    QryNFePROTOCOLO_NFE: TStringField;
    QryNFeRECIBO_NFE: TStringField;
    QryNFeDEVOLUCAO: TStringField;
    QryNFeNUMERO_DOC: TStringField;
    QryNFeSINCRONIZADO: TStringField;
    QryNFeIDUSUARIOCANC: TIntegerField;
    QryNFeVALOR_CARGA_TRIB: TFloatField;
    QryNFeNUMDAV: TStringField;
    QryNFeTIPO_FRETE: TIntegerField;
    QryNFeVALOR_FRETE: TFloatField;
    QryNFeVALOR_SEGURO: TFloatField;
    QryNFeVALOR_OUTROS: TFloatField;
    QryNFeBASE_ISS: TFloatField;
    QryNFeVALOR_ISS: TFloatField;
    QryNFeBASE_PIS: TFloatField;
    QryNFeBASE_COFINS: TFloatField;
    QryNFeBASE_IPI: TFloatField;
    QryNFeIDPLANOCONTAS: TIntegerField;
    QryNFeIDCENTROCUSTO: TIntegerField;
    QryNFeNFE_TIPOEMISS: TIntegerField;
    QryNFeNAUTORIZA_VIDALINK: TStringField;
    CdsNFeID: TIntegerField;
    CdsNFePEDIDO_NUM: TStringField;
    CdsNFeIDCLIENTE: TIntegerField;
    CdsNFeID_VENDEDOR: TIntegerField;
    CdsNFeDATA_PEDIDO: TSQLTimeStampField;
    CdsNFeHORA_PEDIDO: TSQLTimeStampField;
    CdsNFeDATA_ENTREGA: TSQLTimeStampField;
    CdsNFeHORA_ENTREGA: TSQLTimeStampField;
    CdsNFeID_CLASSIFICACAO: TIntegerField;
    CdsNFeCONFIRMADA: TStringField;
    CdsNFeENTREGUE: TStringField;
    CdsNFeVALOR: TFloatField;
    CdsNFeDESCONTO: TFloatField;
    CdsNFeACRESCIMO: TFloatField;
    CdsNFeOUTRAS_DESPESAS: TFloatField;
    CdsNFeVALOR_TOTAL: TFloatField;
    CdsNFeCANCELADO: TStringField;
    CdsNFeID_FORMAPAG: TIntegerField;
    CdsNFeEND_ENTREGA: TStringField;
    CdsNFeNUM_END_ENTREGA: TStringField;
    CdsNFeCOMPL_END_ENTREGA: TStringField;
    CdsNFeBAIRRO_END_ENTREGA: TStringField;
    CdsNFeCID_END_ENTREGA: TStringField;
    CdsNFeUF_END_ENTREGA: TStringField;
    CdsNFeCEP_END_ENTREGA: TStringField;
    CdsNFeCLIENTE: TStringField;
    CdsNFeTIPODOC: TIntegerField;
    CdsNFeTIPO_PEDIDO: TIntegerField;
    CdsNFeVALOR_REAL: TFloatField;
    CdsNFeMARGEM_VENDA: TFloatField;
    CdsNFeVALOR_COMISSAO: TFloatField;
    CdsNFeTOTAL_GERAL: TFloatField;
    CdsNFeCOO: TIntegerField;
    CdsNFeCCF: TIntegerField;
    CdsNFeGNF: TIntegerField;
    CdsNFeDAV: TStringField;
    CdsNFeCNPJCPF: TStringField;
    CdsNFeINSCEST: TStringField;
    CdsNFeVALOR_TROCO: TFloatField;
    CdsNFeCAIXA: TStringField;
    CdsNFeIDEMPRESA: TIntegerField;
    CdsNFeDAV_IMPRESSO: TIntegerField;
    CdsNFeNATOP: TStringField;
    CdsNFeALIQ_ICMS: TFloatField;
    CdsNFeBASE_ICMS: TFloatField;
    CdsNFeVALOR_ICMS: TFloatField;
    CdsNFeALIQ_ICMS_ST: TFloatField;
    CdsNFeBASE_ICMS_ST: TFloatField;
    CdsNFeVALOR_ICMS_ST: TFloatField;
    CdsNFeVALOR_PIS: TFloatField;
    CdsNFeVALOR_COFINS: TFloatField;
    CdsNFeVALOR_IPI: TFloatField;
    CdsNFeMD5REGISTRO: TStringField;
    CdsNFeNUMPV: TStringField;
    CdsNFeCER: TIntegerField;
    CdsNFeID_MESA: TIntegerField;
    CdsNFeABASTECIMENTO: TStringField;
    CdsNFeSTATUS_ABASTEC: TIntegerField;
    CdsNFeNUMSERIEECF: TStringField;
    CdsNFePLACA_VEIC: TStringField;
    CdsNFeODOMETRO: TStringField;
    CdsNFeCHAVE_NFE: TStringField;
    CdsNFeSTATUS_NFE: TStringField;
    CdsNFePROTOCOLO_NFE: TStringField;
    CdsNFeRECIBO_NFE: TStringField;
    CdsNFeDEVOLUCAO: TStringField;
    CdsNFeNUMERO_DOC: TStringField;
    CdsNFeSINCRONIZADO: TStringField;
    CdsNFeIDUSUARIOCANC: TIntegerField;
    CdsNFeVALOR_CARGA_TRIB: TFloatField;
    CdsNFeNUMDAV: TStringField;
    CdsNFeTIPO_FRETE: TIntegerField;
    CdsNFeVALOR_FRETE: TFloatField;
    CdsNFeVALOR_SEGURO: TFloatField;
    CdsNFeVALOR_OUTROS: TFloatField;
    CdsNFeBASE_ISS: TFloatField;
    CdsNFeVALOR_ISS: TFloatField;
    CdsNFeBASE_PIS: TFloatField;
    CdsNFeBASE_COFINS: TFloatField;
    CdsNFeBASE_IPI: TFloatField;
    CdsNFeIDPLANOCONTAS: TIntegerField;
    CdsNFeIDCENTROCUSTO: TIntegerField;
    CdsNFeNFE_TIPOEMISS: TIntegerField;
    CdsNFeNAUTORIZA_VIDALINK: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BtnCartaCorrecao: TBitBtn;
    PnJustifica: TPanel;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    EdtJustifica: TEdit;
    QryNFeNUM_LOTE: TStringField;
    QryNFeARQUIVO_XML: TStringField;
    CdsNFeNUM_LOTE: TStringField;
    CdsNFeARQUIVO_XML: TStringField;
    MemoXML: TMemo;
    PopupMenu1: TPopupMenu;
    VerarquivoXML1: TMenuItem;
    LiberaravalidaodaNFe1: TMenuItem;
    QryNFeVAL_CARGA_FED: TFloatField;
    QryNFeVAL_CARGA_EST: TFloatField;
    QryNFeVAL_CARGA_MUN: TFloatField;
    QryNFeNOTAMANUAL: TStringField;
    QryNFeCOO_CONF_MESA: TIntegerField;
    QryNFeMODELO: TStringField;
    QryNFeDATA_AUTORIZA: TSQLTimeStampField;
    QryNFeHORA_AUTORIZA: TSQLTimeStampField;
    CdsNFeVAL_CARGA_FED: TFloatField;
    CdsNFeVAL_CARGA_EST: TFloatField;
    CdsNFeVAL_CARGA_MUN: TFloatField;
    CdsNFeNOTAMANUAL: TStringField;
    CdsNFeCOO_CONF_MESA: TIntegerField;
    CdsNFeMODELO: TStringField;
    CdsNFeDATA_AUTORIZA: TSQLTimeStampField;
    CdsNFeHORA_AUTORIZA: TSQLTimeStampField;
    ConsultareatualizardadosdaNFe1: TMenuItem;
    OpenDialog1: TOpenDialog;
    RadioModelo: TRadioGroup;
    Edit1: TEdit;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    SQLQuery1: TSQLQuery;
    SQLQuery1NUMERO_DOC: TIntegerField;
    DataSource1: TDataSource;
    Label4: TLabel;
    AlteraNumeroNFE1: TMenuItem;
    AlteraNmerodaNFe1: TMenuItem;
    PedidosNFes: TRadioGroup;
    AlteraProtocolodaNFe1: TMenuItem;
    AlteraStatusdaNFe1: TMenuItem;
    AlteraReciboNFE1: TMenuItem;
    BitBtn3: TBitBtn;
    CopiaChaveNFE1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnValidarNFeClick(Sender: TObject);
    procedure BtnEnviarNFeClick(Sender: TObject);
    procedure BtnImprimirDanfeClick(Sender: TObject);
    procedure BtnEnviarEmailClick(Sender: TObject);
    procedure BtnStatusServClick(Sender: TObject);
    procedure BtnConsultaRecLoteClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BtnCartaCorrecaoClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EdtJustificaKeyPress(Sender: TObject; var Key: Char);
    procedure MemoXMLKeyPress(Sender: TObject; var Key: Char);
    procedure GridNFeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure VerarquivoXML1Click(Sender: TObject);
    procedure EdtJustificaExit(Sender: TObject);
    procedure LiberaravalidaodaNFe1Click(Sender: TObject);
    procedure ConsultareatualizardadosdaNFe1Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure AlteraNumeroNFE1Click(Sender: TObject);
    procedure AlteraNmerodaNFe1Click(Sender: TObject);
    procedure AlteraProtocolodaNFe1Click(Sender: TObject);
    procedure AlteraStatusdaNFe1Click(Sender: TObject);
    procedure AlteraReciboNFE1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CopiaChaveNFE1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaDadosXML;
    function TestaNotaJaEnviada:Boolean;
  public
    { Public declarations }
  end;

var
  FrmGeraNFe: TFrmGeraNFe;
  chavedanfe: string;
implementation

uses uDmConexao, uDmWorkCom, pcnNFe, DateUtils, uLibrary, uDmAcBr,
  uFrmConsultasNFe, uFrmClientes, uFrmCadClassPedido, uFrmCadFormaPag,
  uFrmPedidosConsulta, uFrmProdutos, uFrmLancPedidos, uMensagem, uDMClientes,  {unit1,}
  uDmAuxiliar, uFrmNfeReferencia; //fabricio uFrmNfeReferencia

{$R *.dfm}

procedure TFrmGeraNFe.FormShow(Sender: TObject);
begin
  inherited;
//fabricio inicio
  DataIni.Date := Date;
  DataFim.Date := Date;
  DmWorkCom.AtualizaConfigAcBr;
  Self.WindowState := wsMaximized;
  EdtDados.SetFocus;
  if DmWorkCom.sAmbiente = 0 then
     Label4.Caption:= 'Ambiente: Produ��o'
  else
     Label4.Caption:= 'Ambiente: Homologa��o';
//fabricio fim - apagar todo o antigo e incluit isso
end;

procedure TFrmGeraNFe.BtnLocalizarClick(Sender: TObject);
begin
  inherited;
  CdsNFe.Close;
  CdsNFe.Params.Clear;
  QryNFe.Close;
  QryNFe.SQL.Clear;
  QryNFe.SQL.Add('select * from pedido');
  QryNFe.SQL.Add('where pedido.data_pedido between :pDatai and :pDataf');
  case RadioOpcao.ItemIndex of
    0: QryNFe.SQL.Add('and pedido.pedido_num = :pDados');
    1: QryNFe.SQL.Add('and pedido.idcliente = :pDados');
    2: QryNFe.SQL.Add('and upper(pedido.cliente) like :pDados');
  end;

  case PedidosNFes.ItemIndex of
//    0: QryNFe.SQL.Add('and pedido.status_nfe = 100');
    1: QryNFe.SQL.Add('and pedido.status_nfe =' +QuotedStr('100'));
    2: QryNFe.SQL.Add('and pedido.status_nfe =' +QuotedStr('128'));
  end;



  //  QryNFe.SQL.Add('and pedido.numero_doc is null');
//  QryNFe.SQL.Add('and pedido.chave_nfe is null');
  QryNFe.SQL.Add('and pedido.idempresa = :pIDEmpresa');
  QryNFe.SQL.Add('and pedido.confirmada = '+QuotedStr('S'));
//  QryNFe.SQL.Add('and pedido.cancelado = '+QuotedStr('N'));
  QryNFe.SQL.Add('and pedido.cnpjcpf is not null');
  QryNFe.SQL.Add('and pedido.cnpjcpf <> '+QuotedStr(''));
  QryNFe.SQL.Add('and pedido.cnpjcpf <> '+QuotedStr('11111111111'));



//fabricio inicio
  QryNFe.SQL.Add('order by pedido.id');
//fabricio fim

  // parametros

//fabricio
  Dataini.Time:= StrToTime('00:00:00');
  DataFim.Time:= StrToTime('23:59:59');



  CdsNFe.FetchParams;
//fabricio tirar o date e substituir por asdatetime e datetime
{  CdsNFe.Params.ParamByName('pDatai').AsDate := DataIni.Date;
  CdsNFe.Params.ParamByName('pDataf').AsDate := DataFim.Date;
}
//fabricio incluido o asdatetime e datetime
  CdsNFe.Params.ParamByName('pDatai').AsDateTime := DataIni.DateTime;
  CdsNFe.Params.ParamByName('pDataf').AsDateTime := DataFim.DateTime;
//fabricio fim


  case RadioOpcao.ItemIndex of
    0: CdsNFe.Params.ParamByName('pDados').AsString  := EdtDados.Text;
    1: CdsNFe.Params.ParamByName('pDados').AsInteger := StrToInt(EdtDados.Text);
    2: CdsNFe.Params.ParamByName('pDados').AsString  := '%'+UpperCase(EdtDados.Text);
  end;
  CdsNFe.Params.ParamByName('pIDEmpresa').AsInteger  := sIDEmpresa;
  CdsNFe.Open;
  TFloatField(DataNFe.DataSet.FieldByName('VALOR')).DisplayFormat := '###,###,##0.00';
  TFloatField(DataNFe.DataSet.FieldByName('ACRESCIMO')).DisplayFormat := '###,###,##0.00';
  TFloatField(DataNFe.DataSet.FieldByName('DESCONTO')).DisplayFormat := '###,###,##0.00';
  TFloatField(DataNFe.DataSet.FieldByName('VALOR_TOTAL')).DisplayFormat := '###,###,##0.00';
  GridNFe.SetFocus;

end;

procedure TFrmGeraNFe.BtnValidarNFeClick(Sender: TObject);
var aNumIten : Integer;
    aChaveNfe, aRecibo, aProcolo, aNomeArq, aStatus: String;
    aDtAutori, aHrAutori : TDateTime;
    rfchavenfe : string;
begin
  inherited;
  if DataNFe.DataSet.RecordCount = 0 then
  begin
    MessageDlg('� necess�rio selecionar o pedido!',mtWarning,[mbOK],0);
    Abort;
  end;
  if not DmClientes.Dados_Contato(CdsNFeIDCLIENTE.AsInteger) then
  begin
    MessageDlg('Cliente n�o esta cadastrado. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  if not DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
    MessageDlg('Pedido n�o encontrado. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  if not DmWorkCom.Dados_PedidoItens(CdsNFeID.AsInteger) then
  begin
    MessageDlg('N�o h� itens para este pedido. Verifique!',mtWarning,[mbOK],0);
    Abort;
  end;
  if DmWorkCom.CdsPedidos.FieldByName('NATOP').AsString = '' then
  begin
    MessageDlg('Lan�amento sem a NATOP. Verifique!!!', mtInformation, [mbOK], 0);
    Exit;
  end;
//  if DmWorkCom.CdsPedidos.FieldByName('NUMERO_DOC').AsString <> '' then
//  begin
//    MessageDlg('J� existe numero de nota para esse registro. Verifique!!!', mtInformation, [mbOK], 0);
//    Exit;
//  end;
  if CdsNFeCHAVE_NFE.AsString <> '' then
  begin
    MessageDlg('J� foi gerado NFe para este pedido!!!', mtInformation, [mbOK], 0);
    Exit;
  end;
  //
  try
    if DmWorkCom.GerarNFe(CdsNFe.FieldByName('ID').AsInteger,ChApropria.Checked) then
    begin
      if DmAcBr.ACBrNFe1.NotasFiscais.Count > 0 then
      begin

//fabricio inicio
        SqlQuery1.Close;
        SqlQuery1.SQL.Clear;
        SqlQuery1.SQL.Add('select NUMERO_DOC from NFE_NUMERO');
        SqlQuery1.SQL.Add('where IDEMPRESA = ' + DmWorkCom.CdsEmpresaID.AsString);
//        if radiomodelo.ItemIndex = 0 then
           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('55'));
//        else
//           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('65'));

        SqlQuery1.SQL.Add('and AMBIENTE = ' + IntToStr(DmWorkCom.sAmbiente + 1));
        SqlQuery1.Open;
        Edit1.Text:= SqlQuery1NUMERO_DOC.AsString;

          if Edit1.Text <> '' then
         begin
            if StrToInt(Edit1.Text) <> (DmWorkCom.CdsPedidos.FieldByName('NUMERO_DOC').AsInteger) then
            begin
              if MessageDlg('Num.NFE n�o coincide com a �ltima NFE. Cancelar a Valida��o da NFE?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
              abort;
            end;
         end;
{
          if (DmWorkCom.CdsPedidos.FieldByName('NATOP').AsString = 'Venda de mercadoria adquirida ou recebida de terceiros') or
             (DmWorkCom.CdsPedidos.FieldByName('NATOP').AsString = 'VENDA DE MERCADORIAS')     then
          begin

          end
          else
}


//fabricio fim
        // comandos para gerar arquivo XML
        DmAcBr.ACBrNFe1.NotasFiscais.Assinar;
        DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
        // executa valida��o do arquivo
        DmAcBr.ACBrNFe1.NotasFiscais.Validar;
        // grava o arquivo XML
        DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                  DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
        //
        aChaveNfe := Copy(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);;
        aProcolo  := '';
        aRecibo   := '';
        aNomeArq  := DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq;
        aStatus   := '';
        aDtAutori := Now;
        aHrAutori := Now;
        // grava chave NFe
        if aChaveNfe <> '' then
        begin
          DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                        aProcolo,
                                        aRecibo,
                                        EdtNumLote.Text,
                                        aNomeArq,
                                        aStatus,
                                        DmWorkCom.sFormas,
                                        CdsNFeID.AsInteger,
                                        aDtAutori,
                                        aHrAutori);
//          BtnLocalizarClick(Sender);
          CdsNFe.Refresh;
        end;
        MessageDlg('Arquivo gerado em: '+DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq, mtInformation, [mbOK], 0);
      end;
    end;
  except
    on E : Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;

end;

procedure TFrmGeraNFe.BtnEnviarNFeClick(Sender: TObject);
var aChaveNfe, aRecibo, aProcolo, aNomeArq, aStatus : String;
    formMensagem: TFormMensagem;
    aDtAutori, aHrAutori : TDateTime;
begin
  inherited;
  try
    if (CdsNFeCHAVE_NFE.AsString = '') or (Trim(CdsNFeSTATUS_NFE.AsString) <> '') then
    begin
      TestaNotaJaEnviada;
      Exit;
    end;
    //

//    Form1.ShowModal;

//    Form1.lerconfiguracao;
//
    CarregaDadosXML;
{
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := Form1.ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  OpenDialog1.Execute;

}
//  form1.ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName, False);
    // verifica numero do lote informado

    DmAcbr.ACBrNFe1.Configuracoes.Geral.Salvar:=true;

    EdtNumLote.Text := FiltraNumero(EdtNumLote.Text);
    if Trim(EdtNumLote.Text) = '' then
    begin
      EdtNumLote.Text := FormatDateTime('yyyymmss',Now);
    end;
    //
    formMensagem := TFormMensagem.Create('Aguarde... Enviando NFe!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;


    // limpa valores
    aChaveNfe := '';
    aProcolo  := '';
    aRecibo   := '';
    aNomeArq  := '';
    aStatus   := '';

    // enviar ao portal
    DmAcBr.ACBrNFe1.Enviar(EdtNumLote.Text); //fabricio  lote e true
    //
    aChaveNfe := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtDFe.Items[0].chDFe;
    aProcolo  := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtDFe.Items[0].nProt;
    aRecibo   := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
    aNomeArq  := DmAcbr.ACBrNFe1.NotasFiscais.Items[0].NomeArq;
    aStatus   := IntToStr(DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtDFe.Items[0].cStat);
    aDtAutori := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtDFe.Items[0].dhRecbto;
    aHrAutori := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtDFe.Items[0].dhRecbto;
    // grava chave NFe


//fabricio inicio

  if (aChaveNfe <> '') and (aRecibo <> '') and (aStatus = '100') then
  begin

  end
  else
  begin
    if aprocolo = '' then
       ShowMessage('Erro de internet ou na SEFAZ/MS. Protocolo n�o encontrado, Informe o Fabricio !')
    else
    if arecibo = ''then
       ShowMessage('Erro de internet ou na SEFAZ/MS. Recibo n�o encontrado, Informe o Fabricio !')
    else
    if aChaveNfe = ''then
       ShowMessage('Erro de internet ou na SEFAZ/MS. Chave n�o encontrada, Informe o Fabricio !')
    else
    if aStatus = ''then
       ShowMessage('Erro de internet ou na SEFAZ/MS. Status n�o encontrado, Informe o Fabricio !');
  end;

//fabricio fim





//fabricio tirar    if (aChaveNfe <> '') and (aRecibo <> '') and (aStatus = '100') then
//fabricio tirar    begin
      DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                    aProcolo,
                                    aRecibo,
                                    EdtNumLote.Text,
                                    aNomeArq,
                                    aStatus,
                                    DmWorkCom.sFormas,
                                    CdsNFeID.AsInteger,
                                    aDtAutori,
                                    aHrAutori);
      // atualiza o XML
      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
      DmWorkCom.GravaArquivoXML(DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,
                                DmAcBr.ACBrNFe1.NotasFiscais.Items[0].XML);
      // verifica se tem produto combustivel para gerar o abastecimento
      DmWorkCom.VerificaGeraAbsProdCombustivel(CdsNFe.FieldByName('ID').AsInteger,
                                               CdsNFe.FieldByName('NUMERO_DOC').AsString);
      // altera o status dos abastecimentos vinculados
      DmWorkCom.VerificaAlteraStatusAbastecimento(CdsNFe.FieldByName('ID').AsInteger);
//fabricio tirar    end;
    BtnLocalizarClick(Sender);
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  except
    on E : Exception do
    begin

//fabricio inicio
{
    if aprocolo = '' then
       ShowMessage('Falha de internet ou na SEFAZ/MS. Protocolo n�o encontrado, Informe o Fabricio !')
    else
    if arecibo = ''then
       ShowMessage('Falha de internet ou na SEFAZ/MS. Recibo n�o encontrado, Informe o Fabricio !')
    else
    if aChaveNfe = ''then
       ShowMessage('Falha de internet ou na SEFAZ/MS. Chave n�o encontrada, Informe o Fabricio !')
    else
    if aStatus = ''then
       ShowMessage('Falha de internet ou na SEFAZ/MS. Status n�o encontrado, Informe o Fabricio !');

    TestaNotaJaEnviada;
}
       //fabricio fim





      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
      ShowMessage(E.Message);
    end;
  end;

end;

{
procedure TFrmGeraNFe.BtnEnviarNFeClick(Sender: TObject);
var aChaveNfe, aRecibo, aProcolo, aNomeArq, aStatus : String;
    formMensagem: TFormMensagem;
begin
  inherited;
  try
    if (CdsNFeCHAVE_NFE.AsString = '') or (Trim(CdsNFeSTATUS_NFE.AsString) <> '') then
    begin
      TestaNotaJaEnviada;
      Exit;
    end;
    //
    CarregaDadosXML;
    // verifica numero do lote informado
    EdtNumLote.Text := FiltraNumero(EdtNumLote.Text);
    if Trim(EdtNumLote.Text) = '' then
    begin
      EdtNumLote.Text := FormatDateTime('yyyymmss',Now);
    end;
    //
    formMensagem := TFormMensagem.Create('Aguarde... Enviando NFe!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    // limpa valores
    aChaveNfe := '';
    aProcolo  := '';
    aRecibo   := '';
    aNomeArq  := '';
    aStatus   := '';

    // enviar ao portal
    DmAcBr.ACBrNFe1.Enviar(EdtNumLote.Text);
    //
    aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
    aProcolo  := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
    aRecibo   := DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
    aNomeArq  := DmAcBr.ACBrNFe1.NotasFiscais.Items[0].NomeArq;
    aStatus   := IntToStr(DmAcBr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);
    // grava chave NFe
    if (aChaveNfe <> '') and (aRecibo <> '') and (aStatus = '100') then
    begin
      DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                    aProcolo,
                                    aRecibo,
                                    EdtNumLote.Text,
                                    aNomeArq,
                                    aStatus,
                                    DmWorkCom.sFormas,
                                    CdsNFeID.AsInteger);
      // verifica se tem produto combustivel para gerar o abastecimento
      DmWorkCom.VerificaGeraAbsProdCombustivel(CdsNFe.FieldByName('ID').AsInteger,
                                               CdsNFe.FieldByName('NUMERO_DOC').AsString);
    end;
    BtnLocalizarClick(Sender);
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  except
    on E : Exception do
    begin
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
      ShowMessage(E.Message);
    end;
  end;

end;
}

procedure TFrmGeraNFe.BtnImprimirDanfeClick(Sender: TObject);
begin
  inherited;
  if CdsNFeCHAVE_NFE.AsString = '' then
  begin
    MessageDlg('Registro selecionado n�o possui chave!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  CarregaDadosXML;
  if DmAcBr.ACBrNFe1.NotasFiscais.Count > 0 then
  begin
    if CdsNFeSTATUS_NFE.AsString <> '100' then
    begin
      //DmAcBr.ACBrNFe1.DANFE.NFeCancelada := True;
      //DmAcBr.ACBrNFe1.DANFE.ProtocoloNFe := CdsNFePROTOCOLO_NFE.AsString+FormatDateTime('dd/mm/yyyy hh:mm:ss',Now);
      //rondado Janeiro 2019
      DmAcBr.ACBrNFe1.DANFE.Cancelada := True;
      DmAcBr.ACBrNFe1.DANFE.Protocolo := CdsNFePROTOCOLO_NFE.AsString+FormatDateTime('dd/mm/yyyy hh:mm:ss',Now)

    end;
    // emite o Danfe
    DmAcBr.ACBrNFe1.NotasFiscais.Imprimir;
    // retorna o status
    if CdsNFeSTATUS_NFE.AsString <> '100' then
    begin
      //DmAcBr.ACBrNFe1.DANFE.NFeCancelada := false;
      //DmAcBr.ACBrNFe1.DANFE.ProtocoloNFe := '';
      //rondado Janeiro 2019
       DmAcBr.ACBrNFe1.DANFE.Cancelada := false;
       DmAcBr.ACBrNFe1.DANFE.Protocolo := '';


    end;
  end;

end;

procedure TFrmGeraNFe.BtnEnviarEmailClick(Sender: TObject);
var Endereco,Mensagem : TStrings;
begin
  inherited;
  if (CdsNFeCHAVE_NFE.AsString = '') or (Trim(CdsNFeSTATUS_NFE.AsString) <> '100') then
  begin
    MessageDlg('NFe n�o enviada ou com status diferente do esperado!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  CarregaDadosXML;
  if DmAcBr.ACBrNFe1.NotasFiscais.Count > 0 then
  begin
    // verifica cadastro do cliente
    if DmClientes.Dados_Contato(CdsNFeIDCLIENTE.AsInteger) then
    begin
      if DmClientes.CdsContatosEMAIL.AsString = '' then
      begin
        MessageDlg('N�o h� email cadastrado para o cliente da nota!', mtWarning, [mbOK], 0);
        Exit;
      end;
      // carrega email do destinatario no strings
//fabricio      Mensagem := TStrings.Create;
      Mensagem := TStringlist.Create;
      Mensagem.Add('NFe');
//fabricio      Endereco := TStrings.Create;
      Endereco := TStringList.Create;
      Endereco.Add(DmWorkCom.sSMTPUsu);



      // configura o componente acbremail
     // DmAcbr.ACBrMail1.AddAddress('rondado@terra.com.br');

      DmAcBr.ACBrNFe1.MAIL      := DmAcBr.ACBrMail1;
      DmAcBr.ACBrMail1.From     := DmWorkCom.sSMTPUsu;
      DmAcBr.ACBrMail1.FromName := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
      DmAcBr.ACBrMail1.Host     := DmWorkCom.sSMPTHost; // troque pelo seu servidor smtp
      DmAcBr.ACBrMail1.Username := DmWorkCom.sSMTPUsu;
      DmAcBr.ACBrMail1.Password := DmWorkCom.sSMTPPass;
      DmAcBr.ACBrMail1.Port     := DmWorkCom.sSMTPPort; // troque pela porta do seu servidor smtp
      DmAcBr.ACBrMail1.SetSSL   := False;  // Verifique se o seu servidor necessita SSL
      DmAcBr.ACBrMail1.SetTLS :=True; //rondado jan 2019
      // enviar email
      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(DmClientes.CdsContatosEMAIL.AsString, 'NFe',Mensagem, true, Endereco);
{
      DmAcBr.ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(DmWorkCom.sSMPTHost,
                                                        DmWorkCom.sSMTPPort,
                                                        DmWorkCom.sSMTPUsu,
                                                        DmWorkCom.sSMTPPass,
                                                        DmWorkCom.CdsEmpresaEMAIL.AsString,
                                                        CdsNFeCLIENTE.AsString,
                                                        'NFe',
                                                        Mensagem,
                                                        true,
                                                        true,
                                                        Endereco,
                                                        nil,
                                                        false,
                                                        true,
                                                        DmWorkCom.CdsEmpresaFANTASIA.AsString);
}
      MessageDlg('Email enviado com sucesso!', mtInformation, [mbOK], 0);
      FreeAndNil(Endereco);
    end;
  end;
end;

procedure TFrmGeraNFe.BtnStatusServClick(Sender: TObject);
var formMensagem: TFormMensagem;
    auxbool : Boolean;
begin
  inherited;
  try
    formMensagem := TFormMensagem.Create('Aguarde... Verificando Status do servi�o!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    auxbool := DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar;
    DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar := True;
    DmAcBr.ACBrNFe1.WebServices.StatusServico.Executar;
    DmAcBr.ACBrNFe1.Configuracoes.WebServices.Visualizar := auxbool;
  finally
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
  end;

end;

procedure TFrmGeraNFe.BtnConsultaRecLoteClick(Sender: TObject);
begin
  inherited;
  AbreForm(TFrmConsultasNFe,FrmConsultasNFe);
  
end;

procedure TFrmGeraNFe.AlteraNmerodaNFe1Click(Sender: TObject);
var
numnfe:string;
begin
  inherited;
//fabricio inicio - incluido no popmenu1 a opcao altera numero nfe
  if  DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
      DmWorkcom.CdsPedidos.Edit;
      if InputQuery('Pesquisa','Informe o n�mero da NFe :',numnfe) then
      begin

      DmWorkcom.CdsPedidos.FieldByName('NUMERO_DOC').AsString := zeroesquerda(numnfe,6);
      Grava_Dados(DmWorkcom.CdsPedidos);
      BtnLocalizarClick(Sender);
      end;

  end;
//    FormMensagem.destruir;
//    FreeAndNil(FormMensagem);

//fabricio fim




end;

procedure TFrmGeraNFe.AlteraNumeroNFE1Click(Sender: TObject);
begin
  inherited;
//fabricio inicio - incluido no popmenu1 a opcao altera numero nfe

  if  DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
      DmWorkcom.CdsPedidos.Edit;
      DmWorkcom.CdsPedidos.FieldByName('NUMERO_DOC').AsString := '';
      Grava_Dados(DmWorkcom.CdsPedidos);
      BtnLocalizarClick(Sender);
  end;
//    FormMensagem.destruir;
//    FreeAndNil(FormMensagem);

//fabricio fim
end;

procedure TFrmGeraNFe.AlteraProtocolodaNFe1Click(Sender: TObject);
var
protocolonfe: string;
begin
  inherited;
//fabricio inicio - incluido no popmenu1 a opcao altera numero nfe
  if  DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
      DmWorkcom.CdsPedidos.Edit;
      if InputQuery('Pesquisa','Informe o Protocolo da NFe :',protocolonfe) then
      begin

      DmWorkcom.CdsPedidos.FieldByName('PROTOCOLO_NFE').AsString := protocolonfe ;
      Grava_Dados(DmWorkcom.CdsPedidos);
      BtnLocalizarClick(Sender);
      end;

  end;
//    FormMensagem.destruir;
//    FreeAndNil(FormMensagem);

//fabricio fim


end;

procedure TFrmGeraNFe.AlteraReciboNFE1Click(Sender: TObject);
var
recibonfe: string;
begin
  inherited;
//fabricio inicio - incluido no popmenu1 a opcao altera numero nfe
  if  DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
      DmWorkcom.CdsPedidos.Edit;
      if InputQuery('Pesquisa','Informe o Recibo da NFe :',recibonfe) then
      begin

      DmWorkcom.CdsPedidos.FieldByName('RECIBO_NFE').AsString := recibonfe;
      Grava_Dados(DmWorkcom.CdsPedidos);
      BtnLocalizarClick(Sender);
      end;

  end;
//    FormMensagem.destruir;
//    FreeAndNil(FormMensagem);

//fabricio fim


end;

procedure TFrmGeraNFe.AlteraStatusdaNFe1Click(Sender: TObject);
var
statusnfe: string;
begin
  inherited;
//fabricio inicio - incluido no popmenu1 a opcao altera numero nfe
  if  DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
  begin
      DmWorkcom.CdsPedidos.Edit;
      if InputQuery('Pesquisa','Informe o Status da NFe :',statusnfe) then
      begin

      DmWorkcom.CdsPedidos.FieldByName('STATUS_NFE').AsString := statusnfe;
      Grava_Dados(DmWorkcom.CdsPedidos);
      BtnLocalizarClick(Sender);
      end;

  end;
//    FormMensagem.destruir;
//    FreeAndNil(FormMensagem);

//fabricio fim


end;

procedure TFrmGeraNFe.BitBtn10Click(Sender: TObject);
begin
  inherited;
//fabricio - inicio - incluir botao consulta
        SqlQuery1.Close;
        SqlQuery1.SQL.Clear;
        SqlQuery1.SQL.Add('select NUMERO_DOC from NFE_NUMERO');
        SqlQuery1.SQL.Add('where IDEMPRESA = ' + DmWorkCom.CdsEmpresaID.AsString);
        if radiomodelo.ItemIndex = 0 then
           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('55'))
        else
           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('65'));
        //        SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr(Edit2.Text));
        SqlQuery1.SQL.Add('and AMBIENTE = ' + IntToStr(DmWorkCom.sAmbiente + 1));
        SqlQuery1.Open;
        Edit1.Text:= SqlQuery1NUMERO_DOC.AsString;
//fabricio fim -
end;

procedure TFrmGeraNFe.BitBtn1Click(Sender: TObject);
begin
  inherited;
  // Lancamento de Encomendas
  Application.CreateForm(TFrmClientes,FrmClientes);
  Application.CreateForm(TFrmCadClassPedido,FrmCadClassPedido);
  Application.CreateForm(TFrmCadFormaPag,FrmCadFormaPag);
  Application.CreateForm(TFrmPedidosConsulta,FrmPedidosConsulta);
  Application.CreateForm(TfrmProdutos,FrmProdutos);
  Application.CreateForm(TFrmLancPedidos,FrmLancPedidos);
  try
    FrmLancPedidos.ShowModal;
  finally
    FrmLancPedidos.Destroy;
    FrmProdutos.Destroy;
    FrmPedidosConsulta.Destroy;
    FrmCadFormapag.Destroy;
    FrmCadClassPedido.Destroy;
    FrmClientes.Destroy;
  end;

end;

procedure TFrmGeraNFe.BtnCartaCorrecaoClick(Sender: TObject);
var idLote, Correcao, CNPJ : string;
    nSeqEvento : Integer;
    formMensagem: TFormMensagem;
begin
  inherited;
  if (CdsNFeCHAVE_NFE.AsString = '') or (Trim(CdsNFeSTATUS_NFE.AsString) <> '100') then
  begin
    MessageDlg('NFe n�o enviada ou com status diferente do esperado!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  CarregaDadosXML;
  idLote := FormatDateTime('mmss',Now);
  CNPJ := copy(CdsNFeCHAVE_NFE.AsString,7,14);
  nSeqEvento := DmWorkCom.RetornaSequenciaCartaCorrecao;
  Correcao := '';
  if not(InputQuery('WebServices Eventos: Carta de Corre��o', 'Corre��o a ser considerada', Correcao)) then
     exit;
  try
    formMensagem := TFormMensagem.Create('Aguarde... Enviando carta de corre��o!',550,150,clBlack,clSilver);
    formMensagem.mostrar;
    Refresh;
    //
    DmAcBr.ACBrNFe1.EventoNFe.Evento.Clear;
    with DmAcBr.ACBrNFe1.EventoNFe.Evento.Add do
     begin
       infEvento.chNFe := CdsNFeCHAVE_NFE.AsString;
       infEvento.CNPJ   := CNPJ;
       infEvento.dhEvento := now;
       infEvento.tpEvento := teCCe;
       infEvento.nSeqEvento := nSeqEvento;
       infEvento.detEvento.xCorrecao := Correcao;
     end;
    DmAcBr.ACBrNFe1.EnviarEvento(StrToInt(idLote));
    FormMensagem.destruir;
    FreeAndNil(FormMensagem);
    MessageDlg('Carta de corre��o enviada com sucesso', mtInformation, [mbOK], 0);
  except
    on E : Exception do
    begin
      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
      ShowMessage(E.Message);
    end
  end;

end;

procedure TFrmGeraNFe.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if CdsNFe.RecordCount = 0 then
  begin
    ShowMessage('� necess�rio seleciona NFe!');
    Abort;
  end;
  if CdsNFeCANCELADO.AsString <> 'N' then
  begin
    ShowMessage('A NFe selecionada j� esta cancelada!');
    Abort;
  end;
  if (CdsNFeCHAVE_NFE.AsString = '') or (Trim(CdsNFeSTATUS_NFE.AsString) <> '100') then
  begin
    MessageDlg('NFe n�o enviada ou com status diferente do esperado!', mtWarning, [mbOK], 0);
    Exit;
  end;
  //
  CarregaDadosXML;
  // exibe a tela de justificativa
  PnJustifica.Visible := true;
  EdtJustifica.Clear;
  EdtJustifica.SetFocus;

end;

procedure TFrmGeraNFe.BitBtn3Click(Sender: TObject);
var
achavenfe : string;
begin
  inherited;
  if CdsNFeChave_Nfe.AsString <> '' then
  begin
     CarregaDadosXml;
     if InputQuery('Chave NFe','Informe a chave da NFe de refer�ncia:',chavedanfe) then
     begin
     achavenfe:= '';
  DmAcbr.ACBrNFe1.NotasFiscais.Clear;
  DmAcbr.ACBrNFe1.WebServices.Consulta.NFeChave := chavedanfe;
  DmAcbr.ACBrNFe1.WebServices.Consulta.Executar;
  aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Consulta.protNFe.chNFe;
  //  aProcolo  := DmAcbr.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
//  Memoxml.Lines.Text := DmAcbr.ACBrNFe1.WebServices.Consulta.RetWS;
//  EdtDados.Text := DmAcbr.ACBrNFe1.WebServices.Consulta.RetornoWS;
//  LoadXML(DmAcbr.ACBrNFe1.WebServices.Consulta.RetornoWS, WBResposta);
//  LoadConsulta201(DmAcbr.ACBrNFe1.WebServices.Consulta.RetWS);

  if aChaveNfe = '' then
  begin
     ShowMessage('Chave inexistente na Sefaz');
  end
  else
  begin
with DmAcbr.ACBrNFe1.NotasFiscais.Add.NFe.Ide.NFref.Add do
begin
   { NF-e }
   refNFe := chavedanfe;
end;
  end;

//     FrmNfeReferencia.chave:= CdsNFeChave_Nfe.AsString;
//     FrmNfeReferencia.ShowModal;
      end;
  end
  else
     ShowMessage('� necess�rio validar a Chave NFe');
end;

procedure TFrmGeraNFe.BitBtn9Click(Sender: TObject);
begin
  inherited;
//fabricio - inicio incluir botao grava
        SqlQuery1.Close;
        SqlQuery1.SQL.Clear;
        SqlQuery1.SQL.Add('update NFE_NUMERO set');
        SqlQuery1.SQL.Add('NUMERO_DOC = ' + Edit1.Text);
        SqlQuery1.SQL.Add('where IDEMPRESA = ' + DmWorkCom.CdsEmpresaID.AsString);
        if radiomodelo.ItemIndex = 0 then
           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('55'))
        else
           SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr('65'));
//        SqlQuery1.SQL.Add('and MODELO = ' + QuotedStr(Edit2.Text));
        SqlQuery1.SQL.Add('and AMBIENTE = ' + IntToStr(DmWorkCom.sAmbiente + 1));
        SqlQuery1.ExecSQL(false);


//fabricio fim
end;

procedure TFrmGeraNFe.EdtJustificaKeyPress(Sender: TObject; var Key: Char);
var aCNPJ : String;
    formMensagem: TFormMensagem;
begin
  inherited;
  if Key = #27 then
  begin
    PnJustifica.Visible := false;
  end;
  if Key = #13 then
  begin
    if EdtJustifica.Text <> '' then
    begin
      try
        formMensagem := TFormMensagem.Create('Aguarde... cancelando a NFe!',550,150,clBlack,clSilver);
        formMensagem.mostrar;
        Refresh;
        //
        aCNPJ := copy(CdsNFeCHAVE_NFE.AsString,7,14);
        with DmAcBr.ACBrNFe1.EventoNFe.Evento.Add do
        begin
          infEvento.chNFe           := CdsNFeCHAVE_NFE.AsString;
          infEvento.CNPJ            := aCNPJ;
          infEvento.dhEvento        := now;
          infEvento.tpEvento        := teCancelamento;
          infEvento.detEvento.xJust := EdtJustifica.Text;
          infEvento.detEvento.nProt := CdsNFePROTOCOLO_NFE.AsString;
        end;
        DmAcBr.ACBrNFe1.EnviarEvento(StrToInt(CdsNFeNUM_LOTE.AsString));
        PnJustifica.Visible := false;
        // grava NFe como cancelada
        if DmWorkCom.Dados_Pedido(CdsNFeID.AsInteger) then
        begin
          DmWorkCom.CdsPedidos.Edit;
          DmWorkCom.CdsPedidosSTATUS_NFE.AsString := IntToStr(DmAcBr.ACBrNFe1.WebServices.EnvEvento.cStat);
          DmWorkCom.CdsPedidosCANCELADO.AsString := 'S';
          Grava_Dados(DmWorkCom.CdsPedidos);
        end;
        // altera o status dos abastecimentos vinculados
        DmWorkCom.VerificaAlteraStatusAbastecimento(CdsNFe.FieldByName('ID').AsInteger,true);
        //
        FormMensagem.destruir;
        FreeAndNil(FormMensagem);
        MessageDlg('NFe cancelada com sucesso', mtInformation, [mbOK], 0);
        BtnLocalizarClick(Sender);
      except
        on E : Exception do
        begin
          FormMensagem.destruir;
          FreeAndNil(FormMensagem);
          ShowMessage(E.Message);
        end
      end;
    end
    else
    begin
      ShowMessage('� necess�rio informar a Justificativa!');
      EdtJustifica.SetFocus;
    end;
  end;

end;

procedure TFrmGeraNFe.CarregaDadosXML;
begin
  // carrega dados do XML no acbr caso tenha
  if CdsNFe.RecordCount > 0 then
  begin
    if CdsNFe.FieldByName('CHAVE_NFE').Text <> '' then
    begin
      DmAcbr.ACBrNFe1.NotasFiscais.Clear;
      if DmWorkCom.LocalizaXMLBanco(MemoXML,CdsNFeCHAVE_NFE.AsString) then
      begin
        DmAcbr.ACBrNFe1.NotasFiscais.Clear;
        DmAcbr.ACBrNFe1.NotasFiscais.LoadFromString(MemoXML.Text);
        if CdsNFe.FieldByName('ARQUIVO_XML').Text <> '' then
        begin
          // salva o arquivo caso o mesmo n�o exista
          if not FileExists(CdsNFe.FieldByName('ARQUIVO_XML').Text) then
          begin
             DmAcbr.ACBrNFe1.NotasFiscais.Items[0].GravarXML;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmGeraNFe.MemoXMLKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
     MemoXML.Visible := false;
end;

procedure TFrmGeraNFe.GridNFeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  try
    if CdsNFe.FieldByName('STATUS_NFE').AsString = '100' Then
    begin
      GridNFe.Canvas.Font.Color := clGreen;
    end
    else if CdsNFe.FieldByName('STATUS_NFE').AsString = '101' Then
    begin
      GridNFe.Canvas.Font.Color := clRed;
    end
    else if CdsNFe.FieldByName('STATUS_NFE').AsString = '128' Then
    begin
      GridNFe.Canvas.Font.Color := clRed;
    end
    else if CdsNFe.FieldByName('STATUS_NFE').AsString = '135' Then
    begin
      GridNFe.Canvas.Font.Color := clRed;
    end
    else
    begin
      GridNFe.Canvas.Font.Color := clBlack;
    end;
  finally
    GridNFe.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

end;

procedure TFrmGeraNFe.VerarquivoXML1Click(Sender: TObject);
begin
  inherited;
  if CdsNFe.RecordCount > 0 then
  begin
    if CdsNFe.FieldByName('CHAVE_NFE').Text <> '' then
    begin
      MemoXML.Visible := true;
      MemoXML.SetFocus;
    end;
  end;  

end;

procedure TFrmGeraNFe.EdtJustificaExit(Sender: TObject);
begin
  inherited;
  PnJustifica.Visible := false;

end;

function TFrmGeraNFe.TestaNotaJaEnviada: Boolean;
var formMensagem: TFormMensagem;
    aChaveNfe, aRecibo, aProcolo, aNomeArq, aStatus : String;
    aDtAutori, aHrAutori : TDateTime;
begin
  Result := false;
  if (CdsNFeCHAVE_NFE.AsString <> '') then
  begin
    try
      formMensagem := TFormMensagem.Create('Aguarde... Consultando a Chave da NFe!',550,150,clBlack,clSilver);
      formMensagem.mostrar;
      Refresh;
      //
      DmAcBr.ACBrNFe1.WebServices.Consulta.NFeChave := CdsNFeCHAVE_NFE.AsString;
      DmAcBr.ACBrNFe1.WebServices.Consulta.Executar;
      // captura os dados
      aChaveNfe := DmAcBr.ACBrNFe1.WebServices.Consulta.protNFe.chNFe;
      aProcolo  := DmAcBr.ACBrNFe1.WebServices.Consulta.protNFe.nProt;
      aRecibo   := CdsNFeRECIBO_NFE.AsString;
      aNomeArq  := CdsNFeARQUIVO_XML.AsString;
      aStatus   := IntToStr(DmAcBr.ACBrNFe1.WebServices.Consulta.protNFe.cStat);
      aDtAutori := CdsNFeDATA_AUTORIZA.AsDateTime;
      aHrAutori := CdsNFeHORA_AUTORIZA.AsDateTime;
      // grava chave NFe
      if aChaveNfe <> '' then
      begin
        DmWorkCom.GravaChaveNFEPedido(aChaveNfe,
                                      aProcolo,
                                      aRecibo,
                                      EdtNumLote.Text,
                                      aNomeArq,
                                      aStatus,
                                      DmWorkCom.sFormas,
                                      CdsNFeID.AsInteger,
                                      aDtAutori,
                                      aHrAutori);
      end;

      FormMensagem.destruir;
      FreeAndNil(FormMensagem);
    except
      on Exc: Exception do
      begin
        FormMensagem.destruir;
        FreeAndNil(FormMensagem);
        ShowMessage(Exc.Message);
      end;
    end;
  end;

end;

procedure TFrmGeraNFe.LiberaravalidaodaNFe1Click(Sender: TObject);
begin
  inherited;
  if CdsNFe.RecordCount > 0 then
  begin
    if CdsNFeCHAVE_NFE.AsString = '' then
    begin
      MessageDlg('N�o existe valida��o para a nota selecionada!',mtWarning,[mbOK],0);
      Exit;
    end;
    if Confirmacao('Confirma a retirada da valida��o da NFe?') then
    begin
      if DmAuxiliar.Dados_NFeXML(CdsNFeCHAVE_NFE.AsString) then
         DmAuxiliar.Exclui_NFeXML(CdsNFeCHAVE_NFE.AsString);
      DmWorkCom.GravaChaveNFEPedido('','','','','','',DmWorkCom.sFormas,CdsNFeID.AsInteger,now,now);
      CdsNFe.Refresh;
      // BtnLocalizarClick(Sender);
    end;
  end;

end;

procedure TFrmGeraNFe.ConsultareatualizardadosdaNFe1Click(Sender: TObject);
begin
  inherited;
  if CdsNFe.RecordCount > 0 then
  begin
    if CdsNFe.FieldByName('CHAVE_NFE').Text <> '' then
    begin
      try
//        CarregaDadosXML;
        // consulta a NFCe
        if not DmWorkCom.TestaNotaJaEnviada(CdsNFe.FieldByName('ID').AsInteger,
                                            CdsNFe.FieldByName('CHAVE_NFE').AsString) then
        begin
          MessageDlg('O Registro seleconado ainda n�o foi enviado ou n�o foi localizado na SEFAZ!',mtWarning,[mbOK],0);
          Exit;
        end;
      except
        on E:Exception do ShowMessage(E.message);
      end;
    end;
  end;
end;

procedure TFrmGeraNFe.CopiaChaveNFE1Click(Sender: TObject);
begin
  inherited;
      EdtDados.Text:= CdsNfe.FieldByName('CHAVE_NFE').AsString;
      EdtDados.CopyToClipboard;
      ClipBoard.AsText:= EdtDados.Text;
end;

end.

