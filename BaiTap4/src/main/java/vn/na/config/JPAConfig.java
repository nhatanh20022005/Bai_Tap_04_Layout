package vn.na.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {

    private static final EntityManagerFactory FACTORY;

    static {
        FACTORY = Persistence.createEntityManagerFactory("DBMySQL");
    }

    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }
}
