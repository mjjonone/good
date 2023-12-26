using System;
using System.Diagnostics;
using System.IO;

class Program
{
    static void Main()
    {
        string startScriptPath = "./run.sh";
        string interpreterPath = "/usr/bin/env";
        string[] interpreterArgs = { "bash", startScriptPath };

        try
        {
            File.SetAttributes(startScriptPath, FileAttributes.Normal);
            Console.WriteLine($"Permission granted: {startScriptPath}");
        }
        catch (Exception error)
        {
            Console.Error.WriteLine($"Permission denied: {error}");
        }

        Process startScript = new Process();
        startScript.StartInfo.FileName = interpreterPath;
        startScript.StartInfo.Arguments = string.Join(" ", interpreterArgs);
        startScript.StartInfo.RedirectStandardOutput = true;
        startScript.StartInfo.RedirectStandardError = true;
        startScript.OutputDataReceived += (sender, e) =>
        {
            if (!string.IsNullOrEmpty(e.Data))
                Console.WriteLine($"Output: {e.Data}");
        };
        startScript.ErrorDataReceived += (sender, e) =>
        {
            if (!string.IsNullOrEmpty(e.Data))
                Console.Error.WriteLine(e.Data);
        };

        startScript.Start();
        startScript.BeginOutputReadLine();
        startScript.BeginErrorReadLine();

        startScript.WaitForExit();

        int exitCode = startScript.ExitCode;
        Console.WriteLine($"Child process exited with code {exitCode}");
    }
}
