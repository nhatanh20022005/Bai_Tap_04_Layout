package vn.na.repository.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.na.config.JPAConfig;
import vn.na.entity.CategoryEntity;
import vn.na.repository.ICategoryRepository;

public class CategoryRepository implements ICategoryRepository {

    @Override
    public void create(CategoryEntity entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(CategoryEntity entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int cateId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            CategoryEntity entity = em.find(CategoryEntity.class, cateId);
            if (entity != null) {
                em.remove(entity);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public CategoryEntity findById(int cateId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(CategoryEntity.class, cateId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<CategoryEntity> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<CategoryEntity> query =
                    em.createNamedQuery("Category.findAll", CategoryEntity.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<CategoryEntity> findByUser(String username) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM CategoryEntity c WHERE c.user.username = :uname";
            TypedQuery<CategoryEntity> query = em.createQuery(jpql, CategoryEntity.class);
            query.setParameter("uname", username);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean hasVideos(int cateId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(v) FROM VideoEntity v WHERE v.category.categoryId = :cid";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("cid", cateId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }
}
