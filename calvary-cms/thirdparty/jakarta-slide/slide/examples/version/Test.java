/**
 * Redistribution and use of this software and associated documentation
 * ("Software"), with or without modification, are permitted provided
 * that the following conditions are met:
 *
 * 1. Redistributions of source code must retain copyright
 *    statements and notices.  Redistributions must also contain a
 *    copy of this document.
 *
 * 2. Redistributions in binary form must reproduce the
 *    above copyright notice, this list of conditions and the
 *    following disclaimer in the documentation and/or other
 *    materials provided with the distribution.
 *
 * 3. The name "Exolab" must not be used to endorse or promote
 *    products derived from this Software without prior written
 *    permission of Exoffice Technologies.  For written permission,
 *    please contact info@exolab.org.
 *
 * 4. Products derived from this Software may not be called "Exolab"
 *    nor may "Exolab" appear in their names without prior written
 *    permission of Exoffice Technologies. Exolab is a registered
 *    trademark of Exoffice Technologies.
 *
 * 5. Due credit should be given to the Exolab Project
 *    (http://www.exolab.org/).
 *
 * THIS SOFTWARE IS PROVIDED BY EXOFFICE TECHNOLOGIES AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * EXOFFICE TECHNOLOGIES OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright 1999 (C) Exoffice Technologies Inc. All Rights Reserved.
 *
 * $Id: Test.java,v 1.1 2003/02/12 22:13:37 javajames27 Exp $
 */

package version;

import java.util.Enumeration;
import java.util.Vector;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Date;
import org.apache.slide.structure.*;
import org.apache.slide.content.*;
import org.apache.slide.common.*;
import org.apache.slide.lock.*;
import org.apache.slide.security.*;
import org.apache.slide.authenticate.CredentialsToken;
import org.apache.slide.authenticate.SecurityToken;

/**
 * This is a test class for versioning support.
 */
public class Test {
    
    public static void main(String[] args) {
        
        NamespaceAccessToken token = null;
        
        try {
            
            token = Domain.accessNamespace(new SecurityToken(new String()),
                                           "version");
            
            Structure structure = token.getStructureHelper();
            Security security = token.getSecurityHelper();
            Lock lock = token.getLockHelper();
            Content content = token.getContentHelper();
            
            CredentialsToken credToken =
                new CredentialsToken(new String("root"));
            SlideToken slideToken = new SlideTokenImpl(credToken);
            
            System.out.println("Creating a test subject");
            
            SubjectNode subject = new SubjectNode();
            structure.create(slideToken, subject, "/test");
            
            // Creating a versioned revision descriptors
            content.create(slideToken, "/test", true);
            
            NodeRevisionDescriptors revisionDescriptors =
                content.retrieve(slideToken, "/test");
            
            // Now creating some revisions
            NodeRevisionDescriptor revisionDescriptor =
                new NodeRevisionDescriptor(0);
            
            revisionDescriptor.setProperty("revision", "1");
            content.create(slideToken, "/test", revisionDescriptor, null);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors);
            revisionDescriptor.setProperty("revision", "2");
            content.create(slideToken, "/test", revisionDescriptor, null);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors);
            content.fork(slideToken, "/test", "branch2", revisionDescriptor);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors, "branch2");
            revisionDescriptor.setProperty("revision", "3");
            content.create(slideToken, "/test", "branch2",
                           revisionDescriptor, null);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors, "branch2");
            revisionDescriptor.setProperty("revision", "4");
            content.create(slideToken, "/test", "branch2", revisionDescriptor,
                           null);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors);
            revisionDescriptor.setProperty("revision", "5");
            content.create(slideToken, "/test", revisionDescriptor, null);
            
            content.merge(slideToken, "/test",
                          NodeRevisionDescriptors.MAIN_BRANCH, "branch2",
                          revisionDescriptor, null);
            
            revisionDescriptor = content.retrieve
                (slideToken, revisionDescriptors);
            revisionDescriptor.setProperty("revision", "7");
            content.create(slideToken, "/test", revisionDescriptor, null);
            
            // Retrieving some revisions
            revisionDescriptor =
                content.retrieve(slideToken, revisionDescriptors);
            System.out.println("Latest revision in the main branch : Number:"
                               + revisionDescriptor.getRevisionNumber()
                               + " Revision:"
                               + revisionDescriptor.getProperty("revision")
                               .getValue());
            revisionDescriptor =
                content.retrieve(slideToken, revisionDescriptors, "branch2");
            System.out.println("Latest revision in branch2 : Number:"
                               + revisionDescriptor.getRevisionNumber()
                               + " Revision:"
                               + revisionDescriptor.getProperty("revision")
                               .getValue());
            
        } catch (Throwable e) {
            e.printStackTrace();
        } finally {
            System.out.println("Closing data sources");
            Domain.closeNamespace(token);
        }
    }
    
}
