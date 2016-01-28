package com.simdevmon.greeting.entity;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

/**
 * @author simdevmon
 */
public class GreetingIT
{

    EntityManager em;

    @Before
    public void init()
    {
        this.em = Persistence.createEntityManagerFactory("integration-test").createEntityManager();
    }

    @Test
    public void crud()
    {
        EntityTransaction tx = em.getTransaction();
        tx.begin();
        em.merge(new Greeting("Hello World"));
        tx.commit();
        List<Greeting> greetings = em.createNamedQuery(Greeting.FIND_ALL, Greeting.class).getResultList();
        assertNotNull(greetings);
        assertThat(greetings.size(), is(1));
        Greeting upd = greetings.get(0);
        upd.setMessage("Hello Changed World");
        tx.begin();
        em.merge(upd);
        tx.commit();

    }
}
