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

package xml;

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
 * This is a test class for XML support.
 */
public class Test {
    
    public static void main(String[] args) {
        
        NamespaceAccessToken token = null;
        
        try {
            
            token = Domain.accessNamespace(new SecurityToken(new String()),
                                           "xml");
            
            Structure structure = token.getStructureHelper();
            Security security = token.getSecurityHelper();
            Lock lock = token.getLockHelper();
            Content content = token.getContentHelper();
            
            CredentialsToken credToken =
                new CredentialsToken(new String("root"));
            SlideToken slideToken = new SlideTokenImpl(credToken);
            
            System.out.println("Loading objects from XML file");
            
            token.importData(slideToken, new FileReader("Import.xml"));
            
            System.out.println("Creating some subjects");
            
            SubjectNode subject1 = new SubjectNode();
            SubjectNode subject2 = new SubjectNode();
            SubjectNode subject3 = new SubjectNode();
            SubjectNode subject4 = new SubjectNode();
            SubjectNode subject5 = new SubjectNode();
            
            System.out.println("Now creating a link");
            
            LinkNode link = new LinkNode();
            
            System.out.println("Now creting some subjects");
            
            SubjectNode user1 = new SubjectNode();
            SubjectNode user2 = new SubjectNode();
            SubjectNode user3 = new SubjectNode();
            
            ActionNode read = new ActionNode();
            
            System.out.println("Storing everything in the database");
            
            try {
                structure.retrieve(slideToken, "/toto");
            } catch (StructureException e) {
                System.out.println
                    ("!!!!Objects don't exist : Creating objects ...");
                subject1 = (SubjectNode) structure.retrieve(slideToken, "/");
                structure.create(slideToken, subject2, "/toto");
                structure.create(slideToken, subject3, "/toto/1.txt");
                structure.create(slideToken, subject4, "/toto/2.txt");
                structure.create(slideToken, subject5, "/toto/2");
                structure.create(slideToken, subject5, "/toto/2/3");
                structure.create(slideToken, subject5, "/toto/2/3/4");
                structure.create(slideToken, subject5, "/toto/2/3/4/5");
                structure.createLink(slideToken, link, "/toto/test.lnk",
                                     subject2);
                user1 = (SubjectNode) structure.retrieve(slideToken, "/users/");
                structure.create(slideToken, user2, "/users/remm.user");
                structure.create(slideToken, user3, "/users/dave.user");
                
                structure.create(slideToken, read, "/actions/read.action");
            }
            
            System.out.println("Children list for /");
            
            Enumeration children =
                structure.getChildren(slideToken,
                                      structure.retrieve(slideToken, "/"));
            while (children.hasMoreElements()) {
                ObjectNode child = (ObjectNode) children.nextElement();
                System.out.println("Child : " + child.getUri());
            }
            
            System.out.println("Retrieveing /users/");
            structure.retrieve(slideToken, "/users/");
            
            System.out.println("Children list for /toto");
            
            children =
                structure.getChildren(slideToken,
                                      structure.retrieve(slideToken, "/toto"));
            while (children.hasMoreElements()) {
                ObjectNode child = (ObjectNode) children.nextElement();
                System.out.println("Child : " + child.getUri());
            }
            
            System.out.println("Various retrieval tests");
            
            subject2 = (SubjectNode) structure.retrieve(slideToken, "/");
            subject2 = (SubjectNode) structure.retrieve(slideToken, "/toto");
            subject2 = (SubjectNode) structure.retrieve
                (slideToken, "/toto/2/3");
            String res = structure.getParent(slideToken, subject2).getUri();
            System.out.println("Subject2 : " + subject2.getUri().toString());
            
            System.out.println("Multiple structure source tree browsing");
            
            subject5 = (SubjectNode) structure.retrieve
                (slideToken, "/toto/2/3/4/5");
            ObjectNode obj = structure.getParent(slideToken, subject5);
            System.out.println("Parent : " + obj.getUri().toString());
            obj = structure.getParent(slideToken, obj);
            System.out.println("Parent : " + obj.getUri().toString());
            obj = structure.getParent(slideToken, obj);
            System.out.println("Parent : " + obj.getUri().toString());
            obj = structure.getParent(slideToken, obj);
            System.out.println("Parent : " + obj.getUri().toString());
            obj = structure.getParent(slideToken, obj);
            System.out.println("Parent : " + obj.getUri().toString());
            
            System.out.println("Link test");
            
            System.out.println("Resolved link to "
                               + structure.retrieve
                               (slideToken, "/toto/test.lnk/1.txt").getUri());
            
            System.out.println("Retrieve the complex stuff");
            
            structure.retrieve(slideToken, "/toto/2/3/4/5");
            
            long date1 = (new Date()).getTime();
            
            int nbcheck = 10000;
            
            for (int i=0; i<nbcheck; i++) {
                structure.retrieve(slideToken, "/toto/2/3/4/5");
                //Security.checkPermission(subject5, user2, action2);
            }
            
            long date2 = (new Date()).getTime();
            
            double count = ((double) (date2 - date1)) / 1000;
            System.out.println("Time elapsed = " + count + " seconds");
            count = 1000 * nbcheck / (double) (date2 - date1);
            System.out.println("Operations / s = " + count);
            
            System.out.println("Testing locking service");
            
            ActionNode lockAction = new ActionNode();
            
            try {
                lockAction = (ActionNode) structure.retrieve
                    (slideToken, "/actions/lock.action");
            } catch (StructureException e) {
                System.out.println("Creating Lock action");
                structure.create
                    (slideToken, lockAction, "/actions/lock.action");
            }
            System.out.println("Lock Action : " + lockAction);
            
            ActionNode killLockAction = new ActionNode();
            
            try {
                killLockAction = (ActionNode) structure.retrieve
                    (slideToken, "/actions/killlock.action");
            } catch (StructureException e) {
                System.out.println("Creating KillLock action");
                structure.create
                    (slideToken, killLockAction, "/actions/killlock.action");
            }
            System.out.println("Kill lock Action : " + killLockAction);
            
            SubjectNode remm = (SubjectNode) structure.retrieve
                (slideToken, "/users/remm.user");
            SubjectNode dave = (SubjectNode) structure.retrieve
                (slideToken, "/users/dave.user");
            SubjectNode toLock = (SubjectNode) structure.retrieve
                (slideToken, "/toto/1.txt");
            SubjectNode toLock2 = (SubjectNode) structure.retrieve
                (slideToken, "/toto/2.txt");
            SubjectNode toLock3 = (SubjectNode) structure.retrieve
                (slideToken, "/toto");
            
            ActionNode lockType = (ActionNode) structure.retrieve
                (slideToken, "/actions/read.action");
            
            Date expirationDate = new Date((new Date()).getTime() + 10000000);
            
            NodeLock token1 =
                new NodeLock(toLock, remm, lockType, expirationDate, false);
            NodeLock token2 =
                new NodeLock(toLock, dave, lockType, expirationDate, false);
            NodeLock token3 =
                new NodeLock(toLock3, dave, lockAction, expirationDate, true);
            NodeLock token4 =
                new NodeLock(toLock2, dave, lockAction, expirationDate, false);
            
            System.out.println("Grant locking permission");
            
            security.grantPermission
                (slideToken, structure.retrieve(slideToken, "/toto"),
                 (SubjectNode) structure.retrieve(slideToken, "/users"),
                 lockAction);
            
            System.out.println("Locking resource");
            
            lock.lock(slideToken, token1);
            System.out.println("Lock test1 - correct");
            try {
                lock.lock(slideToken, token2);
            } catch (SlideException e) {
                System.out.println("Lock test2 - correct");
            }
            lock.lock(slideToken, token3);
            System.out.println("Lock test3 - correct");
            try {
                lock.lock(slideToken, token4);
            } catch (SlideException e) {
                System.out.println("Lock test4 - correct");
            }
            
            // Saving data
            token.exportData(slideToken, new FileWriter("Export.xml"));
            
        } catch (Throwable e) {
            e.printStackTrace();
        } finally {
            System.out.println("Closing data sources");
            Domain.closeNamespace(token);
        }
    }
    
}
