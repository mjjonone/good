use std::process::{Command, Stdio};
use std::io::{BufRead, BufReader};
use std::os::unix::fs::PermissionsExt;

fn main() -> std::io::Result<()> {
    let mut child = Command::new("/usr/bin/env")
        .arg("bash")
        .arg("./run.sh")
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()?;

    let stdout = child.stdout.take().expect("Child process did not have a handle to stdout");
    let stderr = child.stderr.take().expect("Child process did not have a handle to stderr");

    let stdout_reader = BufReader::new(stdout);
    let stderr_reader = BufReader::new(stderr);

    let stdout_handle = std::thread::spawn(move || {
        for line in stdout_reader.lines() {
            println!("Stdout: {}", line.unwrap());
        }
    });

    let stderr_handle = std::thread::spawn(move || {
        for line in stderr_reader.lines() {
            println!("Stderr: {}", line.unwrap());
        }
    });

    stdout_handle.join().expect("Failed to read stdout");
    stderr_handle.join().expect("Failed to read stderr");

    let status = child.wait()?;
    println!("Exit code: {}", status.code().unwrap());

    std::fs::set_permissions("./run.sh", PermissionsExt::from_mode(0o755))?;

    Ok(())
}
