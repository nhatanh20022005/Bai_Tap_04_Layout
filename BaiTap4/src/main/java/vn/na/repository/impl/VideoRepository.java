package vn.na.repository.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.na.config.JPAConfig;
import vn.na.entity.VideoEntity;
import vn.na.repository.IVideoRepository;

public class VideoRepository implements IVideoRepository {

    @Override
    public List<VideoEntity> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createNamedQuery("Video.findAll", VideoEntity.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public VideoEntity findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(VideoEntity.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(VideoEntity entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(VideoEntity entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            VideoEntity v = em.find(VideoEntity.class, id);
            if (v != null) em.remove(v);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<VideoEntity> searchByTitle(String keyword) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM VideoEntity v WHERE v.title LIKE :kw";
            TypedQuery<VideoEntity> query =
                    em.createQuery(jpql, VideoEntity.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
