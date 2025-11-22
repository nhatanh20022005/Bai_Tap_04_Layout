package vn.na.repository;

import java.util.List;

import vn.na.entity.UserEntity;

public interface IUserRepository {

	UserEntity findByEmail(String email);

	boolean existsPhone(String phone);

	boolean existsEmail(String email);

	boolean existsUsername(String username);

	List<UserEntity> findAll();

	UserEntity findById(String username);

	void delete(String username);

	void update(UserEntity entity);

	void create(UserEntity entity);


}
