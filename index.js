const { spawn } = require('child_process');
const fs = require('fs');

const startScriptPath = './run.sh';
const interpreterPath = '/usr/bin/env';
const interpreterArgs = ['bash', startScriptPath];

try {
  fs.chmodSync(startScriptPath, 0o755);
  console.log(`Permission granted: ${startScriptPath}`);
} catch (error) {
  console.error(`Permission denied: ${error}`);
}

const startScript = spawn(interpreterPath, interpreterArgs);

startScript.stdout.on('data', (data) => {
  console.log(`Output: ${data}`);
});

startScript.stderr.on('data', (data) => {
  console.error(`${data}`);
});

startScript.on('error', (error) => {
  console.error(`Script execution error: ${error}`);
  process.exit(1); 
});

startScript.on('close', (code) => {
  console.log(`Child process exited with code ${code}`);
});
