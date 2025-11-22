package vn.na.config;

import jakarta.persistence.EntityManager;

public class Test {
    public static void main(String[] args) {
        EntityManager em = JPAConfig.getEntityManager();
        em.close();
    }
}
