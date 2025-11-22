package vn.na.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "category")
@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM VideoEntity v")
public class VideoEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "videoid")
    private int videoId;

    @Column(name = "title", length = 255)
    private String title;

    @Column(name = "poster", length = 500)
    private String poster;

    @Column(name = "views")
    private int views;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "active")
    private boolean active;

    @ManyToOne
    @JoinColumn(name = "categoryid")
    private CategoryEntity category;
}
