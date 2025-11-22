package vn.na.repository;

import java.util.List;
import vn.na.entity.VideoEntity;

public interface IVideoRepository {

    List<VideoEntity> findAll();

    VideoEntity findById(int id);

    void create(VideoEntity entity);

    void update(VideoEntity entity);

    void delete(int id);

    List<VideoEntity> searchByTitle(String keyword);
}
