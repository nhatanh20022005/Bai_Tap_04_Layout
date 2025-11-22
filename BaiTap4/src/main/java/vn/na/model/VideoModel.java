package vn.na.model;

import java.io.Serializable;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VideoModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private int videoId;
    private String title;
    private String poster;
    private int views;
    private String description;
    private boolean active;

    private int categoryId;  
}
