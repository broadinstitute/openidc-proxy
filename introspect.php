<?php

$request_method = strtoupper(getenv('REQUEST_METHOD'));
if ($request_method != 'POST') {
  die('only POST supported');
}
$access_token = $_POST['token'];

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://www.googleapis.com/oauth2/v3/tokeninfo',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'access_token='.$access_token.'&token_type_hint=access_token',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded'
  ),
));

$response = curl_exec($curl);

$info = curl_getinfo($curl);

curl_close($curl);

header('Content-Type: application/json; charset=utf-8');
if($info['http_code'] != 200) {
  $val = array(
    'active' => false
  );

  print(json_encode($val));
} else {

  $responseJson = json_decode($response, true);

  $val = array(
    'active' => true,
    'scope' => $responseJson['scope'],
    'sub' => $responseJson['sub'],
    'username' => $responseJson['email'],
    'email' => $responseJson['email'],
    'exp' => $responseJson['exp'],
    'token_type' => 'bearer',
    'aud' => $responseJson['aud']
  );

  print(json_encode($val));
}
?>