package vn.na.service;

import java.util.List;
import vn.na.entity.CategoryEntity;

public interface ICategoryService {

    void create(CategoryEntity cate) throws Exception;
    void update(CategoryEntity cate) throws Exception;
    void delete(int cateId) throws Exception;

    void deleteByAdmin(int cateId) throws Exception;

    CategoryEntity findById(int id);
    List<CategoryEntity> findAll();
    List<CategoryEntity> findByUser(String username);
}
