package vn.na.service;

import java.util.List;
import vn.na.entity.VideoEntity;

public interface IVideoService {

    void create(VideoEntity v) throws Exception;

    void update(VideoEntity v) throws Exception;

    void delete(int id) throws Exception;

    VideoEntity findById(int id);

    List<VideoEntity> findAll();

    List<VideoEntity> search(String keyword);
}
