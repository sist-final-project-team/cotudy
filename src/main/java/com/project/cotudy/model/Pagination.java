package com.project.cotudy.model;

import lombok.Data;

@Data
public class Pagination {
    private int rowsize = 10;
    private int block = 2;
    private int totalRecord = 0;
    private int allPage = 0;
    private int page = 0;
    private int startNo = (page * rowsize) - (rowsize - 1);
    private int endNo = (page * rowsize);
    private int startBlock = (((page - 1) / block) * block) + 1;
    private int endBlock = (((page - 1) / block) * block) + block;
}
