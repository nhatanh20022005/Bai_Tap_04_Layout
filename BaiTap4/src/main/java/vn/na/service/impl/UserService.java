package vn.na.service.impl;

import java.util.List;

import vn.na.entity.UserEntity;
import vn.na.repository.IUserRepository;
import vn.na.repository.impl.UserRepository;
import vn.na.service.IUserService;

public class UserService implements IUserService {

    private IUserRepository userRepo = new UserRepository();

    @Override
    public UserEntity login(String username, String password) {

        UserEntity user = userRepo.findById(username); 

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }

        return null;
    }

    @Override
    public void create(UserEntity user) throws Exception {

        if (user.getUsername() == null || user.getUsername().isEmpty()) {
            throw new Exception("Username ko được bỏ trống");
        }

        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new Exception("Password ko được bỏ trống");
        }

        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new Exception("Email ko được bỏ trống");
        }

        if (userRepo.existsUsername(user.getUsername())) {
            throw new Exception("Username đã tồn tại");
        }

        if (userRepo.existsEmail(user.getEmail())) {
            throw new Exception("Email đã tồn tại");
        }

        if (userRepo.existsPhone(user.getPhone())) {
            throw new Exception("SĐT đã tồn tại");
        }

        userRepo.create(user);
    }

    @Override
    public void update(UserEntity user) throws Exception {

        UserEntity old = userRepo.findById(user.getUsername());

        if (old == null) {
            throw new Exception("User ko tồn tại");
        }

        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new Exception("Password ko được bỏ trống");
        }

        if (user.getPassword().length() < 6) {
            throw new Exception("Password phải có ít nhất 6 ký tự");
        }

        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new Exception("Email ko được bỏ trống");
        }

        List<UserEntity> allUsers = userRepo.findAll();
        for (UserEntity u : allUsers) {

            if (!u.getUsername().equals(user.getUsername())) {

                if (u.getEmail().equalsIgnoreCase(user.getEmail())) {
                    throw new Exception("Email đã tồn tại");
                }
                if (u.getPhone().equalsIgnoreCase(user.getPhone())) {
                    throw new Exception("SĐT đã tồn tại");
                }
            }
        }

        userRepo.update(user);
    }

    @Override
    public void delete(String username) throws Exception {

        UserEntity old = userRepo.findById(username);

        if (old == null) {
            throw new Exception("User ko tồn tại");
        }

        userRepo.delete(username);
    }

    @Override
    public UserEntity findById(String username) {
        return userRepo.findById(username);
    }

    @Override
    public List<UserEntity> findAll() {
        return userRepo.findAll();
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userRepo.existsUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userRepo.existsEmail(email);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userRepo.existsPhone(phone);
    }

    @Override
    public UserEntity findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
}
