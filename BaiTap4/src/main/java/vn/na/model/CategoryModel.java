package vn.na.model;

import java.io.Serializable;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private int categoryId;
    private String categoryName;
    private String categoryCode;
    private String images;
    private boolean status;
}
