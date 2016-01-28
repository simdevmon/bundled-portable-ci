package com.simdevmon.greeting.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * @author simdevmon
 */
@Entity
@XmlRootElement
@NamedQuery(name = Greeting.FIND_ALL, query = "SELECT n FROM Greeting n")
public class Greeting implements Serializable
{

    private static final long serialVersionUID = 3099837387001144847L;

    public static final String FIND_ALL = "Greeting.all";

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private String message;

    public Greeting()
    {
        // default constructor for classloader
    }

    public Greeting(String message)
    {
        this.message = message;
    }

    @XmlTransient
    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

}
