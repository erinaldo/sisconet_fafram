unit uXML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Buttons, ExtCtrls, ComCtrls, ImgList, StdCtrls, pcnconversao, pcnconversaonfe,
  ToolWin, jpeg, ShellAPI, System.Actions, System.UITypes, System.ImageList, maskutils,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,  dateutils,
  uMensagem, Data.DB, Vcl.Samples.Spin, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, AcbrUtil, uLibrary,
  Vcl.DBCtrls;

type

  { Tfrmxml }

  Tfrmxml = class(TForm)
    edtERROR: TLabel;
    dscfg: TDataSource;
    dsres: TDataSource;
    dtsXml: TDataSource;
    ListBoxError: TListBox;
    PanelLeft: TPanel;
    PanelNbk: TPanel;
    StatusShow: TStatusBar;
    btnXMLsBaixados: TSpeedButton;
    btnManifestarNotas: TSpeedButton;
    btnAtualizarLista: TSpeedButton;
    btnConsultarSefaz: TSpeedButton;
    btnLimparBaseDados: TBitBtn;
    edtAutoExecute: TDBCheckBox;
    Label10: TLabel;
    edtAutoTimer: TDBEdit;
    Label8: TLabel;
    edtidDFeAutoInc: TDBEdit;
    Label3: TLabel;
    edtultNSU: TDBEdit;
    Notebook1: TNotebook;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    btnNFePesquisar: TButton;
    edtNumeroNFe: TSpinEdit;
    edtDataInicial: TDateTimePicker;
    edtDataFinal: TDateTimePicker;
    btnNFePreview: TButton;
    btnNFeImprimir: TButton;
    btnNFeGerarPDF: TButton;
    dtsxml2: TDataSource;
    AutoExec: TTimer;
    DataWork: TDataSource;
    DataCST: TDataSource;
    DataCFOP: TDataSource;
    DataFornecedor: TDataSource;
    DataItens: TDataSource;
    DataFormaPag: TDataSource;
    DataClassifica: TDataSource;
    DataCtaReceber: TDataSource;
    DataUF: TDataSource;
    BtnGravar: TBitBtn;
    procedure btnNFeImprimirClick(Sender: TObject);
    procedure btnNFePreviewClick(Sender: TObject);
    procedure btnNFePesquisarClick(Sender: TObject);
    procedure edtAutoExecuteChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnNFeGerarPDFClick(Sender: TObject);
    procedure btnConsultarSefazClick(Sender: TObject);
    procedure btnAtualizarListaClick(Sender: TObject);
    procedure btnManifestarNotasClick(Sender: TObject);
    procedure btnXMLsBaixadosClick(Sender: TObject);
    procedure btnLimparBaseDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AutoExecTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure dscfgStateChange(Sender: TObject);
  private
    FFileLog: String;
    procedure SetCertificadoAtivo;
    procedure SetErrorList(AMsn: String);
    procedure ImprimeDanfe;
    procedure ConfirmaCompraExecute;
  public
    procedure AutoExecuteProcessos;

    function GetPathXMLNFe(const ADataEmissao: TDateTime;
      const AChaveNFe: String): String;
    function GetPathPDFNFe(const ADataEmissao: TDateTime;
      const AChaveNFe: String): String;



  end;

var
  frmxml: Tfrmxml;

implementation

uses
  uDmAcbr, uDmWorkCom, uDmClientes, pcnRetDistDFeInt, pcnEnvEventoNFe, uFrmconfiguracoes,
  uFrmCadastroCliente, uFrmClientes, uFrmSelEndereco, uFrmContatosAdc,
  uFrmLoginUsuario, uFrmLancCompras, uDmProdutos, uFrmProdutos, uFrmCadProdutos;

{$R *.dfm}

{ Tfrmxml }

procedure Tfrmxml.ConfirmaCompraExecute;
var aValorConta:Double;
begin
  inherited;
  // verifica��es
  if VerificaMesFechado(DataWork.DataSet.FieldByName('DATA_COMPRA').AsDateTime) then
  begin
    MessageDlg('N�o � permitido movimenta��o para o mes fechado!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (DataWork.DataSet.FieldByName('CANCELADO').AsString = 'S') then
  begin
    MessageDlg('Este Lan�amento j� se encontra cancelado. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (DataWork.DataSet.FieldByName('CONFIRMADA').AsString = 'S') then
  begin
    MessageDlg('Este Lan�amento j� se encontra finalizado. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataItens.DataSet.RecordCount = 0 then
  begin
    MessageDlg('N�o � permitido finalizar o Lan�amento sem itens. Verifique!!!', mtWarning, [mbOK], 0);
    Abort;
  end;
  if DataWork.DataSet.FieldByName('VALOR_TOTAL').AsFloat <= 0 then
  begin
    MessageDlg('N�o � permitido finalizar o Lan�amentocom valores zerados ou negativos.', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (DataWork.DataSet.FieldByName('ID_CLASSIFICACAO').IsNull) or
     (DataWork.DataSet.FieldByName('ID_CLASSIFICACAO').AsString = '') then
  begin
    MessageDlg('� necess�rio selecionar a classifica��o do Lan�amento.', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (DataWork.DataSet.FieldByName('ID_FORMAPAG').IsNull) or
     (DataWork.DataSet.FieldByName('ID_FORMAPAG').AsString = '') then
  begin
    MessageDlg('� necess�rio selecionar a forma de pagamento do Lan�amento.', mtWarning, [mbOK], 0);
    Abort;
  end;
  if (DataWork.DataSet.FieldByName('IDFORNECEDOR').IsNull) or
     (DataWork.DataSet.FieldByName('IDFORNECEDOR').AsString = '') then
  begin
    MessageDlg('� necess�rio informar o cliente. Verifique', mtWarning, [mbOK], 0);
    Abort;
  end;
  //
  if MessageDlg('Confirma o fechamento do Lan�amento?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
  begin
    // grava fechamento no Compras
    if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
       DataWork.DataSet.Edit;
    DataWork.DataSet.FieldByName('CONFIRMADA').AsString := 'S';
    Grava_Dados(DataWork.DataSet);
    // baixa estoque
    if DataClassifica.DataSet.FieldByName('BAIXAR_ESTOQUE').AsString = 'S' then
    begin
      DmWorkCom.Movimenta_Estoque(1,DataItens.DataSet);
      // resolve pendencia de  combustivel
//      DmPosto.VerificaResolvePennciaEstoqueCombustivel(DataItens.DataSet);
    end;
    // gera formas de pagamento
    if DataFormaPag.DataSet.FieldByName('GERAR_CONTA').AsString = 'S' then
    begin
      aValorConta := DataWork.DataSet.FieldByName('VALOR_TOTAL').AsFloat/
                     DataFormaPag.DataSet.FieldByName('QUANT_PAGTOS').AsInteger;
      DmWorkCom.Gerar_Contas(1,
                             DataWork.DataSet.FieldByName('ID').AsInteger,
                             0,
                             DataWork.DataSet.FieldByName('IDFORNECEDOR').AsInteger,
                             DataFormaPag.DataSet.FieldByName('QUANT_PAGTOS').AsInteger,
                             DataFormaPag.DataSet.FieldByName('FORMA_PAGTO').AsString,
                             DataWork.DataSet.FieldByName('FORNECEDOR').AsString,
                             '',DataWork.DataSet.FieldByName('DATA_COMPRA').AsDateTime,
                             aValorConta);
    end;
    MessageDlg('Lan�amento fechado com sucesso!!!', mtWarning, [mbOK], 0);
    DmWorkCom.Dados_ContasPedido(DataWork.DataSet.FieldByName('ID').AsInteger,1);
  end;

end;

procedure Tfrmxml.dscfgStateChange(Sender: TObject);
begin
  BtnGravar.Enabled := dscfg.State in [dsInsert, dsEdit];
end;

function Tfrmxml.GetPathXMLNFe(const ADataEmissao: TDateTime; const AChaveNFe: String): String;
begin
  Result := PathWithDelim(DmAcbr.ACbrNFe1.Configuracoes.Arquivos.DownloadNFe.PathDownload) +
            PathWithDelim('Nfe') +
            PathWithDelim(FormatDateTime('YYYYMM', ADataEmissao)) +
            AChaveNFe + '-nfe.xml';
end;

function Tfrmxml.GetPathPDFNFe(const ADataEmissao: TDateTime; const AChaveNFe: String): String;
begin
  Result := PathWithDelim(DmAcbr.ACBrNFe1.DANFE.PathPDF) +
            PathWithDelim(FormatDateTime('YYYYMM', ADataEmissao)) +
            AChaveNFe + '-nfe.pdf';
end;



procedure Tfrmxml.btnNFeGerarPDFClick(Sender: TObject);
var
  sXmlPath: String;
  sPdfPath: String;
  sPathPdf: String;
begin
  DmWorkCom.xmlnfe.First;
  while not DmWorkCom.xmlnfe.EOF do
  begin
    sXmlPath := GetPathXMLNFe(DmWorkCom.xmlnfe.FieldByName('dhEmi').AsDateTime,
                              DmWorkCom.xmlnfe.FieldByName('chNFe').AsString);

    if FileExists(sXmlPath) then
    begin
      // Gera Danfe em PDF
      sPdfPath := GetPathPDFNFe(DmWorkCom.xmlnfe.FieldByName('dhEmi').AsDateTime,
                                DmWorkCom.xmlnfe.FieldByName('chNFe').AsString);

      if not FileExists(sPdfPath) then
      begin
        if FileExists(sXmlPath) then
        begin
          DmAcbr.ACBrNFe1.NotasFiscais.Clear;

          // Guarda o path atual dos PDFs
          sPathPdf := DmAcbr.ACBrNFe1.DANFE.PathPDF;
          try
            if DmAcbr.ACBrNFe1.NotasFiscais.LoadFromFile(sXmlPath) then
            begin
              // Adiciona ao path atual dos PDFs YYYYMM
              DmAcbr.ACBrNFe1.DANFE.PathPDF := PathWithDelim(sPathPdf) +
                                               PathWithDelim(FormatDateTime('YYYYMM', DmWorkCom.xmlnfe.FieldByName('dhEmi').AsDateTime));

              // Gera o PDF
              DmAcbr.ACBrNFe1.NotasFiscais.ImprimirPDF;
            end;
          finally
            // Retorna o path original dos PDFs
            DmAcbr.ACBrNFe1.DANFE.PathPDF := sPathPdf;
            DmAcbr.ACBrNFe1.NotasFiscais.Clear;
          end;
        end;
      end;
    end;

    DmWorkCom.xmlnfe.Next;
  end;
end;

procedure Tfrmxml.btnNFeImprimirClick(Sender: TObject);
begin
  DmAcbr.ACBrNFe1.DANFE.MostraPreview := False;

  // Imprime o Danfe
  ImprimeDanfe;
end;

procedure Tfrmxml.btnNFePreviewClick(Sender: TObject);
begin
  DmAcbr.ACBrNFe1.DANFE.MostraPreview := True;
  ImprimeDanfe;
end;

procedure Tfrmxml.btnNFePesquisarClick(Sender: TObject);
begin
  DmWorkCom.xmlnfe.Close;
  DmWorkCom.xmlnfe.Params.Clear;
  DmWorkCom.qxmlnfe.Close;
  DmWorkCom.qxmlnfe.SQL.Clear;
  DmWorkCom.qxmlnfe.SQL.Add
          ('select * from xmlnfe where NFe = '+QuotedStr('T'));
  DmWorkCom.qxmlnfe.SQL.Add
          ('and  IDEMPRESA = '+ DmWorkCom.XmlCfgIDDFE.AsString);
  DmWorkCom.qxmlnfe.SQL.Add
          (' and dhEmi >= (' + QuotedStr(FormatDateTime('YYYY/MM/DD', edtDataInicial.DateTime)) + ')');
  DmWorkCom.qxmlnfe.SQL.Add
          (' and dhEmi <= (' + QuotedStr(FormatDateTime('YYYY/MM/DD', edtDataFinal.DateTime)) + ')');

  DmWorkCom.xmlnfe.Open;
  SetErrorList(IntToStr(DmWorkCom.XmlNfe.RecordCount)+ ' notas encontradas !');
end;

procedure Tfrmxml.edtAutoExecuteChange(Sender: TObject);
begin
//  edtAutoTimer.Enabled := edtAutoExecute.Checked;
end;

procedure Tfrmxml.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DmWorkCom.AtualizaConfigAcBr;
end;

procedure Tfrmxml.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  ListBoxError.Items.SaveToFile(FFileLog);
end;

procedure Tfrmxml.FormCreate(Sender: TObject);
var aux : Integer;
    formMensagem: TFormMensagem;
//begin
{
  if not DmClientes.Dados_UsuariosItens(sNomeApp) then
  begin
  ShowMessage('Nao encontrou clientes');
//    DmClientes.Grava_ItemsMenu(MainMenu1);
  end;
  // verifica perfil
  if not DmClientes.Dados_Perfil then
  begin
    DmClientes.Adiciona_PerfilPadrao;
  end
  else sIDPerfil := DmClientes.CdsUsuariosPerfilID.AsInteger;
  // verifica permiss�es
  if not DmClientes.Dados_Permissoes(sIDPerfil,sNomeApp) then
  begin
    // adciona permissoes
    DmClientes.Insere_PermissoesPerfil(sIDPerfil);
  end;
  // verifica usu�rios
  if not DmClientes.Dados_Usuarios then
  begin
    DmClientes.Adciona_UsuarioPadrao;
  end;
  // verifica tabela de UF
  if not DmClientes.dados_uf then
  begin
    // gera tabela de estados
    DmClientes.Gera_UF(['AM','AC','RR','RD','RN','RS','GO','MG','RJ','SP','ES','BA','CE','MT',
                         'AP','MS','TO','SE','PE','MA','PI','PR','PA','DF','AL','PB','SC']);
  end;


  // verifica dados da empresa
  sIDEmpresa := 1;
//  if not DmWorkCom.Dados_Empresa(sIDEmpresa) then
  if not DmWorkCom.Dados_Empresa then
  begin
    try
      Application.CreateForm(TFrmConfiguracoes,FrmConfiguracoes);
      // insere empresa padr�o
      DmWorkCom.CdsEmpresa.Append;
      Grava_Dados(DmWorkCom.CdsEmpresa);
      // insere configura��o da empresa padr�o
      DmWorkCom.CdsConfig.Append;
      Grava_Dados(DmWorkCom.CdsConfig);
      FrmConfiguracoes.sControle := 0;
      FrmConfiguracoes.ShowModal;
    finally
      FrmConfiguracoes.Destroy;
      MessageDlg('O aplicativo ser� reiniciado!!!', mtWarning, [mbOK], 0);
      Application.Terminate;
    end;
  end
  else

  begin
}
begin
  sIDEmpresa := 1;
//  if not DmWorkCom.Dados_Empresa(sIDEmpresa) then
  if not DmWorkCom.Dados_Empresa then
  begin
    try
      Application.CreateForm(TFrmConfiguracoes,FrmConfiguracoes);
      // insere empresa padr�o
      DmWorkCom.CdsEmpresa.Append;
      Grava_Dados(DmWorkCom.CdsEmpresa);
      // insere configura��o da empresa padr�o
      DmWorkCom.CdsConfig.Append;
      Grava_Dados(DmWorkCom.CdsConfig);
      FrmConfiguracoes.sControle := 0;
      FrmConfiguracoes.ShowModal;
    finally
      FrmConfiguracoes.Destroy;
      MessageDlg('O aplicativo ser� reiniciado!!!', mtWarning, [mbOK], 0);
      Application.Terminate;
    end;
  end;





    // login do usuario
    Application.CreateForm(TFrmLoginUsuario,FrmLoginUsuario);
    try
      FrmLoginUsuario.sOK := false;
      FrmLoginUsuario.ShowModal;
      if not FrmLoginUsuario.sOK then
         Application.Terminate
      else
      begin
//        StatusBar1.Panels.Items[2].Text := DmClientes.CdsUsuariosUSUARIO.AsString;
        // verifica permiss�es
        if not DmClientes.Dados_Permissoes(sIDPerfil,sNomeApp) then
        begin
          // adciona permissoes
          DmClientes.Insere_PermissoesPerfil(sIDPerfil);
        end;

      end;
    finally
      FrmLoginUsuario.Destroy
    end;
    // carrega dados do sistema
    DmWorkCom.Dados_Empresa(sIDEmpresa);
//    StatusBar1.Panels.Items[3].Text := DmWorkCom.CdsEmpresaRAZAO_SOCIAL.AsString;
    DmWorkCom.CarregaDadosEmpresa;
    // verifica agenda de compromissos
    aux := RetornaCompromissosDias(sDiasAgenda);
    if aux > 0 then
    begin
      MessageDlg('H� '+IntToStr(aux)+' compromissos agendados para os proximos '+IntToStr(sDiasAgenda)+' dias!', mtInformation, [mbOK], 0);
    end;
  end;


//end;

procedure Tfrmxml.FormShow(Sender: TObject);
var
  sDirEXE: String;
  sdirNFe: String;

begin

  DataWork.DataSet      := DmWorkCom.CdsCompras;
  DataItens.DataSet      := DmWorkCom.CdsComprasItens;
  DataFornecedor.DataSet := DmClientes.CdsContatos;
  DataFormaPag.DataSet   := DmWorkCom.CdsFormaPag;
  DataClassifica.DataSet := DmWorkCom.CdsPedidoClass;
  DataCtaReceber.DataSet := DmWorkCom.CdsContasAux;
  DataUF.DataSet         := DmClientes.CdsUF;
  DataCST.DataSet        := DmWorkCom.CdsCST;
  DataCFOP.DataSet       := DmWorkCom.CdsCFOP;
  DmWorkCom.Dados_Compras(0);
  DmWorkCom.Dados_PedidoClassificacao(0);
  DmWorkCom.Dados_FormaPagto;
  DmClientes.Dados_Funcionario;
  DmClientes.Dados_Contato(0);
  DmWorkCom.Dados_ComprasItens(0);
  DmWorkCom.Dados_ContasPedido(0,1);
  DmWorkCom.Dados_CST;
  DmWorkCom.Dados_CFOP;
  DataUF.DataSet.Open;



//  DmWorkCom.PAFECF.LeArquivoINI;
  FFileLog := '.\Log\log-' + FormatDateTime('DDMMYYYY', Date) + '.txt';
  Notebook1.PageIndex := 0;

  if not DirectoryExists('.\Log') then
    ForceDirectories('.\Log');

  // Se o log do dia j� foi criado � carregado para a lista visual
  if FileExists(FFileLog) then
    ListBoxError.Items.LoadFromFile(FFileLog);

  // Seta informa��es do certificado na barra e status

  DmWorkCom.AtualizaConfigAcBr;
  sDirEXE := ExtractFilePath(Application.ExeName);
  sdirNFe  := IncludeTrailingPathDelimiter(sDirEXE + 'Documentos');

  // diretorios
//  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathSchemas := sDirEXE + 'Schemas\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathEvento  := sdirNFe + 'Eventos\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathInu     := sdirNFe + 'Inu\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathNFe     := sdirNFe + 'NFe\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathSalvar  := sdirNFe + 'Salvar\';

  // diretorio de padfs
  DmAcbr.ACbrNFe1.DANFE.PathPDF := sdirNFe + 'PDF';

  // arquivos baixados
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.DownloadNFe.PathDownload := sdirNFe + 'Download\';

  SetCertificadoAtivo;

  DmWorkCom.Xmlcfg.Close;
  DmWorkCom.Xmlcfg.Params.Clear;
  DmWorkCom.qxmlcfg.Close;
  DmWorkCom.qxmlcfg.SQL.Clear;
  DmWorkCom.qxmlcfg.SQL.Add
  ('select * from xmlcfg where idDFe = ' + DmWorkCom.CdsConfigID_EMPRESA.AsString);
  DmWorkCom.xmlcfg.Open;
  if DmWorkCom.XmlCfg.RecordCount = 0 then
  begin
     DmWorkCom.XmlCfg.Append;
     DmWorkCom.XmlCfg.Post;

  DmWorkCom.Xmlcfg.Close;
  DmWorkCom.qxmlcfg.Close;
  DmWorkCom.qxmlcfg.SQL.Clear;
  DmWorkCom.qxmlcfg.SQL.Add
  ('select * from xmlcfg where idDFe = ' + DmWorkCom.CdsConfigID_EMPRESA.AsString);
  DmWorkCom.xmlcfg.Open;
  if DmWorkCom.XmlCfg.RecordCount = 0 then
     SetErrorList('Nao encontrou iddfe')
  else
     DmWorkCom.XmlCfg.First;
  end;





  EdtDataInicial.DateTime:=now;
  EdtDataFinal.DateTime:=now;
//  dbgrid2.SetFocus;

  AutoExec.Enabled  := Boolean(DmWorkCom.xmlcfg.FieldByName('AutoExecute').AsInteger);
  AutoExec.Interval := DmWorkCom.xmlcfg.FieldByName('AutoTimer').AsInteger * 60000;


end;

procedure Tfrmxml.SetCertificadoAtivo;
begin
  try
    if (DmAcbr.ACBrNFe1.Configuracoes.Certificados.NumeroSerie <> '') or
       (DmAcbr.ACBrNFe1.Configuracoes.Certificados.ArquivoPFX <> '')
    then
    begin
      StatusShow.Panels[3].Text := DmAcbr.ACBrNFe1.SSL.CertRazaoSocial;
      StatusShow.Panels[5].Text := FormatMaskText('99.999.999/9999-99;0; ', DmAcbr.ACBrNFe1.SSL.CertCNPJ);
      StatusShow.Panels[7].Text := FormatDateTime('DD/MM/YYYY', DmAcbr.ACBrNFe1.SSL.CertDataVenc);
    end;
  except
    on E: Exception do
    begin
      SetErrorList(E.Message);
    end;
  end;
end;

procedure Tfrmxml.SetErrorList(AMsn: String);
begin
  ListBoxError.Items.Add(DateTimeToStr(Now) + ' - ' + Trim(AMsn));
end;

procedure Tfrmxml.btnXMLsBaixadosClick(Sender: TObject);
begin
  Notebook1.PageIndex := 1;

  edtNumeroNFe.SetFocus;
  edtDataInicial.Date := StartOfTheMonth(Date);
  edtDataFinal.Date   := EndOfTheMonth(Date);

  DmWorkCom.xmlnfe.Close;
  DmWorkCom.xmlnfe.Params.Clear;
  DmWorkCom.qxmlnfe.Close;
  DmWorkCom.qxmlnfe.SQL.Clear;
  DmWorkCom.qxmlnfe.SQL.Add
          ('select * from xmlnfe where NFe = '+QuotedStr('T'));
  DmWorkCom.qxmlnfe.SQL.Add
          ('and  IDEMPRESA = '+ DmWorkCom.XmlCfgIDDFE.AsString);
  DmWorkCom.qxmlnfe.SQL.Add
          (' and dhEmi >= (' + QuotedStr(FormatDateTime('YYYY/MM/DD', edtDataInicial.DateTime)) + ')');
  DmWorkCom.qxmlnfe.SQL.Add
          (' and dhEmi <= (' + QuotedStr(FormatDateTime('YYYY/MM/DD', edtDataFinal.DateTime)) + ')');
  DmWorkCom.xmlnfe.Open;

end;

procedure Tfrmxml.btnManifestarNotasClick(Sender: TObject);
var
  Evento: TInfEventoCollectionItem;
  contador: integer;
begin
  Notebook1.PageIndex := 0;
  contador:=0;
  if DmWorkCom.xmldfe.Active then
  begin
    DmWorkCom.xmldfe.DisableControls;
    DmWorkCom.xmldfe.First;
    try
      while not DmWorkCom.xmldfe.EOF do
      begin
        if (DmWorkCom.xmldfe.FieldByName('DFe').AsString = 'F') and
//fabricio incluir esta linha abaixo
//           (DmWorkCom.xmldfe.FieldByName('tpNF').AsInteger = 0) and
           (DmWorkCom.xmldfe.FieldByName('NFe').AsString = 'F') then
              begin
                if confirmacao('Encontrada a chave '+DmWorkCom.xmldfe.FieldByName('chNFe').AsString+', do Fornecedor '+DmWorkCom.xmldfe.FieldByName('XNOME').AsString+ ' do dia '+DmWorkCom.xmldfe.FieldByName('DHEMI').AsString+ ' sem manifestar, deseja manifestar a nota?') then
                begin


                      DmAcbr.ACBrNFe1.EventoNFe.Evento.Clear;
                      Evento := DmAcbr.ACBrNFe1.EventoNFe.Evento.Add;
                      Evento.infEvento.cOrgao   := 91;
                      Evento.infEvento.chNFe    := DmWorkCom.xmldfe.FieldByName('chNFe').AsString;
                      Evento.infEvento.CNPJ     := DmAcbr.ACBrNFe1.SSL.CertCNPJ; // CNPJ;
                      Evento.infEvento.dhEvento := Now;
                      Evento.infEvento.tpEvento := teManifDestConfirmacao;

                      // Manifesta e muda a tag do banco informando que foi manisfestada
                      try
                        if DmAcbr.ACBrNFe1.EnviarEvento(DmWorkCom.xmldfe.FieldByName('idDFe').AsInteger) then
                        begin
                             DmWorkCom.xmldfe.edit;
                             DmWorkCom.xmldfe.FieldByName('DFE').AsString:= 'T';
                             Dmworkcom.xmldfe.Post;
                        contador:= contador + 1;
                        end
                        else
                        begin
                          SetErrorList(Format(
                            'Erro ao manifestar a nota: %s, %d - %s', [
                            DmWorkCom.xmldfe.FieldByName('chNFe').AsString,
                            DmAcbr.ACBrNFe1.WebServices.EnvEvento.cStat,
                            DmAcbr.ACBrNFe1.WebServices.EnvEvento.xMotivo
                          ]));
                        end;
                      except
                        on E: Exception do
                        begin
                          SetErrorList(E.Message);
                        end;
                      end;
                end;
              end;

        DmWorkCom.xmldfe.Next;
        Application.ProcessMessages;
      end;
    finally
      DmAcbr.ACBrNFe1.EventoNFe.Evento.Clear;
      DmWorkCom.xmldfe.First;
      DmWorkCom.xmldfe.EnableControls;
    end;
  end;
  SetErrorList(IntToStr(contador)+ ' nota(s) manifestada(s) no sistema !');
end;

procedure Tfrmxml.btnAtualizarListaClick(Sender: TObject);
var

  sDirEXE: String;
  sdirNFe: String;
  aCST, aArquivoXML : String;
  i, n, cont : Integer;
  cadastranfe, aCadProduto : Boolean;

  sXmlPath: String;
  sPdfPath: String;
  sPathPdf: String;
  sFileNew: string;

begin
  Notebook1.PageIndex := 0;

  DmWorkCom.xmldfe.Close;
  DmWorkCom.xmldfe.Params.Clear;
  DmWorkCom.qxmldfe.Close;
  DmWorkCom.qxmldfe.SQL.Clear;
  DmWorkCom.qxmldfe.SQL.Add
          ('select * from xmlnfe where NFe = '+QuotedStr('F'));
  DmWorkCom.qxmldfe.SQL.Add
          ('and  IDEMPRESA = '+ DmWorkCom.XmlCfgIDDFE.AsString);

  DmWorkCom.xmldfe.Open;

  SetErrorList(IntToStr(DmWorkCom.XmlDfe.RecordCount)+ ' notas atualizadas!');
  DmWorkCom.xmldfe.DisableControls;
  DmWorkCom.xmldfe.First;
  try
    while not DmWorkCom.xmldfe.EOF do
    begin
      // Checa se o arquivo xml da chave manisfestada, j� foi baixada
      // caso exista, muda a tag do banco informando que o xml j� est� na pasta.
      sXmlPath := GetPathXMLNFe(DmWorkCom.xmldfe.FieldByName('dhEmi').AsDateTime,
                                       DmWorkCom.xmldfe.FieldByName('chNFe').AsString);

      if FileExists(sXmlPath) then
      begin
        DmAcbr.ACBrNFe1.NotasFiscais.Clear;
        try
          DmAcbr.ACBrNFe1.NotasFiscais.LoadFromFile(sXmlPath);
          if DmAcbr.ACBrNFe1.SSL.CertCNPJ <> DmAcbr.ACBrNFe1.NotasFiscais[0].NFe.Dest.CNPJCPF then
          begin
            sFileNew := Copy(sXmlPath, 1, Length(sXmlPath) - 4) + '-transp.xml';
            RenameFile(sXmlPath, sFileNew);
          end;
        finally
          DmAcbr.ACBrNFe1.NotasFiscais.Clear;
        end;

        // S� muda o status se ainda for "F" de False
        if DmWorkCom.xmldfe.FieldByName('NFe').AsString = 'F' then
        begin
                 DmWorkCom.xmldfe.edit;
                 DmWorkCom.xmldfe.FieldByName('NFE').AsString:= 'T';
                 DmWorkCom.xmldfe.FieldByName('DFE').AsString:= 'T';
                 Dmworkcom.xmldfe.Post;
        end;
      end;

      // Gera Danfe em PDF
      sPdfPath := GetPathPDFNFe(DmWorkCom.xmldfe.FieldByName('dhEmi').AsDateTime,
                                       DmWorkCom.xmldfe.FieldByName('chNFe').AsString);

      if not FileExists(sPdfPath) then
      begin
        if FileExists(sXmlPath) then
        begin
          DmAcbr.ACBrNFe1.NotasFiscais.Clear;

          // Guarda o path atual dos PDFs
          sPathPdf := DmAcbr.ACBrNFe1.DANFE.PathPDF;
          try
            if DmAcbr.ACBrNFe1.NotasFiscais.LoadFromFile(sXmlPath) then
            begin
              DmAcbr.ACBrNFe1.DANFE.PathPDF := PathWithDelim(sPathPdf) +
                                               PathWithDelim(FormatDateTime('YYYYMM', DmWorkCom.xmldfe.FieldByName('dhEmi').AsDateTime));

              DmAcbr.ACBrNFe1.NotasFiscais.ImprimirPDF;
            end;
          finally
            // Retorna o path original dos PDFs
            DmAcbr.ACBrNFe1.DANFE.PathPDF := sPathPdf;
            DmAcbr.ACBrNFe1.NotasFiscais.Clear;
          end;
        end;
      end;

      DmWorkCom.xmldfe.Next;
    end;
  finally
    DmWorkCom.xmldfe.First;
    DmWorkCom.xmldfe.EnableControls;
  end;

//fabricio ------------------------------------------incluido

  sDirEXE := ExtractFilePath(Application.ExeName);
  sdirNFe  := IncludeTrailingPathDelimiter(sDirEXE + 'Documentos');
  DmWorkCom.AtualizaConfigAcBr;
  sDirEXE := ExtractFilePath(Application.ExeName);
  sdirNFe  := IncludeTrailingPathDelimiter(sDirEXE + 'Documentos');

  // diretorios
//  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathSchemas := sDirEXE + 'Schemas\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathEvento  := sdirNFe + 'Eventos\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathInu     := sdirNFe + 'Inu\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathNFe     := sdirNFe + 'NFe\';
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.PathSalvar  := sdirNFe + 'Salvar\';

  // diretorio de padfs
  DmAcbr.ACbrNFe1.DANFE.PathPDF := sdirNFe + 'PDF';

  // arquivos baixados
  DmAcbr.ACbrNFe1.Configuracoes.Arquivos.DownloadNFe.PathDownload := sdirNFe + 'Download\';

/////////////////////////////////////////////////////////////////////////////////////////////////
  // realiza a importa��o do arquivo XML da NFe

  DmWorkCom.xmldfe.Close;
  DmWorkCom.xmldfe.Params.Clear;
  DmWorkCom.qxmldfe.Close;
  DmWorkCom.qxmldfe.SQL.Clear;
  DmWorkCom.qxmldfe.SQL.Add
          ('select * from xmlnfe ');
  DmWorkCom.qxmldfe.SQL.Add
          ('where  IDEMPRESA = '+ DmWorkCom.CdsEmpresaID.AsString);

  DmWorkCom.xmldfe.Open;
  SetErrorList(IntToStr(DmWorkCom.XmlDfe.RecordCount)+ ' notas encontradas!');
  cont:=0;
  DmWorkCom.xmldfe.DisableControls;
  DmWorkCom.xmldfe.First;

  try
    while not DmWorkCom.xmldfe.EOF do
    begin
      // Checa se o arquivo xml da chave manisfestada, j� foi baixada
      // caso exista, muda a tag do banco informando que o xml j� est� na pasta.
      cadastranfe:= false;
      sXmlPath := GetPathXMLNFe(DmWorkCom.xmldfe.FieldByName('dhEmi').AsDateTime,
                                       DmWorkCom.xmldfe.FieldByName('chNFe').AsString);

      if FileExists(sXmlPath) then
      begin
        DmAcbr.ACBrNFe1.NotasFiscais.Clear;
        try
          DmAcbr.ACBrNFe1.NotasFiscais.LoadFromFile(sXmlPath);
////////////////////////////////////////////////////////////////////    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                          for n:=0 to DmAcBr.ACBrNFe1.NotasFiscais.Count-1 do
                          begin
                            with DmAcBr.ACBrNFe1.NotasFiscais.Items[n].NFe do
                            begin
                              // verifica Chave NFe
                             if not DmWorkCom.VerificaExisteNFeChave(infNFe.ID) then
                             begin
                              // prepara registro
                               if confirmacao('Encontrada a chave '+infNFe.ID+', do Fornecedor '+Emit.xNome+ ' do dia '+FormatDateTime('DD/MM/YYYY', DmAcBr.ACBrNFe1.NotasFiscais.Items[n].NFe.Ide.dEmi)+ ' sem dar entrada, deseja lan�ar a nota?') then
                               begin

                                      cadastranfe:=true;
                                      cont:=cont+1;
                                      if DataWork.DataSet.RecordCount > 0 then
                                      begin
                                        MessageDlg('Existe um registro aberto. Este ser� salvo para inclus�o de um novo', mtWarning, [mbOK], 0);
                                        if DataWork.DataSet.State in [dsInsert,dsEdit] then
                                           Grava_Dados(DataWork.DataSet);
                                        DmWorkCom.Dados_Compras(0);
                                        DmWorkCom.Dados_ComprasItens(0);
                                      end;
//tirei                                      ActIncluirExecute(Sender);
                                      // verifica se existe o fornecedor no cadastro
                                      if not DmClientes.Dados_ContatoCNPJ(FiltraNumero(Emit.CNPJCPF)) then
                                      begin
                                        // Cadastra o Fornecedor
                                        Application.CreateForm(TFrmCadastroCliente,FrmCadastroCliente);
                                        Application.CreateForm(TFrmClientes,FrmClientes);
                                        Application.CreateForm(TFrmSelEndereco,FrmSelEndereco);
                                        Application.CreateForm(TFrmContatosADC,FrmContatosADC);
                                        try
                                          FrmCadastroCliente.sIDCliente   := 0;
                                          FrmCadastroCliente.sCadNFe      := True;
                                          FrmCadastroCliente.xCNPJ_CPF    := Emit.CNPJCPF;
                                          FrmCadastroCliente.xINSC_RG     := Emit.IE;
                                          FrmCadastroCliente.xNOME        := Emit.xNome;
                                          FrmCadastroCliente.xENDERECO    := Emit.EnderEmit.xLgr;
                                          FrmCadastroCliente.xNUM_END     := Emit.EnderEmit.nro;
                                          FrmCadastroCliente.xBAIRRO_END  := Emit.EnderEmit.xBairro;
                                          FrmCadastroCliente.xCOMPLEMENTO := Emit.EnderEmit.xCpl;
                                          FrmCadastroCliente.xCODCIDADE   := IntToStr(Emit.EnderEmit.cMun);
                                          FrmCadastroCliente.xCIDADE_END  := Emit.EnderEmit.xMun;
                                          FrmCadastroCliente.xUF_END      := Emit.EnderEmit.UF;
                                          FrmCadastroCliente.xCEP_END     := IntToStr(Emit.EnderEmit.CEP);
                                          FrmCadastroCliente.xTELEFONE    := Emit.EnderEmit.fone;
                                          FrmCadastroCliente.ShowModal;
                                          if FrmCadastroCliente.sIDCliente > 0 then
                                          begin
                                            if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
                                               DataWork.DataSet.Edit;
                                            DataWork.DataSet.FieldByName('IDFORNECEDOR').AsInteger := FrmCadastroCliente.sIDCliente;
//tirei                                            DbIDFornecedorExit(Sender);
                                          end;
                                        finally
                                          FrmClientes.Destroy;
                                          FrmSelEndereco.Destroy;
                                          FrmContatosADC.Destroy;
                                          FrmCadastroCliente.Destroy;
                                        end;
                                      end
                                      else
                                      begin
                                        if not(DataWork.DataSet.State in [dsInsert,dsEdit]) then
                                           DataWork.DataSet.Edit;
                                        DataWork.DataSet.FieldByName('IDFORNECEDOR').AsInteger := DmClientes.CdsContatosID.AsInteger;
                                      end;

                              //fabricio inicio
                                      if DataWork.DataSet.FieldByName('IDFORNECEDOR').AsInteger < 1 then
                                      begin
                                         SetErrorList('Opera��o Cancelada');
                                         exit;
                                      end;
                              //fabricio fim


                                      //
                                      DmWorkCom.CdsComprasDATA_EMISSAO.AsDateTime := Ide.dEmi;
                                      DmWorkCom.CdsComprasDATA_COMPRA.AsDateTime  := Ide.dSaiEnt;
                                      DmWorkCom.CdsComprasNOTA.AsString           := IntToStrZero(Ide.nNF,6);
                                      DmWorkCom.CdsComprasCHAVE_NFE.AsString      := infNFe.ID;
                                      DmWorkCom.CdsComprasSTATUS_NFE.AsString     := IntToStr(procNFe.cStat);
                                      DmWorkCom.CdsComprasNATOP.AsString          := Ide.natOp;
                                      DmWorkCom.CdsComprasVALOR.AsFloat           := Total.ICMSTot.vNF;
                                      DmWorkCom.CdsComprasVALOR_FRETE.AsFloat     := Total.ICMSTot.vFrete;
                                      DmWorkCom.CdsComprasVALOR_PIS.AsFloat       := Total.ICMSTot.vPIS;
                                      DmWorkCom.CdsComprasVALOR_COFINS.AsFloat    := Total.ICMSTot.vCOFINS;
                                      DmWorkCom.CdsComprasVALOR_IPI.AsFloat       := Total.ICMSTot.vIPI;
                                      DmWorkCom.CdsComprasBASE_ICMS.AsFloat       := Total.ICMSTot.vBC;
                                      DmWorkCom.CdsComprasVALOR_ICMS.AsFloat      := Total.ICMSTot.vICMS;
                                      DmWorkCom.CdsComprasBASE_ICMS_ST.AsFloat    := Total.ICMSTot.vBCST;
                                      DmWorkCom.CdsComprasVALOR_ICMS_ST.AsFloat   := Total.ICMSTot.vST;
                                      DmWorkCom.CdsComprasDESCONTO.AsFloat        := Total.ICMSTot.vDesc;
                                      DmWorkCom.CdsComprasACRESCIMO.AsFloat       := 0;
                                      DmWorkCom.CdsComprasVALOR_OUTROS.AsFloat    := Total.ICMSTot.vOutro;
                                      DmWorkCom.CdsComprasOUTRAS_DESPESAS.AsFloat := 0;
                                      DmWorkCom.CdsComprasVALOR_TOTAL.AsFloat     := Total.ICMSTot.vNF;
                                      // transportadora

//fabricio inicio acbr
{
                                      if Transp.modFrete = mfContaEmitente then
                                         DmWorkCom.CdsComprasTIPO_FRETE.AsInteger := 0
                                      else if Transp.modFrete = mfContaDestinatario then
                                         DmWorkCom.CdsComprasTIPO_FRETE.AsInteger := 1
                                      else if Transp.modFrete = mfContaTerceiros then
                                         DmWorkCom.CdsComprasTIPO_FRETE.AsInteger := 2
                                      else if Transp.modFrete = mfSemFrete then
                                         DmWorkCom.CdsComprasTIPO_FRETE.AsInteger := 3;
}
 //fabricio fim acbr
                                      DmWorkCom.CdsComprasTIPO_FRETE.asstring := pcnConversaoNFe.modFreteToStr(Transp.modFrete);
                                      DmWorkCom.CdsComprasTRANSP_CNPJ_CPF.AsString    := Transp.Transporta.CNPJCPF;
                                      DmWorkCom.CdsComprasTRANSP_INSC_RG.AsString     := Transp.Transporta.IE;
                                      DmWorkCom.CdsComprasTRANSP_NOME.AsString        := Transp.Transporta.xNome;
                                      DmWorkCom.CdsComprasTRANSP_ENDERECO.AsString    := Transp.Transporta.xEnder;
                                      DmWorkCom.CdsComprasTRANSP_NUM_END.AsString     := FiltraNumero(Transp.Transporta.xEnder);
                                      DmWorkCom.CdsComprasTRANSP_BAIRRO_END.AsString  := '';
                                      DmWorkCom.CdsComprasTRANSP_COMPLEMENTO.AsString := '';
                                      DmWorkCom.CdsComprasTRANSP_CODCIDADE.AsString   := '';
                                      DmWorkCom.CdsComprasTRANSP_CIDADE_END.AsString  := Transp.Transporta.xMun;
                                      DmWorkCom.CdsComprasTRANSP_UF_END.AsString      := Transp.Transporta.UF;
                                      DmWorkCom.CdsComprasTRANSP_CEP_END.AsString     := '';
                                      DmWorkCom.CdsComprasTRANSP_TELEFONE.AsString    := '';
                                      //
                                      Grava_Dados(DataWork.DataSet);
                                      //itens da nota
                                      for I := 0 to Det.Count-1 do
                                      begin
                                        with Det.Items[I] do
                                        begin
                                          case Imposto.ICMS.CST of
                                            cst00: aCST := '000';
                                            cst10: aCST := '010';
                                            cst20: aCST := '020';
                                            cst30: aCST := '030';
                                            cst40: aCST := '040';
                                            cst41: aCST := '041';
                                            cst45: aCST := '045';
                                            cst50: aCST := '050';
                                            cst51: aCST := '051';
                                            cst60: aCST := '060';
                                            cst70: aCST := '070';
                                            cst80: aCST := '080';
                                            cst81: aCST := '081';
                                            cst90: aCST := '090';
                                          end;
                                          // localiza o produto no cadastro

                              //fabricio novo inicio
                                          aCadProduto := true;
                                          if prod.cEAN = '' then
                                          begin

                                            if Confirmacao('Produto sem C�digo de Barras, deseja localiza manualmente?') then
                                            begin
                                              Application.CreateForm(TFrmProdutos,FrmProdutos);
                                              FrmProdutos.sIDProd := 0;
                                              FrmProdutos.sApenasConsulta := true;
                                              FrmProdutos.EdtLocalizar.Text := Prod.xProd;
                                              FrmProdutos.ShowModal;
                                              if FrmProdutos.sIDProd > 0 then
                                              begin
                                                aCadProduto := false;
                                                DmProdutos.Dados_Produto(FrmProdutos.sIDProd);
                                              end
                                              else
                                              begin
                                              end;
                                             FreeAndNil(FrmProdutos);
                                            end;


                                          end
                                          else
                                          if DmProdutos.Dados_Produto(Prod.cEAN) then
                                          begin
                                             aCadProduto := false;
                                          end
                                          else
                                          if length(Prod.cEAN) > 9 then
                                          begin

                                          end
                                          else
                                          if not (DmProdutos.Dados_Produto(StrToInt(Prod.cEAN))) then
                                          begin
                                            if Confirmacao('Produto n�o localizado no cadastro deseja localiza manualmente?') then
                                            begin
                                              Application.CreateForm(TFrmProdutos,FrmProdutos);
                                              FrmProdutos.sIDProd := 0;
                                              FrmProdutos.sApenasConsulta := true;
                                              FrmProdutos.EdtLocalizar.Text := Prod.xProd;
                                              FrmProdutos.ShowModal;
                                              if FrmProdutos.sIDProd > 0 then
                                              begin
                                                aCadProduto := false;
                                                DmProdutos.Dados_Produto(FrmProdutos.sIDProd);
                                              end
                                              else
                                              begin
                                              end;
                                              FreeAndNil(FrmProdutos);
                                            end;
                                          end
                                          else
                                          begin
                                             if Dmprodutos.CdsProdutosDESCRICAO.AsString = Prod.xProd then
                                                aCadProduto := false
                                             else
                                                aCadProduto := true;
                              //fabricio novo fim
                                          end;
                                            // verifica se � para cadastrar
                                            if aCadProduto then
                                            begin
                                              if Confirmacao('Deseja cadastrar novo produto?') then
                                              begin
                                                Application.CreateForm(TFrmCadProdutos,FrmCadProdutos);
                                                try
                                                  FrmCadProdutos.sIDProduto       := 0;
                                                  FrmCadProdutos.sCadNFe          := True;
                                                  FrmCadProdutos.xDESCRICAO       := Prod.xProd;
                                                  FrmCadProdutos.xREFERENCIA      := Prod.cProd;

                                                  //fabricio ean13
                                                  FrmCadProdutos.xEAN13           := Prod.cEAN;
                                                  FrmCadProdutos.xUNIDADE         := Prod.uCom;
                                                  FrmCadProdutos.xCODIGO_NCM      := Prod.NCM;
                                                  FrmCadProdutos.xCST_INTERNO     := aCST;
                                                  FrmCadProdutos.xCFOP_INTERNO    := Prod.CFOP;
                                                  FrmCadProdutos.xALIQUOTA_ICMS   := Imposto.ICMS.pICMS;
                                                  FrmCadProdutos.xALIQUOTA_IPI    := Imposto.IPI.pIPI;
                                                  FrmCadProdutos.xPRECO_COMPRA    := Prod.vUnCom;
                                                  FrmCadProdutos.xREDUCAO_BASE    := Imposto.ICMS.pRedBC;
                                                  FrmCadProdutos.xMVA             := Imposto.ICMS.pMVAST;
                                                  FrmCadProdutos.xALIQUOTA_PIS    := Imposto.PIS.pPIS;
                                                  FrmCadProdutos.xALIQUOTA_COFINS := Imposto.COFINS.pCOFINS;
                                                  FrmCadProdutos.xUF_Fornec       := Emit.EnderEmit.UF;
                                                  FrmCadProdutos.xQuantCompra     := Prod.qCom;
                                                  FrmCadProdutos.ShowModal;
                                                  if FrmCadProdutos.sIDProduto > 0 then
                                                  begin
                                                    DmProdutos.Dados_Produto(FrmCadProdutos.sIDProduto);
                                                  end;
                                                finally
                                                  FreeAndNil(FrmCadProdutos);
                                                end;
                                              end;
                                            end;

                                          // registra o item caso o mesmo esteja cadastrado
                                          if DmProdutos.CdsProdutos.RecordCount > 0 then
                                          begin
                                            DmWorkCom.CdsComprasItens.Append;
                                            DmWorkCom.CdsComprasItensCST.AsString          := aCST;
                                            DmWorkCom.CdsComprasItensCFOP.AsString         := Prod.CFOP;
                                            DmWorkCom.CdsComprasItensIDPRODUTO.AsInteger   := DmProdutos.CdsProdutosID.AsInteger;
                                            DmWorkCom.CdsComprasItensDESCRICAO.AsString    := Prod.xProd;
                                            DmWorkCom.CdsComprasItensUNIDADE.AsString      := Prod.uCom;
                                            DmWorkCom.CdsComprasItensQUANTIDADE.AsFloat    := Prod.qCom;
                                            DmWorkCom.CdsComprasItensVALOR.AsFloat         := Prod.vUnCom;
                                            DmWorkCom.CdsComprasItensDESCONTO.AsFloat      := Prod.vDesc;
                                            DmWorkCom.CdsComprasItensACRESCIMO.AsFloat     := 0;
                                            DmWorkCom.CdsComprasItensVALOR_TOTAL.AsFloat   := (Prod.qCom*Prod.vUnCom)-Prod.vDesc;
                                            // ICMS
                                            DmWorkCom.CdsComprasItensCST.AsString          := CSTICMSToStr(Imposto.ICMS.CST);
                                            DmWorkCom.CdsComprasItensMVA.AsFloat           := Imposto.ICMS.pMVAST;
                                            DmWorkCom.CdsComprasItensREDUCAO_BASE.AsFloat  := Imposto.ICMS.pRedBC;
                                            DmWorkCom.CdsComprasItensBASE_ICMS.AsFloat     := Imposto.ICMS.vBC;
                                            DmWorkCom.CdsComprasItensALIQ_ICMS.AsFloat     := Imposto.ICMS.pICMS;
                                            DmWorkCom.CdsComprasItensVALOR_ICMS.AsFloat    := Imposto.ICMS.vICMS;
                                            DmWorkCom.CdsComprasItensBASE_ICMS_ST.AsFloat  := Imposto.ICMS.vBCST;
                                            DmWorkCom.CdsComprasItensALIQ_ICMS_ST.AsFloat  := Imposto.ICMS.pICMSST;
                                            DmWorkCom.CdsComprasItensVALOR_ICMS_ST.AsFloat := Imposto.ICMS.vICMSST;
                                            // PIS
                                            DmWorkCom.CdsComprasItensCST_PIS.AsString      := CSTPISToStr(Imposto.PIS.CST);
                                            DmWorkCom.CdsComprasItensBASE_PIS.AsFloat      := Imposto.PIS.vBC;
                                            DmWorkCom.CdsComprasItensALIQ_PIS.AsFloat      := Imposto.PIS.pPIS;
                                            DmWorkCom.CdsComprasItensVALOR_PIS.AsFloat     := Imposto.PIS.vPIS;
                                            // Cofins
                                            DmWorkCom.CdsComprasItensCST_COFINS.AsString   := CSTCOFINSToStr(Imposto.COFINS.CST);
                                            DmWorkCom.CdsComprasItensBASE_COFINS.AsFloat   := Imposto.COFINS.vBC;
                                            DmWorkCom.CdsComprasItensALIQ_COFINS.AsFloat   := Imposto.COFINS.pCOFINS;
                                            DmWorkCom.CdsComprasItensVALOR_COFINS.AsFloat  := Imposto.COFINS.vCOFINS;
                                            // IPI
                                            DmWorkCom.CdsComprasItensCST_IPI.AsString      := CSTIPIToStr(Imposto.IPI.CST);
                                            DmWorkCom.CdsComprasItensBASE_IPI.AsFloat      := Imposto.IPI.vBC;
                                            DmWorkCom.CdsComprasItensALIQ_IPI.AsFloat      := Imposto.IPI.pIPI;
                                            DmWorkCom.CdsComprasItensVALOR_IPI.AsFloat     := Imposto.IPI.vIPI;
                                            //
                                            Grava_Dados(DmWorkCom.CdsComprasItens);
                                          end
                                          else
                                          begin
                                            MessageDlg('O produto de codigo '+Prod.cEAN+' n�o foi lan�ado!', mtInformation, [mbOK], 0);
                                          end;
                                        end;
                                      end;

                               end;
                             end;

                            end;
                          if cadastranfe then
                             ConfirmaCompraExecute;
                          end;

////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\
        finally
          DmAcbr.ACBrNFe1.NotasFiscais.Clear;
        end;

      end;
      DmWorkCom.xmldfe.Next;
    end;
  finally
    DmWorkCom.xmldfe.First;
    DmWorkCom.xmldfe.EnableControls;
  end;

  SetErrorList(IntToStr(cont)+ ' notas lan�adas!');
    // grava os dados
  DmWorkCom.AtualizaConfigAcBr;

end;

procedure Tfrmxml.btnConsultarSefazClick(Sender: TObject);
var
  iFor,contador: Integer;
  TmpDataset: TDataSet;
  DocZipItem: TdocZipCollectionItem;
begin
  Notebook1.PageIndex := 0;
  contador:=0;
  // Consulta os xmls emitidos por fornecedores.
  DmWorkCom.xmlnfe.Close;
  try

    DmAcbr.ACBrNFe1.DistribuicaoDFe(
      DmAcbr.ACBrNFe1.Configuracoes.WebServices.UFCodigo,
      DmAcbr.ACBrNFe1.SSL.CertCNPJ,
      DmWorkCom.XmlCfg.FieldByName('ultNSU').AsString,
      ''
    );

    if DmAcbr.ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 138 then
    begin
      // Abre a tabela para adicionar os resumos encontrados no banco
      DmWorkCom.xmlres.Open;
      try
        for iFor := 0 to DmAcbr.ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Count - 1 do
        begin
          //rondado 2020 resNFe, chNFE para resDFE e chNFE
          if DmAcbr.ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[iFor].resDFe.chDFe <> '' then
          begin
            DocZipItem := DmAcbr.ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.docZip.Items[iFor];

            // S� grava NFe de entrada
            if 1 = 1 then //fabricio tirarDocZipItem.resNFe.tpNF = tnEntrada then
            begin
              // Pesquisa se o xml resumo j� foi adicionado no db, pela chave.
//fabricio tirei              DmWorkCom.conn.ExecSQL(
              DmWorkCom.XmlNfe.Close;
              DmWorkCom.qxmlNfe.Close;
              DmWorkCom.qxmlNfe.SQL.Clear;
              DmWorkCom.qxmlNfe.SQL.Add(
                'select idDFe from xmlnfe where chNFe in (' + QuotedStr(DocZipItem.resDFe.chDFe) + ')'              );
              DmWorkCom.XmlNfe.Open;
              try
                // Se n�o foi, adiciona.
                if DmWorkCom.XmlNfe.RecordCount = 0 then
                begin
                  contador:= contador + 1;
                  DmWorkCom.xmlres.Append;
                  DmWorkCom.xmlres.FieldByName('idDFe').AsInteger     := DmWorkCom.XmlCfg.FieldByName('idDFeAutoInc').AsInteger + 1;
                  DmWorkCom.xmlres.FieldByName('xNumeroNFe').AsString := Copy(DocZipItem.resDFe.chDFe, 26, 9);;
                  DmWorkCom.xmlres.FieldByName('xSerie').AsString     := Copy(DocZipItem.resDFe.chDFe, 21, 2);
                  DmWorkCom.xmlres.FieldByName('chNFe').AsString      := DocZipItem.resDFe.chDFe;
                  DmWorkCom.xmlres.FieldByName('CNPJCPF').AsString    := DocZipItem.resDFe.CNPJCPF;
                  DmWorkCom.xmlres.FieldByName('xNome').AsString      := DocZipItem.resDFe.xNome;
                  DmWorkCom.xmlres.FieldByName('IE').AsString         := DocZipItem.resDFe.IE;
                  DmWorkCom.xmlres.FieldByName('dhEmi').AsString      := FormatDateTime('DD/MM/YYYY', DocZipItem.resDFe.dhEmi);
                  DmWorkCom.xmlres.FieldByName('tpNF').AsInteger      := Integer(DocZipItem.resDFe.tpNF);
                  DmWorkCom.xmlres.FieldByName('vNF').AsFloat         := DocZipItem.resDFe.vNF;
                  DmWorkCom.xmlres.FieldByName('digVal').AsString     := DocZipItem.resDFe.digVal;
                  DmWorkCom.xmlres.FieldByName('dhRecbto').AsDateTime := DocZipItem.resDFe.dhRecbto;
                  DmWorkCom.xmlres.FieldByName('nProt').AsString      := DocZipItem.resDFe.nProt;
                  DmWorkCom.xmlres.FieldByName('cSitNFe').AsInteger   := Integer(DocZipItem.resDFe.cSitDFe);
                  DmWorkCom.xmlres.FieldByName('NSU').AsInteger       := StrToIntDef(DocZipItem.NSU, 0);
                  DmWorkCom.xmlres.FieldByName('NFe').AsString        := 'F';
                  DmWorkCom.xmlres.FieldByName('DFe').AsString        := 'F';
                  DmWorkCom.xmlres.Post;

//                  // Aplica e Comita
//                  DmWorkCom.xmlres.ApplyUpdates(0);
                end;
              finally
              end;

              // Atualiza contador autoinc para cada resumo recebido

              DmWorkCom.XmlCfg.Edit;
              dmworkcom.XmlCfgIDDFEAUTOINC.AsInteger:= DmWorkCom.XmlCfg.FieldByName('idDFeAutoInc').AsInteger + 1;
              Dmworkcom.XmlCfgULTNSU.AsInteger:= StrToIntDef(DocZipItem.NSU, 0);
              DmWorkCom.XmlCfg.Post;
            end;
          end;
        end;

        SetErrorList('Consulta terminada, '+IntToStr(contador)+ ' nota(s) inserida(s) no sistema !');
      finally
        DmWorkCom.xmlres.Close;
      end;
    end
    else
    if DmAcbr.ACBrNFe1.WebServices.DistribuicaoDFe.retDistDFeInt.cStat = 137 then
      SetErrorList('Nenhuma XML de NFe consultada!');
  except
    on E: Exception do
    begin
      SetErrorList(E.Message);
    end;
  end;
end;

procedure Tfrmxml.BtnGravarClick(Sender: TObject);
begin
  if DmWorkCom.XmlCfg.State in [dsInsert, dsEdit] then
  begin
    DmWorkCom.XmlCfg.Post;
    DmWorkCom.xmlcfg.ApplyUpdates(0);
  end;

  AutoExec.Enabled  := Boolean(DmWorkCom.xmlcfg.FieldByName('AutoExecute').AsInteger);
  AutoExec.Interval := DmWorkCom.xmlcfg.FieldByName('AutoTimer').AsInteger * 60000;

end;

procedure Tfrmxml.btnLimparBaseDadosClick(Sender: TObject);
begin
  if Application.MessageBox(
    'Deseja realmente apagar todas as notas fiscais?',
    'Apagar',
    MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2
  ) = ID_YES then
  begin
              DmWorkCom.XmlNfe.Close;
              DmWorkCom.XmlNfe.Params.Clear;
              DmWorkCom.qxmlNfe.Close;
              DmWorkCom.qxmlNfe.SQL.Clear;
              DmWorkCom.qxmlNfe.SQL.Add
              ('delete from xmlnfe');
    DmWorkCom.xmlnfe.Open;
  end;
end;

procedure Tfrmxml.ImprimeDanfe;
var
  sXmlPath: String;
begin
  sXmlPath := GetPathXMLNFe(DmWorkCom.xmlnfe.FieldByName('dhEmi').AsDateTime,
                                   DmWorkCom.xmlnfe.FieldByName('chNFe').AsString);

  if FileExists(sXmlPath) then
  begin
    DmAcbr.ACBrNFe1.NotasFiscais.Clear;
    try
      if DmAcbr.ACBrNFe1.NotasFiscais.LoadFromFile(sXmlPath) then
        DmAcbr.ACBrNFe1.NotasFiscais.Imprimir;
    finally
      DmAcbr.ACBrNFe1.NotasFiscais.Clear;
    end;
  end;
end;

procedure Tfrmxml.AutoExecTimer(Sender: TObject);
begin
autoexecuteProcessos;
end;

procedure Tfrmxml.AutoExecuteProcessos;
begin
  // Consultar SEFAZ
  btnConsultarSefazClick(btnConsultarSefaz);
  Application.ProcessMessages;

  // Atualizar Lista
  btnAtualizarListaClick(btnAtualizarLista);
  Application.ProcessMessages;

  // Executar Distribui��o
  btnManifestarNotasClick(btnManifestarNotas);
  Application.ProcessMessages;

end;

end.