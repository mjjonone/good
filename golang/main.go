package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

func main() {
	startScriptPath := "./run.sh"
	interpreterPath := "/usr/bin/env"
	interpreterArgs := []string{"bash", startScriptPath}

	err := os.Chmod(startScriptPath, 0755)
	if err != nil {
		log.Fatalf("Permission denied: %s", err)
	}
	fmt.Printf("Permission granted: %s\n", startScriptPath)

	cmd := exec.Command(interpreterPath, interpreterArgs...)

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		log.Fatalf("Failed to create stdout pipe: %s", err)
	}

	stderr, err := cmd.StderrPipe()
	if err != nil {
		log.Fatalf("Failed to create stderr pipe: %s", err)
	}

	err = cmd.Start()
	if err != nil {
		log.Fatalf("Failed to start script: %s", err)
	}

	go func() {
		defer stdout.Close()
		buf := make([]byte, 1024)
		for {
			n, err := stdout.Read(buf)
			if n > 0 {
				fmt.Printf("Output: %s", buf[:n])
			}
			if err != nil {
				break
			}
		}
	}()

	go func() {
		defer stderr.Close()
		buf := make([]byte, 1024)
		for {
			n, err := stderr.Read(buf)
			if n > 0 {
				fmt.Printf("Error: %s", buf[:n])
			}
			if err != nil {
				break
			}
		}
	}()

	err = cmd.Wait()
	if err != nil {
		log.Fatalf("Script execution error: %s", err)
	}

	fmt.Printf("Child process exited with code %d\n", cmd.ProcessState.ExitCode())
}
