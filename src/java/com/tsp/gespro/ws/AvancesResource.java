/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsp.gespro.ws;

import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author gloria
 */
@Path("avances")
public class AvancesResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of AvancesResource
     */
    public AvancesResource() {
    }

    /**
     * Retrieves representation of an instance of com.tsp.gespro.ws.AvancesResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("application/json")
    public String getXml() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of AvancesResource
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @PUT
    @Produces("application/json")
    public void putXml(String content) {
    }
}
