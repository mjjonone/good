import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Main {

  public static void main(String[] args) {

    try {
      String[] cmd = new String[] { "chmod", "+x", "./run.sh" };
      Process p = Runtime.getRuntime().exec(cmd);
      p.waitFor();


      int chmodExitCode = p.exitValue();
      if (chmodExitCode != 0) {
        System.out.println("Error setting execute permission for the script. Exit code: " + chmodExitCode);
        return;
      }

      cmd = new String[] { "./run.sh" };
      p = Runtime.getRuntime().exec(cmd);


      InputStream inputStream = p.getInputStream();
      InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
      BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

      String line;
      while ((line = bufferedReader.readLine()) != null) {
        System.out.println(line);
      }

      p.waitFor();

      int exitCode = p.exitValue();

      if (exitCode != 0) {

        System.out.println("Error running script. Exit code: " + exitCode);
      } else {

        System.out.println("Script executed successfully!");
      }

    } catch (IOException e) {

      e.printStackTrace();
    } catch (InterruptedException e) {

      e.printStackTrace();
    }

  }

}
