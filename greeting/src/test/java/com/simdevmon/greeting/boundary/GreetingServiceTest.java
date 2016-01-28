package com.simdevmon.greeting.boundary;

import com.simdevmon.greeting.entity.Greeting;
import java.util.Arrays;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import org.junit.Before;
import org.junit.Test;
import static org.mockito.Mockito.when;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.mock;

/**
 * @author simdevmon
 */
public class GreetingServiceTest
{

    GreetingService cut;

    @Before
    public void init()
    {
        cut = new GreetingService();
        cut.em = mock(EntityManager.class);
    }

    @Test
    public void testGreetingRequest()
    {
        TypedQuery mockedQuery = mock(TypedQuery.class);
        when(mockedQuery.getResultList()).thenReturn(Arrays.asList(new Greeting("Hello World")));
        when(this.cut.em.createNamedQuery(Greeting.FIND_ALL, Greeting.class)).thenReturn(mockedQuery);
        List<Greeting> greetings = cut.getGreetings();
        assertNotNull(greetings);
        assertThat(greetings.size(), is(1));
        assertEquals(greetings.get(0).getMessage(), "Hello World");
    }

}
