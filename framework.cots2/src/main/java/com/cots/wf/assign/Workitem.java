/**
 *all rights reserved,@copyright 2003
 */
package com.cots.wf.assign;

import java.util.Date;

/**
 * Description:
 * <p/>
 * User: chuguanghua
 * Date: 2004-8-1
 * Time: 10:39:37
 */
public class Workitem {

    public static final int WORKITEM_CREATED = 1;
    public static final int WORKITEM_ASSIGNED = 2;
    public static final int WORKITEM_RUNNING = 3;
    public static final int WORKITEM_FINISHED = 4;
    public static final int WORKITEM_CANCELED = 5;
    public static final int WORKITEM_SUSPENDED = 6;

    public final static String TABLE = "WFWorkitem";
    public final static String KEYS ="workitemID";
    

    private long workitemID;
    private long processID;
    private long activityID;
    private String performerID;
    private String description;
    private String action;
    private int status = Workitem.WORKITEM_CREATED;
    private int lifeCycle;
    private Date createTime;
    private Date lastModifyTime;

    private AssignEngine assignEngine;

    public Workitem() {

    }

//    public AssignEngine getAssignEngine() {
//        return assignEngine;
//    }

    public long getProcessID() {
        return processID;
    }

    public long getActivityID() {
        return this.activityID;
    }

    public long getWorkitemID() {
        return this.workitemID;
    }

    public String getPerformerID() {
        return this.performerID;
    }

    public int getStatus() {
        return status;
    }

    public String getDescription() {
        return this.description;
    }

    public String getAction() {
        return this.action;
    }

    public Date getCreateTime() {
        return this.createTime;
    }

    public Date getLastModifyTime() {
        return this.lastModifyTime;
    }

    public int getLifeCycle() {
        return this.lifeCycle;
    }

    public void setActivityID(long activityID) {
        this.activityID = activityID;
    }

    public void setWorkitemID(long workitemID) {
        this.workitemID = workitemID;
    }

    public void setProcessID(long processID) {
        this.processID = processID;
    }

    public void setPerformerID(String performerID) {
        this.performerID = performerID;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public void setLastModifyTime(Date lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    public void setLifeCycle(int lifeCycle) {
        this.lifeCycle = lifeCycle;
    }

    public void setAssignEngine(AssignEngine ae) {
        this.assignEngine = ae;
    }

    public AssignEngine getAssignEngine() {
        return assignEngine;
    }
}