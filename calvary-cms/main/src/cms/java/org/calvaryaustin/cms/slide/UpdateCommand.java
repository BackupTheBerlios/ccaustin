package org.calvaryaustin.cms.slide;
 
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.*;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.slide.common.*;
import org.apache.slide.content.NodeProperty;
import org.apache.slide.content.NodeRevisionContent;
import org.apache.slide.content.NodeRevisionDescriptor;
import org.apache.slide.content.NodeRevisionDescriptors;
import org.apache.slide.content.NodeRevisionNumber;
import org.apache.slide.content.RevisionDescriptorNotFoundException;
import org.apache.slide.lock.*;
import org.apache.slide.structure.*;
import org.apache.slide.webdav.util.DeltavConstants;
import org.apache.slide.webdav.util.PreconditionViolationException;
import org.apache.slide.webdav.util.PropertyHelper;
import org.apache.slide.webdav.util.UriHandler;
import org.apache.slide.webdav.util.WebdavUtils;
import org.apache.slide.webdav.util.resourcekind.AbstractResourceKind;
import org.apache.slide.webdav.util.resourcekind.ResourceKind;
import org.apache.slide.webdav.util.resourcekind.VersionControlled;
import org.apache.slide.webdav.util.resourcekind.VersionControlledImpl;
import org.apache.slide.webdav.util.resourcekind.VersionHistoryImpl;
import org.apache.slide.webdav.util.resourcekind.VersionImpl;
import org.apache.util.HttpURL;
import org.apache.webdav.lib.WebdavResource;

 

/**
 * Updates a resource, creating a new revision and saving the new content/settings
 * @author jhigginbotham
 */
public class UpdateCommand extends AbstractSlideCommand
{

    /**
     * Initialize the command that is to be performed
     * @param slideToken the client token to use for the work
     * @param namespace the namespace token to perform the work
     * @param uriToUpdate the URI to the resource to update
     */
    public UpdateCommand(SlideToken slideToken, NamespaceAccessToken namespace, 
    					  String uriToUpdate, String contentType, String contentString)
    {
        super(slideToken, namespace);
        this.uriToUpdate = uriToUpdate;
        this.contentType = contentType;
        this.contentString = contentString;
        
        // hold-over from versioning helper code
        ActionNode actionNode = namespace.getNamespaceConfig().getModifyRevisionMetadataAction();
        if (actionNode != null) {
            modifyMetadataUri = actionNode.getUri();
        }
        else {
            modifyMetadataUri = "";
        }
        
        actionNode = namespace.getNamespaceConfig().getModifyRevisionContentAction();
        if (actionNode != null) {
            modifyContentUri = actionNode.getUri();
        }
        else {
            modifyContentUri = "";
        }
        this.pHelp = PropertyHelper.getPropertyHelper( slideToken, namespace );
    }

	public void execute() throws SlideException
	{
        executeUsingWebDAV();
	}

    public void executeUsingWebDAV() throws SlideException
    {
        try 
        {
          HttpURL httpURL = new HttpURL("http://localhost:8080/slide");
          httpURL.setUserInfo("root","root"); 
          WebdavResource webdavResource = new WebdavResource(httpURL);
          webdavResource.setDebug( 0 ); // change to 1 to see the HTTP wire data
          // TODO: Fix this to ensure prefix is not duplicated, /'s are not duplicated or missing, etc
          String subpath = "/slide"+uriToUpdate.substring( 0, uriToUpdate.lastIndexOf("/"));
          log.debug("subpath="+subpath);
          webdavResource.setPath(subpath);
          if (webdavResource.putMethod("/slide"+uriToUpdate, contentString))
          {
            log.debug("execute(): Succeeded");
          } 
          else
          {
            //log.debug("importFile(): Failed. Reason: "+webdavResource.getStatusMessage());
            throw new SlideException("Import failed. Reason: "+webdavResource.getStatusMessage());
          }
        }
        catch (HttpException e)
        {
            log.warn("Caught error",e);
            throw new SlideException("Error while importing:"+e.getMessage());
        } // end of try-catch
        catch (IOException e)
        {
            log.warn("Caught error",e);
            throw new SlideException("Error while performing I/O for import:"+e.getMessage());
        } // end of try-catch
    }
    
	public void executeUsingLowLevelAPI() throws SlideException
	{
	    // TODO: Consider using the wedav client API instead, since we aren't getting the proper update logic with versioning here
        boolean isLockedNullResource = false;
                
        NodeRevisionDescriptors revisionDescriptors =
            content.retrieve(slideToken, uriToUpdate);
                
        NodeRevisionNumber revisionNumber =
            revisionDescriptors.getLatestRevision();
        NodeRevisionDescriptor oldRevisionDescriptor = null;
        if (revisionNumber != null) {
            try {
                oldRevisionDescriptor = content.retrieve
                    (slideToken, revisionDescriptors);
            } catch (RevisionDescriptorNotFoundException e) {
            }
        }
        if (WebdavUtils.isCollection(oldRevisionDescriptor)) {
            throw new SlideException("URI "+uriToUpdate+" can't be updated - it is a collection");
        }
                
        NodeRevisionDescriptor revisionDescriptor = null;
        if (oldRevisionDescriptor == null) {
            revisionDescriptor = new NodeRevisionDescriptor();
        } else {
            revisionDescriptor = oldRevisionDescriptor;
            revisionDescriptor.setContentLength(-1);
        }
                
        ResourceKind resourceKind = AbstractResourceKind.determineResourceKind(namespace, uriToUpdate, revisionDescriptor);
                
        isWriteLocked(slideToken, revisionDescriptors);
                
        // check preconditions
//        ViolatedPrecondition violatedPrecondition = getPreconditionViolation(revisionDescriptors, revisionDescriptor, resourceKind);
//        if (violatedPrecondition != null) {
//            throw new PreconditionViolationException(violatedPrecondition, resourcePath);
//        }
                
        // Changed for DeltaV --start--
//        boolean mustCheckIn = false;
//        if( Configuration.useVersionControl() &&
//               (resourceKind instanceof CheckedInVersionControlled) &&
//           versioningHelper.mustCheckoutAutoVersionedVCR(revisionDescriptors, revisionDescriptor) ) {
//                    
//            versioningHelper.checkout(revisionDescriptors, revisionDescriptor, false, false, true );
//            mustCheckIn = versioningHelper.mustCheckinAutoVersionedVCR(slideToken, revisionDescriptors, revisionDescriptor);
//        }
        // Changed for DeltaV --end--
                
        NodeRevisionContent revisionContent =
            new NodeRevisionContent();
        //revisionContent.setContent(req.getReader());
        revisionContent.setContent( new ByteArrayInputStream(contentString.getBytes()));
                
        // Get content length
        revisionDescriptor.setContentLength(contentString.length());
                
        // Last modification date
        revisionDescriptor.setLastModified(new Date());
                
        // Etag generation
        revisionDescriptor.setETag(uriToUpdate.hashCode() + "_"
                                   + revisionNumber.hashCode() + "_"
                                   + revisionDescriptor.getContentLength());
                
        // Normally assume the 'getcontentlanguage' and
        // 'getcontenttype' are set, however, before we clear the
        // 'resourcetype' need to check for the case when a
        // 'lock-null' is created just before the initial PUT. In
        // that case need to add the missing properties.
        if (revisionDescriptor.propertyValueContains
                (revisionDescriptor.RESOURCE_TYPE ,"lock-null")){
            isLockedNullResource = true;
            revisionDescriptor.setContentLanguage("en");
                    
            revisionDescriptor.setContentType(contentType);
                    
            // Changed for DeltaV --start--
//            if( Configuration.useVersionControl() ) {
                // Workspace
                setWorkspaceProperty( uriToUpdate, revisionDescriptor );
//            }
            // Changed for DeltaV --end--
        }
                
        // Resource type
        revisionDescriptor.setResourceType("");
                
        // Owner
        if ( isLockedNullResource )
            // set the owner when updating a lock-null resource
            revisionDescriptor.setOwner(
                slideToken.getCredentialsToken().
                    getPublicCredentials());
                
        content.store(slideToken, uriToUpdate, revisionDescriptor, revisionContent);
                
        // Changed for DeltaV --start--
        // check if the resource should be put under version-control
//        if ( isLockedNullResource ) {
//            if ( Configuration.useVersionControl() && AUTO_VERSION_CONTROL /*&& !isInVersioncontrolExcludePath*/ ) {
                versionControl(slideToken, namespace, uriToUpdate, contentString.length());
//            }
//        }
//        if( Configuration.useVersionControl() && mustCheckIn) {
//            versioningHelper.checkin(revisionDescriptors, revisionDescriptor, false, false, true ); //forkOk=false, keepCheckedOut=false
//        }
        // Changed for DeltaV --end--
                
	}
	

    /**
     * Indicates if the resource specified by the given NodeRevisionDescriptors
     * is write locked. Reads all URLs in read only mode
     *
     * @param      slideToken           the SlideToken to use.
     * @param      revisionDescriptors  the NodeRevisionDescriptors of the resource.
     *
     * @return     <code>true</code> if the resource is write locked.
     * @from org.apache.slide.webdav.util.VersioningHelper
     */
    private boolean isWriteLocked(SlideToken slideToken, NodeRevisionDescriptors revisionDescriptors)
        throws ServiceAccessException {
        return (getWriteLock(new SlideTokenWrapper(slideToken, false), revisionDescriptors) != null);
    }
    
    /**
     * Returns the write lock of the resource specified by the given
     * NodeRevisionDescriptors if one exists, otherwise <code>null</code>.
     *
     * @param      slideToken           the SlideToken to use.
     * @param      revisionDescriptors  the NodeRevisionDescriptors of the resource.
     *
     * @return     the write lock of the resource.
     */
    private NodeLock getWriteLock(SlideToken slideToken, NodeRevisionDescriptors revisionDescriptors)
        throws ServiceAccessException {
        
        NodeLock writeLock = null;
        try {
            Enumeration lockEnum = lock.enumerateLocks(slideToken, revisionDescriptors.getUri());
            if (lockEnum != null) {
                String typeUri = null;
                NodeLock lock = null;
                while ( (writeLock == null) && lockEnum.hasMoreElements() ) {
                    lock = (NodeLock)lockEnum.nextElement();
                    typeUri = lock.getTypeUri();
                    if ( modifyContentUri.equals(typeUri) ||
                        modifyMetadataUri.equals(typeUri) ) {
                        writeLock = lock;
                    }
                }
            }
        }
        catch (ObjectNotFoundException e) {}
        catch (LockTokenNotFoundException e) {}
        
        return writeLock;
    }

    /**
     * Set the specified resource under version control
     *
     * @param resourcePath the URI of the resource to version-control
     * @throws SlideException
     */
    public void versionControl(SlideToken sToken, NamespaceAccessToken nsaToken, String resourcePath, int contentLength ) throws SlideException {
        UriHandler rUh = UriHandler.getUriHandler( resourcePath );
        Iterator i;
        Enumeration j;
        
        NodeRevisionDescriptors rNrds = content.retrieve( sToken, resourcePath );
        NodeRevisionDescriptor rNrd = content.retrieve( sToken, rNrds );
        ResourceKind rRk = AbstractResourceKind.determineResourceKind( nsaToken, resourcePath, rNrd );
//        if( !rRk.isSupportedMethod(req.getMethod()) ) {
//            throw new MethodNotAllowedException( rRk );
//        }
        
        // Check for rRk = K_VERSION_CONTROLLED*
        if( rRk instanceof VersionControlled ) {
            // nothing to do
            return;
        }
        
        // Set initial VR properties
        NodeRevisionDescriptor vrNrd =
            new NodeRevisionDescriptor(contentLength);
        i = pHelp.createInitialProperties(VersionImpl.getInstance()).iterator();
        while( i.hasNext() )
            vrNrd.setProperty( (NodeProperty)i.next() );
        
        // Copy dead properties VCR -> VR
        j = rNrd.enumerateProperties();
        while( j.hasMoreElements() ) {
            NodeProperty p = (NodeProperty)j.nextElement();
            if( p.isLiveProperty() )
                continue;
            if( !vrNrd.exists(p.getName()) )
                vrNrd.setProperty( p );
        }
        
        // Copy properties VCR->VR
        NodeRevisionContent rNrc = content.retrieve( sToken, rNrds, rNrd );
        vrNrd.setContentType(rNrd.getContentType()); // P_GETCONTENTTYPE
        vrNrd.setContentLength(rNrd.getContentLength()); // P_GETCONTENTLENGTH
        vrNrd.setContentLanguage(rNrd.getContentLanguage()); // P_GETCONTENTLANGUAGE
        String comment = "INITIAL VERSION. ";
        if( rNrd.exists(DeltavConstants.P_COMMENT) )
            comment += (String)rNrd.getProperty(DeltavConstants.P_COMMENT).getValue();
        vrNrd.setProperty(
            new NodeProperty(DeltavConstants.P_COMMENT, comment) );
        
        // Set initial VHR properties
        Vector vhrLabels = new Vector();
        Hashtable vhrProps = new Hashtable();
        String vhrBranch = NodeRevisionDescriptors.MAIN_BRANCH;
        NodeRevisionDescriptor vhrNrd =
            new NodeRevisionDescriptor( NodeRevisionNumber.HIDDEN_0_0, vhrBranch, vhrLabels, vhrProps );
        i = pHelp.createInitialProperties(VersionHistoryImpl.getInstance()).iterator();
        while( i.hasNext() )
            vhrNrd.setProperty( (NodeProperty)i.next() );
        
        // Set initial VCR properties (do not overwrite existing!!)
        i = pHelp.createInitialProperties(VersionControlledImpl.getInstance()).iterator();
        while( i.hasNext() ) {
            NodeProperty p = (NodeProperty)i.next();
            if( !rNrd.exists(p.getName()) )
                rNrd.setProperty( p );
        }
        
        // Create VHR/VR
        UriHandler vhrUh = UriHandler.createNextHistoryUri( sToken, nsaToken, rUh );
        String vhrUri = String.valueOf( vhrUh );
        SubjectNode vhrNode = new SubjectNode();
        structure.create( sToken, vhrNode, String.valueOf(vhrUh) );
        content.create( sToken, vhrUri, true ); //isVersioned=true
        content.create( sToken, vhrUri, vrNrd, rNrc );
        NodeRevisionDescriptors vhrNrds =
            content.retrieve( sToken, vhrUri );
        content.create(
            sToken, vhrUri, null, vhrNrd, null ); //branch=null, revisionContent=null
        
        // Create VR node
        NodeRevisionNumber vrVersion = vrNrd.getRevisionNumber();
        SubjectNode vrNode = new SubjectNode();
        UriHandler vrUh =
            UriHandler.createVersionUri( vhrUh, String.valueOf(vrVersion) );
        String vrUri = String.valueOf( vrUh );
        structure.create( sToken, vrNode, String.valueOf(vrUh) );
        
        // Set specific properties
        vrNrd.setName(rNrd.getName()); // P_DISPLAYNAME
        rNrd.setProperty(
            new NodeProperty(DeltavConstants.P_CHECKED_IN, pHelp.createHrefValue(vrUri)) );
        vhrNrd.setETag( vhrUri.hashCode()+"_" ); // P_GETETAG
        vhrNrd.setCreationDate( new Date() ); // P_CREATIONDATE
        vhrNrd.setLastModified( new Date() ); // P_GETLASTMODIFIED
        vhrNrd.setContentLength( 0 ); // P_GETCONTENTLENGTH
        vhrNrd.setName( vhrUh.getHistoryName() ); // P_DISPLAYNAME
        vhrNrd.setProperty(
            new NodeProperty(DeltavConstants.P_VERSION_SET, pHelp.createHrefValue(vrUri)) );
        vrNrd.setETag( vrUri.hashCode()+"_"+contentLength ); // P_GETETAG
        vrNrd.setCreationDate( new Date() ); // P_CREATIONDATE
        vrNrd.setLastModified( new Date() ); // P_GETLASTMODIFIED
        vrNrd.setProperty(
            new NodeProperty(DeltavConstants.P_VERSION_NAME, vrUh.getVersionName()) );
        
        // Store changes
        content.store( sToken, resourcePath, rNrd, null ); //revisionContent=null
        content.store( sToken, vhrUri, vhrNrd, null ); //revisionContent=null
        content.store( sToken, vhrUri, vrNrd, null ); //revisionContent=null
    }

    /**
     * Set the workspace property if needed.
     *
     * @param rUri the URI of the resource to set the workspace property
     * @param rNrd the NodeRevisionDescriptor to set the workspace property
     */
    public void setWorkspaceProperty( String rUri, NodeRevisionDescriptor rNrd ) {
        UriHandler rUh = UriHandler.getUriHandler( rUri );
        String wsUri = rUh.getAssociatedWorkspaceUri();
        if( wsUri != null ) {
            rNrd.setProperty(
                new NodeProperty(DeltavConstants.P_WORKSPACE, pHelp.createHrefValue(wsUri)) );
        }
        else {
            rNrd.removeProperty(DeltavConstants.P_WORKSPACE);
        }
    }

    /**
     * Checkin the specified resource (for both: checkout-in-place and working-resource features).
     * @param rNrds the revision descriptors instance
     * @param rNrd the revision descriptor instance
     * @param forkOk true, if the request body contained a DAV:fork-ok element
     * @param keepCheckedOut true, if the request body contained a DAV:keep-checked-out element
     * @param autoVersion true, if the checkin is due to auto-versioning
     * @return the URI of the created version resource
     * @throws SlideException
     * @throws JDOMException
     * @throws IOException
     * @throws PreconditionViolatedException
    public String checkin( NodeRevisionDescriptors rNrds, NodeRevisionDescriptor rNrd,
                          boolean forkOk, boolean keepCheckedOut, boolean autoVersion )
        throws SlideException, JDOMException, IOException, PreconditionViolationException {
        
        Iterator i;
        Enumeration j;
        String rUri = getUri( rNrds, rNrd );
        ResourceKind rRk = AbstractResourceKind.determineResourceKind( nsaToken, rNrds, rNrd );
        
        if( !rRk.isSupportedMethod(req.getMethod()) ) {
            // check precondition C_MUST_BE_CHECKED_OUT
            if( (rRk instanceof CheckedInVersionControlled) ) {
                throw new PreconditionViolationException(
                    new ViolatedPrecondition(C_MUST_BE_CHECKED_OUT, WebdavStatus.SC_CONFLICT), rUri);
            }
            throw new MethodNotAllowedException( rRk );
        }
        
        if( rRk instanceof CheckedOutVersionControlled || rRk instanceof Working ) {
            
            boolean isWorkingResource = (rRk instanceof Working);
            
            NodeProperty coutProp = rNrd.getProperty( P_CHECKED_OUT );
            NodeProperty predSetProp = rNrd.getProperty( P_PREDECESSOR_SET );
            NodeProperty autoUpdProp = rNrd.getProperty( P_AUTO_UPDATE );
            
            // prepare auto-update
            NodeRevisionDescriptors autoUpdNrds = null;
            NodeRevisionDescriptor autoUpdNrd = null;
            if( autoUpdProp != null ) {
                Element autoUpdElm = pHelp.parsePropertyValue( (String)autoUpdProp.getValue() );
                String autoUpdUri = autoUpdElm.getTextTrim();
                autoUpdNrds = content.retrieve( sToken, autoUpdUri );
                autoUpdNrd = content.retrieve( sToken, autoUpdNrds );
            }
            
            // Retrieve VHR
            Element coutElm = pHelp.parsePropertyValue( (String)coutProp.getValue() );
            String vrUriOld = coutElm.getTextTrim();
            UriHandler vrUhOld = UriHandler.getUriHandler( vrUriOld );
            NodeRevisionNumber vrNrnOld = new NodeRevisionNumber( vrUhOld.getVersionName() );
            String vhrUri = vrUhOld.getAssociatedHistoryUri();
            NodeRevisionDescriptors vhrNrds = content.retrieve( sToken, vhrUri );
            NodeRevisionDescriptor vhrNrd = content.retrieve( sToken, vhrNrds ); //vhrUri
            NodeProperty vSetProp = vhrNrd.getProperty( P_VERSION_SET );
            
            // Retrieve old VR
            NodeRevisionDescriptor vrNrdOld =
                content.retrieve( sToken, vhrNrds, vrNrnOld ); // vrUriOld
            
            // update the old VR's DAV:checkout-set property
            PropertyHelper.removeHrefFromProperty(vrNrdOld, P_CHECKOUT_SET, rUri);
            content.store(sToken, vhrNrds.getUri(), vrNrdOld, null);
            
            ViolatedPrecondition violatedPrecondition =
                getCheckinPreconditionViolation( predSetProp, vhrNrds, forkOk, autoUpdNrd );
            if (violatedPrecondition != null) {
                throw new PreconditionViolationException(violatedPrecondition, rUri);
            }
            
            String forkBranch = getForkBranch(predSetProp, vhrNrds, forkOk);
            NodeRevisionDescriptor vrNrdNew = null;
            if (forkBranch != null) {
                // Create a new branch
                NodeRevisionNumber branchedRevisionNumber =
                    content.fork(sToken, vhrNrds.getUri(), forkBranch, vrNrdOld);
                vhrNrds = content.retrieve( sToken, vhrUri );
                vrNrdNew = content.retrieve(sToken, vhrNrds, branchedRevisionNumber);
                vrNrdNew.setContentLength(rNrd.getContentLength());
            }
            else {
                // Create new VR in the MAIN branch
                vrNrdNew = new NodeRevisionDescriptor( rNrd.getContentLength() );
            }
            
            i = pHelp.createInitialProperties(VersionImpl.getInstance()).iterator();
            while( i.hasNext() )
                vrNrdNew.setProperty( (NodeProperty)i.next() );
            
            // Copy dead properties VCR --> VR-new
            j = rNrd.enumerateProperties();
            while( j.hasMoreElements() ) {
                NodeProperty p = (NodeProperty)j.nextElement();
                if( p.isLiveProperty() )
                    continue;
                if( !vrNrdNew.exists(p.getName()) )
                    vrNrdNew.setProperty( p );
            }
            // Copy specific live properties VCR/WR -> VR
            vrNrdNew.setContentType(rNrd.getContentType()); // P_GETCONTENTTYPE
            vrNrdNew.setContentLength(rNrd.getContentLength()); // P_GETCONTENTLENGTH
            vrNrdNew.setContentLanguage( rNrd.getContentLanguage() ); // P_GETCONTENTLANGUAGE
            String comment = (autoVersion ? "CREATED BY AUTO-VERSIONING. " : "");
            if( rNrd.exists(P_COMMENT) )
                comment += (String)rNrd.getProperty(P_COMMENT).getValue();
            vrNrdNew.setProperty(
                new NodeProperty(P_COMMENT, comment) );
            
            vrNrdNew.setProperty( rNrd.getProperty(P_CHECKOUT_FORK) );
            vrNrdNew.setProperty( rNrd.getProperty(P_CHECKIN_FORK) );
            
            NodeRevisionContent rNrc = content.retrieve( sToken, rNrds, rNrd );
            
            if (forkBranch != null) {
                content.store(sToken, vhrUri, vrNrdNew, rNrc);
            }
            else {
                String branch = vrNrdOld.getBranchName();
                content.create( sToken, vhrUri, branch, vrNrdNew, rNrc );
            }
            String vrUriNew = vhrUri+"/"+vrNrdNew.getRevisionNumber().toString();
            UriHandler vrUhNew = UriHandler.getUriHandler( vrUriNew );
            SubjectNode vrNodeNew = new SubjectNode();
            structure.create( sToken, vrNodeNew, vrUriNew );
            
            // set specific properties
            if( keepCheckedOut ) {
                rNrd.setProperty(
                    new NodeProperty(P_CHECKED_OUT, pHelp.createHrefValue(vrUriNew)) );
                rNrd.setProperty(
                    new NodeProperty(P_PREDECESSOR_SET, vrNrdNew.getProperty(P_PREDECESSOR_SET).getValue()) );
            }
            else {
                if( !isWorkingResource ) {
                    rNrd.removeProperty( coutProp );
                    rNrd.setProperty(
                        new NodeProperty(P_CHECKED_IN, pHelp.createHrefValue(vrUriNew)) );
                    rNrd.removeProperty( I_CHECKIN_LOCKTOKEN , NamespaceCache.SLIDE_URI);
                    // retry with default (DAV:) namespace which was the
                    // former namespace of this property
                    rNrd.removeProperty( I_CHECKIN_LOCKTOKEN );
                    rNrd.removeProperty(P_PREDECESSOR_SET);
                    rNrd.removeProperty(P_CHECKOUT_FORK);
                    rNrd.removeProperty(P_CHECKIN_FORK);
                }
            }
            
            vhrNrd.setLastModified( new Date() ); // P_GETLASTMODIFIED
            vhrNrd.setProperty( new NodeProperty(
                                   P_VERSION_SET, ((String)vSetProp.getValue())+pHelp.createHrefValue(vrUriNew)) );
            
            vrNrdNew.setName( rNrd.getName() ); // P_DISPLAYNAME
            vrNrdNew.setETag( vrUriNew.hashCode()+"_"+req.getContentLength() ); // P_GETETAG
            vrNrdNew.setCreationDate( new Date() ); // P_CREATIONDATE
            vrNrdNew.setLastModified( new Date() ); // P_GETLASTMODIFIED
            vrNrdNew.setProperty(
                new NodeProperty(P_VERSION_NAME, vrUhNew.getVersionName()) );
            vrNrdNew.setProperty(
                new NodeProperty(P_PREDECESSOR_SET, predSetProp.getValue()) );
            
            // Store changes
            if( keepCheckedOut || !isWorkingResource ) {
                content.store( sToken, rUri, rNrd, null ); //revisionContent=null
                try {
                    // remove the hidden 0.0 revision and create new one if keepCheckedOut
                    content.remove( sToken, rUri, NodeRevisionNumber.HIDDEN_0_0 );
                }
                catch( RevisionDescriptorNotFoundException x ) {
                    // the implicit CHECKOUT from COPY (auto-versioning) does not create a
                    // backup descriptor.
                    Domain.info( "Checkin: no backup descriptor found at "+rUri );
                }
                if( keepCheckedOut )
                    backupSpecificLiveProperties( rNrds, rNrd );
            }
            else {
                // remove the WR
                macro.delete( sToken, rUri );
            }
            content.store( sToken, vhrUri, vhrNrd, null ); //revisionContent=null
            content.store( sToken, vhrUri, vrNrdNew, null ); //revisionContent=null
            
            // auto-update
            if( autoUpdNrd != null ) {
                update( autoUpdNrds, autoUpdNrd, vhrNrds, vrNrdNew );
            }
            
            // Set status created
            resp.setStatus( WebdavStatus.SC_CREATED );
            return vrUriNew;
        }
        else {
            Domain.warn(
                "Do not know how to checkout a '"+rRk+"' resource" );
            resp.setStatus(WebdavStatus.SC_CONFLICT);
            return null;
        }
    }
     */

    private final static boolean AUTO_VERSION_CONTROL = new Boolean(
        Domain.getParameter(DeltavConstants.I_AUTO_VERSION_CONTROL, DeltavConstants.I_AUTO_VERSION_CONTROL_DEFAULT) ).booleanValue();

    /**
     * Update subject.
     */
    private String uriToUpdate;
    private String contentString;
	private String contentType;
	
	
	// versioning helper stuff
    private String modifyMetadataUri;
    private String modifyContentUri;
    private PropertyHelper pHelp;

    private static final Log log = LogFactory.getLog( UpdateCommand.class );
}
