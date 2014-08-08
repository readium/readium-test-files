// Copyright (c) 2014 Readium Foundation and/or its licensees. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation 
// and/or other materials provided with the distribution.
// 3. Neither the name of the organization nor the names of its contributors may be used to endorse or promote products derived from this software 
// without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS 
// BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;

import javax.xml.bind.DatatypeConverter;

/**
 * Simple code to obfuscate a font using the now-deprecated Adobe algorithm
 * This algorithm was used primarily by early versions of InDesign, circa 2007-08.
 * 
 * This code expects to be given a font-file name to mangle and the unique ID to use 
 * in mangling. The file to be mangled (fontfile.ext) is copied to a NEW file named 
 * fontfile.adb.ext
 * 
 * The ID can be of the form urn:uuid or a simple string - the original Adobe algorithm
 * doesn't care, though some tools (such as ACS4) might have a problem with plain strings. 
 * It is better to use a string of the form urn:uuid.
 * 
 * @author rkwright, Readium Foundation, August 2014
 *
 */
public class ObfuscateFont
{
	private static final int ADOBE_OBFUSCATE_LEN = 1024;

	/**
	 * Create the Adobe key by cleaning out cruft and returning
	 * the hex values as a byte array
	 * 
	 * @param uuid
	 * @return
	 */
	public static byte[] adobeKeyFromIdentifier( String uuid )
	{
	    String cleanUUID = uuid.replaceAll("urn:uuid", "");
	    cleanUUID = cleanUUID.replaceAll("-", "");
	    cleanUUID = cleanUUID.replaceAll(":", "");

	    return DatatypeConverter.parseHexBinary(cleanUUID);
	}
	
	/**
	 * Create the new obfuscated name by inserting .adb into the filename
	 * 
	 * @param fontToMangle
	 * @return
	 */
	public static String makeObfuscatedName( String fontToMangle )
	{
		int	period = fontToMangle.lastIndexOf(".");
		String last = fontToMangle.substring(period);
		String front = fontToMangle.substring(0, period);
		
		return front + ".adb" + last;
	}
	
	/**
	 * Copy the original file to the new file name.
	 * Doesn't matter if the file exists or not.  If not, it will
	 * be created.  If it exists it is wiped out - so beware!
	 * 
	 * @param sourceFile
	 * @param destFile
	 * @throws IOException
	 */
	public static void copyFile(File sourceFile, File destFile) throws IOException
	{
		if (!destFile.exists())
		{
			destFile.createNewFile();
		}

		FileChannel source = null;
		FileChannel destination = null;

		try
		{
			source = new FileInputStream(sourceFile).getChannel();
			destination = new FileOutputStream(destFile).getChannel();
			destination.transferFrom(source, 0, source.size());
		}
		finally
		{
			if (source != null)
			{
				source.close();
			}
			if (destination != null)
			{
				destination.close();
			}
		}
	}
	
	/**
	 * Obfuscate the file by copying the original file to the new
	 * obfuscated name then mangling the file in-place.
	 * 
	 * @param fontToMangle
	 * @param uuid
	 * @return
	 */
	public static boolean adobeObfuscate( String fontToMangle, String uuid )
	{
		boolean	success = false;
		byte[] key = adobeKeyFromIdentifier(uuid);
		int	keyIndex = 0;
		String	obfName = makeObfuscatedName(fontToMangle);
		
    	System.out.printf("The key being used:\n");
		for ( int n=0; n<key.length; n++)
		{
			System.out.printf("%2x ", key[n]);
		}
    	System.out.println();
		
		RandomAccessFile fontFile;
		try
		{
			copyFile( new File(fontToMangle), new File(obfName));

			fontFile = new RandomAccessFile(obfName, "rw");

		    for ( int i=0; i<ADOBE_OBFUSCATE_LEN; i++ )
		    {
		    	byte b = fontFile.readByte();
		    	long pos = fontFile.getFilePointer();
		    	int c = (byte) (b ^ key[keyIndex]);
		    	System.out.printf("b: %2x c: %2x key: %2x keyIndex: %3d  pos: %3d\n", b, c & 0xff, key[keyIndex], keyIndex, pos);

		    	// reading the byte advances the file pointer, so back up to the right spot
		    	fontFile.seek(i);
		    	fontFile.writeByte(c);
		    	keyIndex = ++keyIndex % key.length;
		    }
	    
		    fontFile.close();
		    success = true;
		}
		catch (FileNotFoundException e)
		{
			System.err.printf("Font file: %s could not be found.  Aborting.\n",fontToMangle);
			e.printStackTrace();
		}
		catch (IOException e)
		{
			System.err.printf("I/O error while mangling font file: %s.  Aborting.\n",fontToMangle);
			e.printStackTrace();
		}
		
		return success;
	}
	
	/**
	 * required args are
	 * 0 - name of the file to be copied and the copy mangled
	 * 1 - the key to use in the mangling
	 * 
	 * @param args
	 */
	public static void main(String[] args)
	{
		if (args.length == 2 && adobeObfuscate(args[0], args[1]) == true)			
			System.out.printf("Successfully mangled font file: %s.\n",args[0]);
		else
			System.err.printf("Failed to mangle font file: %s.\n",args[0]);

	}

}
