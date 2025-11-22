package vn.na.service.impl;

import java.util.List;

import vn.na.entity.CategoryEntity;
import vn.na.repository.ICategoryRepository;
import vn.na.repository.impl.CategoryRepository;
import vn.na.service.ICategoryService;

public class CategoryService implements ICategoryService {

    private ICategoryRepository categoryRepo = new CategoryRepository();

    @Override
    public void create(CategoryEntity cate) throws Exception {

        if (cate.getCategoryName() == null || cate.getCategoryName().isEmpty()) {
            throw new Exception("Tên category ko dc trống");
        }

        if (cate.getUser() == null) {
            throw new Exception("Category phai thuoc 1 user!");
        }

        List<CategoryEntity> list = categoryRepo.findByUser(cate.getUser().getUsername());
        for (CategoryEntity c : list) {
            if (c.getCategoryName().equalsIgnoreCase(cate.getCategoryName())) {
                throw new Exception("Category nay đã tồn tai!");
            }
        }

        categoryRepo.create(cate);
    }

    @Override
    public void update(CategoryEntity cate) throws Exception {

        CategoryEntity old = categoryRepo.findById(cate.getCategoryId());

        if (old == null) {
            throw new Exception("Category ko tồn tại!");
        }

        if (cate.getCategoryName() == null || cate.getCategoryName().isEmpty()) {
            throw new Exception("Tên category ko dc trống");
        }

        List<CategoryEntity> list = categoryRepo.findByUser(old.getUser().getUsername());
        for (CategoryEntity c : list) {
            if (c.getCategoryId() != cate.getCategoryId() &&
                c.getCategoryName().equalsIgnoreCase(cate.getCategoryName())) {
                throw new Exception("Category này đã tồn tại!");
            }
        }

        cate.setUser(old.getUser());

        categoryRepo.update(cate);
    }

    @Override
    public void delete(int cateId) throws Exception {

        CategoryEntity cate = categoryRepo.findById(cateId);

        if (cate == null) {
            throw new Exception("Category ko tồn tại!");
        }

        if (categoryRepo.hasVideos(cateId)) {
            throw new Exception("Ko thể xóa category vì tồn tại video!");
        }

        categoryRepo.delete(cateId);
    }

    @Override
    public void deleteByAdmin(int cateId) throws Exception {

        CategoryEntity cate = categoryRepo.findById(cateId);

        if (cate == null) {
            throw new Exception("Category ko tồn tại!");
        }

        if (categoryRepo.hasVideos(cateId)) {
            throw new Exception("Ko thể xóa category vì tồn tại video!");
        }

        categoryRepo.delete(cateId);
    }

    @Override
    public CategoryEntity findById(int id) {
        return categoryRepo.findById(id);
    }

    @Override
    public List<CategoryEntity> findAll() {
        return categoryRepo.findAll();
    }

    @Override
    public List<CategoryEntity> findByUser(String username) {
        return categoryRepo.findByUser(username);
    }
}
