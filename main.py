import os
import subprocess 

start_script_path = './run.sh'

try:
  os.chmod(start_script_path, 0o755)
  print(f"Permission granted: {start_script_path}")
except OSError as e:
  print(f"Permission denied: {e}")
  
process = subprocess.Popen(['/usr/bin/env', 'bash', start_script_path],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)

out = process.stdout
err = process.stderr

while True:
  try:
    line = out.readline()
    if not line:
      break
    print(line.decode('utf-8').strip())
  except KeyboardInterrupt:
    print("Interrupted by Ctrl+C")
    break

while True:
  try:   
    line = err.readline()
    if not line:
      break
    print(line.decode('utf-8').strip())
  except KeyboardInterrupt:
    print("Interrupted by Ctrl+C")
    break
    
if process.poll() is None:
  process.terminate()
  
rc = process.poll()

print(f"Child process exited with code {rc}")