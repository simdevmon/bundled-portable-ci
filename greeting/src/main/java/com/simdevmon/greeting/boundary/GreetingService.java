package com.simdevmon.greeting.boundary;

import com.simdevmon.greeting.entity.Greeting;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * @author simdevmon
 */
@Stateless
@Path("greetings")
public class GreetingService
{

    @PersistenceContext
    EntityManager em;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Greeting> getGreetings()
    {
        return em.createNamedQuery(Greeting.FIND_ALL, Greeting.class).getResultList();
    }
}
