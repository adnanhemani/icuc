import com.mathworks.toolbox.javabuilder.*;
import WaveReq.*;

class wave
{
   public static void main(String[] args)
   {
      Object[] result = null;
      wavreq wave = null;
      if (args.length != (65 + 14))
      {
        System.out.println("Error: you provided " + args.length + " arguments, must be 1+65+13");
        // return;
      }
  
      try
      {
        wave = new wavreq();
        String fileid = args[0];
        // ZERNIKE COEFFICIENTS
        float zernikes[] = new float[65];
        for (int i = 0; i < 65; i++)
            zernikes[i] = Float.parseFloat(args[i+1]); 
        MWNumericArray coeffs = new MWNumericArray(zernikes, MWClassID.DOUBLE);
        
        // other parameters
        float pupilfit = Float.parseFloat(args[66]);
        float pupilcalc = Float.parseFloat(args[67]);
        // float defocus = Float.parseFloat(args[68]);
        float wavelength = Float.parseFloat(args[69]);
        float pixels = Float.parseFloat(args[70]);
        float pupilfieldsize = Float.parseFloat(args[71]);
        float lettersize = Float.parseFloat(args[72]); 
        
        // TESTING DEFOCUS RANGE
            // if single value

        float defocus = Float.parseFloat(args[68]); 

            // else need to parse each individually
            // would like to see format of args[68]
        // String[] defocusFromInput = new String[20];
        String defFromInput = args[68]; 
        // str2num('1:0.5:3') works

        float defocusRange[] = new float[3];
        System.out.println(defFromInput);

        
        // defocusRange[0] = Float.parseFloat(defFromInput[0]);
        // defocusRange[1] = Float.parseFloat(defFromInput[0]);
        // defocusRange[2] = 5.0;
        // MWNumericArray defocusRanges = new MWNumericArray(defocusRange, MWClassID.DOUBLE);
        
        
        // choice of graphs
        int WF = Integer.parseInt(args[73]);
        int PSF = Integer.parseInt(args[74]);
        int MTF = Integer.parseInt(args[75]);
        int PTF = Integer.parseInt(args[76]);
        int MTFL = Integer.parseInt(args[77]);
        int CONV = Integer.parseInt(args[78]);
        
        // result fits
        result = wave.WaveReq(2, fileid, coeffs, pupilfit, pupilcalc, defocus, wavelength, pixels, pupilfieldsize, lettersize, WF, PSF, MTF, PTF, MTFL, CONV);
        System.out.println(result);
      }
      catch (Exception e)
      {
        System.out.println("Exception: " + e.toString());
        System.out.println("IN WAVE.JAVA");
      }
      finally
      {
         MWArray.disposeArray(result);
         wave.dispose();
      }
   }
}