package vn.na.service.impl;

import java.util.List;

import vn.na.entity.VideoEntity;
import vn.na.repository.IVideoRepository;
import vn.na.repository.impl.VideoRepository;
import vn.na.service.IVideoService;

public class VideoService implements IVideoService {

    private IVideoRepository repo = new VideoRepository();

    @Override
    public void create(VideoEntity v) throws Exception {
        if (v.getTitle() == null || v.getTitle().isBlank())
            throw new Exception("Tiêu đề ko được trống");
        if (v.getCategory() == null)
            throw new Exception("Phải chọn Category");

        repo.create(v);
    }

    @Override
    public void update(VideoEntity v) throws Exception {
        if (v.getTitle() == null || v.getTitle().isBlank())
            throw new Exception("Tiêu đề ko được trống");
        if (v.getCategory() == null)
            throw new Exception("Phải chọn Category");

        repo.update(v);
    }

    @Override
    public void delete(int id) throws Exception {
        if (repo.findById(id) == null)
            throw new Exception("Video ko tồn tại");
        repo.delete(id);
    }

    @Override
    public VideoEntity findById(int id) {
        return repo.findById(id);
    }

    @Override
    public List<VideoEntity> findAll() {
        return repo.findAll();
    }

    @Override
    public List<VideoEntity> search(String keyword) {
        if (keyword == null || keyword.isBlank())
            return repo.findAll();
        return repo.searchByTitle(keyword);
    }
}
