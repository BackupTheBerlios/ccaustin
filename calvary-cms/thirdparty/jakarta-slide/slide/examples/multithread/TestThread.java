/*
 * $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/ccaustin/Repository/calvary-cms/thirdparty/jakarta-slide/slide/examples/multithread/Attic/TestThread.java,v 1.1 2003/02/12 22:13:37 javajames27 Exp $
 * $Revision: 1.1 $
 * $Date: 2003/02/12 22:13:37 $
 *
 * ====================================================================
 *
 * The Apache Software License, Version 1.1
 *
 * Copyright (c) 1999-2002 The Apache Software Foundation.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution, if
 *    any, must include the following acknowlegement:
 *       "This product includes software developed by the
 *        Apache Software Foundation (http://www.apache.org/)."
 *    Alternately, this acknowlegement may appear in the software itself,
 *    if and wherever such third-party acknowlegements normally appear.
 *
 * 4. The names "The Jakarta Project", "Slide", and "Apache Software
 *    Foundation" must not be used to endorse or promote products derived
 *    from this software without prior written permission. For written
 *    permission, please contact apache@apache.org.
 *
 * 5. Products derived from this software may not be called "Apache"
 *    nor may "Apache" appear in their names without prior written
 *    permission of the Apache Group.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation.  For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 *
 * [Additional notices, if required by prior licensing conditions]
 *
 */
 
package multithread;

import java.util.Enumeration;
import java.util.Vector;
import java.io.*;
import java.util.Date;
import org.apache.slide.structure.*;
import org.apache.slide.content.*;
import org.apache.slide.common.*;
import org.apache.slide.lock.*;
import org.apache.slide.security.*;
import org.apache.slide.authenticate.CredentialsToken;
import org.apache.slide.authenticate.SecurityToken;

/**
 * Multi Thread example/test
 * 
 * @author Dirk Verbeeck
 * @version $Revision: 1.1 $
 */
public class TestThread implements Runnable
{
    private NamespaceAccessToken _token = null;
    private String _key = null;

    private static boolean use_transaction=true;
    private static int count=10;

    public TestThread(NamespaceAccessToken token, String key)
    {
        _token = token;
        _key = key;
    }
        
    public void run()
    {
        try 
        {
            Structure structure = _token.getStructureHelper();
            Security security = _token.getSecurityHelper();
            Lock lock = _token.getLockHelper();
            Content content = _token.getContentHelper();
                
            CredentialsToken credToken = 
            new CredentialsToken(new String("root"));
            SlideToken slideToken = new SlideTokenImpl(credToken);
                
            SubjectNode subject = new SubjectNode();

            String myUri = null;

            NodeRevisionDescriptors revisionDescriptors = null;
            NodeRevisionDescriptor revisionDescriptor = null;

        for (int i=0; i<count; i++)
        {
            _token.begin();

            try 
            {
                myUri="/"+_key+i;
                
                System.out.println(Thread.currentThread().getName()+
                                   ": Put uri = " + myUri);

                structure.create(slideToken, subject, myUri);
                    
                // Creating a versioned revision descriptors
                content.create(slideToken, myUri, true);
                    
                revisionDescriptors = content.retrieve(slideToken, myUri);
                    
                // NodeRevisionContent
                NodeRevisionContent nodeRevContent = new NodeRevisionContent();
                InputStream is = null;

                // Now creating some revisions
                revisionDescriptor = new NodeRevisionDescriptor(-1);

                revisionDescriptor.setProperty("revision", "1");
                is = new FileInputStream("test.txt");
                nodeRevContent.setContent(is);
                content.create(slideToken, myUri, revisionDescriptor, 
                               nodeRevContent);
                is.close();
            }
            catch (Exception ex) 
            {
                System.out.println(">>>> " + ex.toString());
            }
            _token.commit();
        }

        // Retrieving some revisions
        revisionDescriptor = content.retrieve(slideToken, revisionDescriptors);

        for (int i=0; i<count; i++)
        {
            if (use_transaction)
                _token.begin();

            try 
            {
                myUri = "/"+_key+i;
                
                System.out.println(Thread.currentThread().getName()+
                                   ": Get uri = " + myUri);

                NodeRevisionContent newRevContent = 
                  content.retrieve(slideToken, myUri, revisionDescriptor);
                InputStream newIS = newRevContent.streamContent();
                if (null != newIS)
                {
                    byte[] buf = new byte[1000];
                    int num = -1;
                    FileOutputStream fos = new FileOutputStream("out"+ myUri +".out");
                    num = newIS.read(buf);
                    while (num > 0)
                    {
                        fos.write(buf, 0, num);
                        fos.flush();
                        num = newIS.read(buf);
                    }
                    fos.close();
                    newIS.close();
                 }
            }
            catch (Exception ex) 
            {
                System.out.println(">>>> " + ex.toString());
            }
            if (use_transaction)
                _token.rollback();
          }
        } 
        catch (Throwable e) 
        {
            e.printStackTrace();
        } 
    }   
}
