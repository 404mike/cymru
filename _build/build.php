<?php

class Build {

  private $xmlFiles = [
    'anglesey_sir-fon.xml','blaenau-gwent.xml','bridgend.xml',
    'caerphilly.xml','cardiff.xml','carmarthenshire.xml',
    'ceredigion.xml','conwy.xml','denbighshire.xml',
    'flintshire.xml','glamorgan.xml','gwynedd.xml',
    'merthyr-tydfil.xml','monmouthshire.xml','neath-port-talbot.xml',
    'newport.xml','pembrokeshire.xml','powys.xml',
    'rhondda-cynon-taff.xml','swansea.xml','torfaen.xml','wrexham.xml'
  ];


  public function __construct()
  {
    $this->concatXMLFiles();

    $this->transformToJSON();

    $this->concatJSONFiles();
  }

  private function concatXMLFiles()
  {
    $xml = new DOMDocument;
    $xml->load('../xml/county.xml');

    $xsl = new DOMDocument;
    $xsl->load('concat.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    $data = $proc->transformToXML($xml);

    file_put_contents('../cymru.xml', $data);
  }


  private function transformToJSON()
  {
    foreach($this->xmlFiles as $file){
      $xml = new DOMDocument;
      $xml->load('../xml/'.$file);

      $xsl = new DOMDocument;
      $xsl->load('json.xsl');

      $proc = new XSLTProcessor;
      $proc->importStyleSheet($xsl);

      $data = $proc->transformToXML($xml);

      $xml = simplexml_load_string($data);

      $json = json_encode($xml , JSON_PRETTY_PRINT);

      $filename = str_replace('.xml', '.json', $file);

      file_put_contents('../json/'.$filename, $json);      
    }
  }

  private function concatJSONFiles()
  {
    $xml = new DOMDocument;
    $xml->load('../cymru.xml');

    $xsl = new DOMDocument;
    $xsl->load('mainXMLtoJSON.xsl');

    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);

    $data = $proc->transformToXML($xml);

    $xml = simplexml_load_string($data, 'SimpleXMLElement', LIBXML_COMPACT | LIBXML_PARSEHUGE);

    $json = json_encode($xml , JSON_PRETTY_PRINT);

    file_put_contents('../cymru.json', $json); 
  }

}

new Build();