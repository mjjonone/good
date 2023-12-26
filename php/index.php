<?php

$startScriptPath = './run.sh';

$interpreterPath = '/usr/bin/env';
$interpreterArgs = ['bash', $startScriptPath];

try {
  chmod($startScriptPath, 0755);
  echo "Permission granted: {$startScriptPath}\n";
} catch (\Exception $e) {
  echo "Permission denied: {$e->getMessage()}\n";  
}

$process = proc_open($interpreterPath . ' ' . implode(' ', $interpreterArgs), [
  0 => ['pipe', 'r'], 
  1 => ['pipe', 'w'],
  2 => ['pipe', 'w'],
], $pipes);

if (is_resource($process)) {

  while (!feof($pipes[1]) || !feof($pipes[2])) {
    $reads = [$pipes[1], $pipes[2]];
    $writes = $excepts = null;

    stream_select($reads, $writes, $excepts, null);
    
    foreach ($reads as $stream) {
      $line = fgets($stream);
      if ($line !== false) {
        $stream === $pipes[1] 
          ? print "Output: {$line}"
          : print "{$line}"; 
      }
    }
  }

  fclose($pipes[0]);
  fclose($pipes[1]);
  fclose($pipes[2]);

  $returnCode = proc_close($process);

  echo "Child process exited with code {$returnCode}\n";

}

?>