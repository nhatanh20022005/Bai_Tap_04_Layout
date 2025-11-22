package vn.na.entity;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = {"videos", "user"})
@Entity
@Table(name = "category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM CategoryEntity c")
public class CategoryEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryid")
    private int categoryId;

    @Column(name = "categoryname", length = 255)
    private String categoryName;

    @Column(name = "categorycode", length = 100)
    private String categoryCode;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private boolean status;

    @ManyToOne
    @JoinColumn(name = "username")  
    private UserEntity user;

    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    private List<VideoEntity> videos;
}
