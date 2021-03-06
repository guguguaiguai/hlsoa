
/* Drop Indexes */

DROP INDEX SYS_OFFICE_PARENT_ID;
DROP INDEX SYS_OFFICE_PARENT_IDS;
DROP INDEX SYS_OFFICE_DEL_FLAG;
DROP INDEX SYS_OFFICE_TYPE;
DROP INDEX SYS_USER_OFFICE_ID;
DROP INDEX SYS_USER_LOGIN_NAME;
DROP INDEX SYS_USER_COMPANY_ID;
DROP INDEX SYS_USER_UPDATE_DATE;
DROP INDEX SYS_USER_DEL_FLAG;



/* Drop Tables */

DROP TABLE FILE_ATTACH;
DROP TABLE FILE_HISTORY;
DROP TABLE FILE_RELEASED;
DROP TABLE HLS_FILE;
DROP TABLE INTERNAL_RECEIVE;
DROP TABLE MAIL_ATTACH;
DROP TABLE MAIL_COMMON;
DROP TABLE MAIL_RECEIVE;
DROP TABLE MAIL_SEND;
DROP TABLE MSG_EMAIL;
DROP TABLE MSG_INTERNAL;
DROP TABLE MSG_REMIND;
DROP TABLE NEWS_HISTORY;
DROP TABLE NOTICE_TYPE;
DROP TABLE SYS_OFFICE_BACKUP;
DROP TABLE SYS_OFFICE_LOG;
DROP TABLE SYS_USER_BACKUP;
DROP TABLE SYS_USER_LOG;
DROP TABLE WS_FILES;
DROP TABLE WS_NEWS;
DROP TABLE WS_POST;




/* Create Tables */

-- 附件信息
CREATE TABLE FILE_ATTACH
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 文件名
	FILE_ONAME VARCHAR2(900) NOT NULL,
	-- 新文件名
	FILE_NAME VARCHAR2(900) NOT NULL,
	-- 文件扩展名
	FILE_EXT VARCHAR2(32),
	-- 附件类型
	--             如：邮件附件
	FILE_TYPE VARCHAR2(128) NOT NULL,
	-- 文件大小
	TOTAL_BYTES NUMBER(20) DEFAULT 0 NOT NULL,
	-- 文件存放路径
	FILE_PATH VARCHAR2(300) NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 文件下载记录
CREATE TABLE FILE_HISTORY
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 下载文件主键
	FILE_ID VARCHAR2(64) NOT NULL,
	-- 下载者
	FILE_DOWNLOAD VARCHAR2(64) NOT NULL,
	-- 下载文件名
	FILE_NAME VARCHAR2(2100),
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 文件发布范围
CREATE TABLE FILE_RELEASED
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 文件主键
	FILE_ID VARCHAR2(64) NOT NULL,
	-- 文件共享人，文件查看权，单个人共享
	FILE_SHARE VARCHAR2(64),
	-- 文件授权者，共享文件的人（文件拥有人）
	FILE_GRANTEE VARCHAR2(64) NOT NULL,
	-- 文件下载权，是否拥有文件下载权，0：有，1：无
	FILE_DOWNLOAD CHAR(1) DEFAULT '0' NOT NULL,
	-- 文件修改权，0：有，1：无
	FILE_EDIT CHAR(1) DEFAULT '1' NOT NULL,
	-- 共享文件到部门
	FILE_DEP VARCHAR2(64),
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 文件保存信息
CREATE TABLE HLS_FILE
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 文件名
	FILE_NAME VARCHAR2(1200) NOT NULL,
	-- 存储文件名
	FILE_SNAME VARCHAR2(600) NOT NULL,
	FILE_PATH VARCHAR2(1200) NOT NULL,
	-- 模块名称
	FILE_MODULES VARCHAR2(600) NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 消息接收人
CREATE TABLE INTERNAL_RECEIVE
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 消息ID
	MSG_ID VARCHAR2(64) NOT NULL,
	-- 发送人ID
	SEND_ID VARCHAR2(64) NOT NULL,
	-- 接收人ID
	RECEIVE_ID VARCHAR2(64) NOT NULL,
	-- 阅读时间
	READ_DATE DATE,
	-- 阅读状态,0:未读，1：已读
	READ_STATE CHAR(1) DEFAULT '0' NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 邮件附件
CREATE TABLE MAIL_ATTACH
(
	-- 附件ID
	ATTACH_ID VARCHAR2(64) NOT NULL,
	-- 邮件ID
	MAIL_ID VARCHAR2(64) NOT NULL
);


-- 邮件常用联系人
CREATE TABLE MAIL_COMMON
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 联系人ID
	LINK_USER VARCHAR2(64) NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 邮件接收者信息
CREATE TABLE MAIL_RECEIVE
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 邮件接收者
	MAIL_RECEIVE VARCHAR2(64) NOT NULL,
	-- 邮件主键
	MAIL_ID VARCHAR2(64) NOT NULL,
	-- 发送者主键
	MAIL_SENDER VARCHAR2(64) NOT NULL,
	-- 阅读状态,0:未读，1：已读
	MAIL_STATE VARCHAR2(1) DEFAULT '0' NOT NULL,
	-- 阅读时间
	READ_DATE DATE,
	-- 删除标记,0:正常，1：删除
	IS_DEL CHAR(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (ID)
);


-- 邮件发送信息
CREATE TABLE MAIL_SEND
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 邮件主键
	MAIL_ID VARCHAR2(64) NOT NULL,
	-- 发送者ID
	SEND_ID VARCHAR2(64) NOT NULL,
	-- 是否删除，0：正常，1：删除
	IS_DEL CHAR(1) DEFAULT '0' NOT NULL,
	-- 发送时间
	SEND_DATE DATE NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 内部邮件
CREATE TABLE MSG_EMAIL
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 邮件接收者,多个接收者中间用‘,’分割
	MAIL_ACCEPTOR VARCHAR2(4000) NOT NULL,
	-- 接收者姓名
	ACCEPTOR_NAMES VARCHAR2(4000) NOT NULL,
	-- 邮件标题
	MAIL_TITLE VARCHAR2(300) NOT NULL,
	-- 邮件内容
	MAIL_CONTENT CLOB NOT NULL,
	-- 文件名称
	FILE_NAMES VARCHAR2(4000),
	-- 附件路径
	FILE_PATH VARCHAR2(4000),
	-- 是否提醒,0:提醒，1：不提醒
	IS_REMIND CHAR(1) DEFAULT '1' NOT NULL,
	-- 是否发送,0:发送，1：草稿，2：撤回
	IS_SEND CHAR(1) DEFAULT '1' NOT NULL,
	-- 发送时间
	SEND_DATE DATE,
	-- 存稿时间
	DRAFT_DATE DATE NOT NULL,
	-- 是否删除,0:正常，1：删除
	IS_DEL CHAR(1) DEFAULT '0' NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 内部消息
CREATE TABLE MSG_INTERNAL
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 接收人名称
	ACCEPTOR_NAME VARCHAR2(3000) NOT NULL,
	-- 收信人
	ACCEPTOR VARCHAR2(6400) NOT NULL,
	-- 消息内容
	MSG_CONTENT VARCHAR2(3000) NOT NULL,
	-- 消息类别,0:消息，1：系统通知
	MSG_TYPE VARCHAR2(1) DEFAULT '0' NOT NULL,
	-- 撤回时间
	BACK_DATE DATE,
	-- 消息状态,0:发送，1：撤回
	MSG_STATE CHAR(1) DEFAULT '0' NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 消息提醒设置
CREATE TABLE MSG_REMIND
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 公告提醒，0：提醒，1：不提醒
	REMIND_NOTICE CHAR(1) DEFAULT '1' NOT NULL,
	-- 站内消息提醒，0：提醒，1：不提醒
	REMIND_MSG CHAR(1) DEFAULT '0' NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 新闻阅读历史
CREATE TABLE NEWS_HISTORY
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 新闻主键
	NEWS_ID VARCHAR2(64) NOT NULL,
	-- 阅读者
	NEWS_READER VARCHAR2(64) NOT NULL,
	-- 阅读时间
	READ_DATE DATE NOT NULL,
	-- 阅读次数
	READ_NUM NUMBER(3) DEFAULT 0 NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 公告类别
CREATE TABLE NOTICE_TYPE
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 类别名称
	NT_NAME VARCHAR2(60) NOT NULL,
	-- 图片路径
	NT_FILE VARCHAR2(200),
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 医院科室备份
CREATE TABLE SYS_OFFICE_BACKUP
(
	-- 编号
	ID VARCHAR2(64) NOT NULL,
	 VARCHAR2(0) NOT NULL,
	 VARCHAR2(0) NOT NULL,
	 NVARCHAR2(0) NOT NULL,
	 NUMBER(0,0) NOT NULL,
	-- 归属区域
	AREA_ID VARCHAR2(64) NOT NULL,
	-- 区域编码
	CODE VARCHAR2(100),
	-- 机构类型（1：公司；2：部门；3：小组）
	TYPE CHAR(1) NOT NULL,
	-- 机构等级（1：一级；2：二级；3：三级；4：四级）
	GRADE CHAR(1) NOT NULL,
	-- 联系地址
	ADDRESS NVARCHAR2(255),
	-- 邮政编码
	ZIP_CODE VARCHAR2(100),
	-- 负责人
	MASTER NVARCHAR2(100),
	-- 电话
	PHONE NVARCHAR2(200),
	-- 传真
	FAX NVARCHAR2(200),
	-- 邮箱
	EMAIL NVARCHAR2(200),
	USEABLE VARCHAR2(64),
	PRIMARY_PERSON VARCHAR2(64),
	DEPUTY_PERSON VARCHAR2(64),
	-- 备份时间
	BACKUP_DATE TIMESTAMP,
	PRIMARY KEY (ID)
);


-- 部门操作日志
CREATE TABLE SYS_OFFICE_LOG
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 时间
	LOG_START TIMESTAMP NOT NULL,
	-- 备份类别 0：开始，1：结束  2：异常
	LOG_TYPE CHAR(1) NOT NULL,
	-- 备注 出现操作异常或其他信息的标注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 用户表数据备份
CREATE TABLE SYS_USER_BACKUP
(
	-- 编号
	ID VARCHAR2(64) NOT NULL,
	-- 归属公司
	COMPANY_ID VARCHAR2(64) NOT NULL,
	-- 归属部门
	OFFICE_ID VARCHAR2(64) NOT NULL,
	-- 登录名
	LOGIN_NAME VARCHAR2(100) NOT NULL,
	-- 密码
	PASSWORD VARCHAR2(100) NOT NULL,
	-- 工号
	NO VARCHAR2(100),
	-- 姓名
	NAME NVARCHAR2(100) NOT NULL,
	-- 邮箱
	EMAIL NVARCHAR2(200),
	-- 电话
	PHONE VARCHAR2(200),
	-- 手机
	MOBILE VARCHAR2(200),
	-- 用户类型
	USER_TYPE CHAR(1),
	PHOTO VARCHAR2(1000),
	-- 最后登陆IP
	LOGIN_IP VARCHAR2(100),
	-- 最后登陆时间
	LOGIN_DATE TIMESTAMP,
	LOGIN_FLAG VARCHAR2(64),
	-- 拼音码
	PYDM VARCHAR2(30),
	-- 备份时间
	BACKUP_DATE TIMESTAMP NOT NULL
);


-- 用户操作日志
CREATE TABLE SYS_USER_LOG
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 时间
	LOG_START TIMESTAMP NOT NULL,
	-- 备份类别 0：开始，1：结束  2：异常
	LOG_TYPE CHAR(1) NOT NULL,
	-- 备注 出现操作异常或其他信息的标注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 文件管理
CREATE TABLE WS_FILES
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 文件标题
	FILE_TITLE VARCHAR2(1200) NOT NULL,
	-- 文件
	FILE_NAMES VARCHAR2(2100),
	-- 文件路径
	FILE_PATH VARCHAR2(2100) NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 新闻信息
CREATE TABLE WS_NEWS
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 新闻标题
	NEWS_TITLE VARCHAR2(300) NOT NULL,
	-- 新闻内容
	NEWS_CONTENT CLOB NOT NULL,
	-- 是否置顶，0：不置顶，1：置顶
	NEWS_TOP CHAR(1) DEFAULT '0',
	-- 排序
	NEWS_SORT NUMBER(10,0) DEFAULT 0,
	-- 置顶开始时间
	TOP_START DATE,
	-- 置顶结束时间
	TOP_END DATE,
	-- 点击次数
	NEWS_CLICK NUMBER(5) DEFAULT 0 NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);


-- 岗位信息
CREATE TABLE WS_POST
(
	-- 主键
	ID VARCHAR2(64) NOT NULL,
	-- 岗位名称
	POST_NAME VARCHAR2(60) NOT NULL,
	-- 排序
	POST_SORT NUMBER(10,0) NOT NULL,
	-- 是否显示,0:显示，1：不显示
	IS_VIEW CHAR(1) DEFAULT '0' NOT NULL,
	-- 创建者
	CREATE_BY VARCHAR2(64) NOT NULL,
	-- 创建时间
	CREATE_DATE TIMESTAMP NOT NULL,
	-- 更新者
	UPDATE_BY VARCHAR2(64) NOT NULL,
	-- 更新时间
	UPDATE_DATE TIMESTAMP NOT NULL,
	-- 删除标记,0：正常，1：删除
	DEL_FLAG CHAR(1) DEFAULT '0' NOT NULL,
	-- 备注
	REMARKS VARCHAR2(900),
	PRIMARY KEY (ID)
);



/* Create Indexes */

CREATE INDEX SYS_OFFICE_PARENT_ID ON SYS_OFFICE_BACKUP ();
CREATE INDEX SYS_OFFICE_PARENT_IDS ON SYS_OFFICE_BACKUP ();
CREATE INDEX SYS_OFFICE_DEL_FLAG ON SYS_OFFICE_BACKUP ();
CREATE INDEX SYS_OFFICE_TYPE ON SYS_OFFICE_BACKUP (TYPE);
CREATE INDEX SYS_USER_OFFICE_ID ON SYS_USER_BACKUP (OFFICE_ID);
CREATE INDEX SYS_USER_LOGIN_NAME ON SYS_USER_BACKUP (LOGIN_NAME);
CREATE INDEX SYS_USER_COMPANY_ID ON SYS_USER_BACKUP (COMPANY_ID);
CREATE INDEX SYS_USER_UPDATE_DATE ON SYS_USER_BACKUP ();
CREATE INDEX SYS_USER_DEL_FLAG ON SYS_USER_BACKUP ();



/* Comments */

COMMENT ON TABLE FILE_ATTACH IS '附件信息';
COMMENT ON COLUMN FILE_ATTACH.ID IS '主键';
COMMENT ON COLUMN FILE_ATTACH.FILE_ONAME IS '文件名';
COMMENT ON COLUMN FILE_ATTACH.FILE_NAME IS '新文件名';
COMMENT ON COLUMN FILE_ATTACH.FILE_EXT IS '文件扩展名';
COMMENT ON COLUMN FILE_ATTACH.FILE_TYPE IS '附件类型
            如：邮件附件';
COMMENT ON COLUMN FILE_ATTACH.TOTAL_BYTES IS '文件大小';
COMMENT ON COLUMN FILE_ATTACH.FILE_PATH IS '文件存放路径';
COMMENT ON COLUMN FILE_ATTACH.CREATE_BY IS '创建者';
COMMENT ON COLUMN FILE_ATTACH.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN FILE_ATTACH.UPDATE_BY IS '更新者';
COMMENT ON COLUMN FILE_ATTACH.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN FILE_ATTACH.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN FILE_ATTACH.REMARKS IS '备注';
COMMENT ON TABLE FILE_HISTORY IS '文件下载记录';
COMMENT ON COLUMN FILE_HISTORY.ID IS '主键';
COMMENT ON COLUMN FILE_HISTORY.FILE_ID IS '下载文件主键';
COMMENT ON COLUMN FILE_HISTORY.FILE_DOWNLOAD IS '下载者';
COMMENT ON COLUMN FILE_HISTORY.FILE_NAME IS '下载文件名';
COMMENT ON COLUMN FILE_HISTORY.CREATE_BY IS '创建者';
COMMENT ON COLUMN FILE_HISTORY.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN FILE_HISTORY.UPDATE_BY IS '更新者';
COMMENT ON COLUMN FILE_HISTORY.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN FILE_HISTORY.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN FILE_HISTORY.REMARKS IS '备注';
COMMENT ON TABLE FILE_RELEASED IS '文件发布范围';
COMMENT ON COLUMN FILE_RELEASED.ID IS '主键';
COMMENT ON COLUMN FILE_RELEASED.FILE_ID IS '文件主键';
COMMENT ON COLUMN FILE_RELEASED.FILE_SHARE IS '文件共享人，文件查看权，单个人共享';
COMMENT ON COLUMN FILE_RELEASED.FILE_GRANTEE IS '文件授权者，共享文件的人（文件拥有人）';
COMMENT ON COLUMN FILE_RELEASED.FILE_DOWNLOAD IS '文件下载权，是否拥有文件下载权，0：有，1：无';
COMMENT ON COLUMN FILE_RELEASED.FILE_EDIT IS '文件修改权，0：有，1：无';
COMMENT ON COLUMN FILE_RELEASED.FILE_DEP IS '共享文件到部门';
COMMENT ON COLUMN FILE_RELEASED.CREATE_BY IS '创建者';
COMMENT ON COLUMN FILE_RELEASED.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN FILE_RELEASED.UPDATE_BY IS '更新者';
COMMENT ON COLUMN FILE_RELEASED.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN FILE_RELEASED.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN FILE_RELEASED.REMARKS IS '备注';
COMMENT ON TABLE HLS_FILE IS '文件保存信息';
COMMENT ON COLUMN HLS_FILE.ID IS '主键';
COMMENT ON COLUMN HLS_FILE.FILE_NAME IS '文件名';
COMMENT ON COLUMN HLS_FILE.FILE_SNAME IS '存储文件名';
COMMENT ON COLUMN HLS_FILE.FILE_MODULES IS '模块名称';
COMMENT ON COLUMN HLS_FILE.CREATE_BY IS '创建者';
COMMENT ON COLUMN HLS_FILE.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN HLS_FILE.UPDATE_BY IS '更新者';
COMMENT ON COLUMN HLS_FILE.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN HLS_FILE.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN HLS_FILE.REMARKS IS '备注';
COMMENT ON TABLE INTERNAL_RECEIVE IS '消息接收人';
COMMENT ON COLUMN INTERNAL_RECEIVE.ID IS '主键';
COMMENT ON COLUMN INTERNAL_RECEIVE.MSG_ID IS '消息ID';
COMMENT ON COLUMN INTERNAL_RECEIVE.SEND_ID IS '发送人ID';
COMMENT ON COLUMN INTERNAL_RECEIVE.RECEIVE_ID IS '接收人ID';
COMMENT ON COLUMN INTERNAL_RECEIVE.READ_DATE IS '阅读时间';
COMMENT ON COLUMN INTERNAL_RECEIVE.READ_STATE IS '阅读状态,0:未读，1：已读';
COMMENT ON COLUMN INTERNAL_RECEIVE.CREATE_BY IS '创建者';
COMMENT ON COLUMN INTERNAL_RECEIVE.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN INTERNAL_RECEIVE.UPDATE_BY IS '更新者';
COMMENT ON COLUMN INTERNAL_RECEIVE.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN INTERNAL_RECEIVE.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN INTERNAL_RECEIVE.REMARKS IS '备注';
COMMENT ON TABLE MAIL_ATTACH IS '邮件附件';
COMMENT ON COLUMN MAIL_ATTACH.ATTACH_ID IS '附件ID';
COMMENT ON COLUMN MAIL_ATTACH.MAIL_ID IS '邮件ID';
COMMENT ON TABLE MAIL_COMMON IS '邮件常用联系人';
COMMENT ON COLUMN MAIL_COMMON.ID IS '主键';
COMMENT ON COLUMN MAIL_COMMON.LINK_USER IS '联系人ID';
COMMENT ON COLUMN MAIL_COMMON.CREATE_BY IS '创建者';
COMMENT ON COLUMN MAIL_COMMON.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN MAIL_COMMON.UPDATE_BY IS '更新者';
COMMENT ON COLUMN MAIL_COMMON.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN MAIL_COMMON.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN MAIL_COMMON.REMARKS IS '备注';
COMMENT ON TABLE MAIL_RECEIVE IS '邮件接收者信息';
COMMENT ON COLUMN MAIL_RECEIVE.ID IS '主键';
COMMENT ON COLUMN MAIL_RECEIVE.MAIL_RECEIVE IS '邮件接收者';
COMMENT ON COLUMN MAIL_RECEIVE.MAIL_ID IS '邮件主键';
COMMENT ON COLUMN MAIL_RECEIVE.MAIL_SENDER IS '发送者主键';
COMMENT ON COLUMN MAIL_RECEIVE.MAIL_STATE IS '阅读状态,0:未读，1：已读';
COMMENT ON COLUMN MAIL_RECEIVE.READ_DATE IS '阅读时间';
COMMENT ON COLUMN MAIL_RECEIVE.IS_DEL IS '删除标记,0:正常，1：删除';
COMMENT ON TABLE MAIL_SEND IS '邮件发送信息';
COMMENT ON COLUMN MAIL_SEND.ID IS '主键';
COMMENT ON COLUMN MAIL_SEND.MAIL_ID IS '邮件主键';
COMMENT ON COLUMN MAIL_SEND.SEND_ID IS '发送者ID';
COMMENT ON COLUMN MAIL_SEND.IS_DEL IS '是否删除，0：正常，1：删除';
COMMENT ON COLUMN MAIL_SEND.SEND_DATE IS '发送时间';
COMMENT ON COLUMN MAIL_SEND.CREATE_BY IS '创建者';
COMMENT ON COLUMN MAIL_SEND.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN MAIL_SEND.UPDATE_BY IS '更新者';
COMMENT ON COLUMN MAIL_SEND.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN MAIL_SEND.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN MAIL_SEND.REMARKS IS '备注';
COMMENT ON TABLE MSG_EMAIL IS '内部邮件';
COMMENT ON COLUMN MSG_EMAIL.ID IS '主键';
COMMENT ON COLUMN MSG_EMAIL.MAIL_ACCEPTOR IS '邮件接收者,多个接收者中间用‘,’分割';
COMMENT ON COLUMN MSG_EMAIL.ACCEPTOR_NAMES IS '接收者姓名';
COMMENT ON COLUMN MSG_EMAIL.MAIL_TITLE IS '邮件标题';
COMMENT ON COLUMN MSG_EMAIL.MAIL_CONTENT IS '邮件内容';
COMMENT ON COLUMN MSG_EMAIL.FILE_NAMES IS '文件名称';
COMMENT ON COLUMN MSG_EMAIL.FILE_PATH IS '附件路径';
COMMENT ON COLUMN MSG_EMAIL.IS_REMIND IS '是否提醒,0:提醒，1：不提醒';
COMMENT ON COLUMN MSG_EMAIL.IS_SEND IS '是否发送,0:发送，1：草稿，2：撤回';
COMMENT ON COLUMN MSG_EMAIL.SEND_DATE IS '发送时间';
COMMENT ON COLUMN MSG_EMAIL.DRAFT_DATE IS '存稿时间';
COMMENT ON COLUMN MSG_EMAIL.IS_DEL IS '是否删除,0:正常，1：删除';
COMMENT ON COLUMN MSG_EMAIL.CREATE_BY IS '创建者';
COMMENT ON COLUMN MSG_EMAIL.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN MSG_EMAIL.UPDATE_BY IS '更新者';
COMMENT ON COLUMN MSG_EMAIL.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN MSG_EMAIL.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN MSG_EMAIL.REMARKS IS '备注';
COMMENT ON TABLE MSG_INTERNAL IS '内部消息';
COMMENT ON COLUMN MSG_INTERNAL.ID IS '主键';
COMMENT ON COLUMN MSG_INTERNAL.ACCEPTOR_NAME IS '接收人名称';
COMMENT ON COLUMN MSG_INTERNAL.ACCEPTOR IS '收信人';
COMMENT ON COLUMN MSG_INTERNAL.MSG_CONTENT IS '消息内容';
COMMENT ON COLUMN MSG_INTERNAL.MSG_TYPE IS '消息类别,0:消息，1：系统通知';
COMMENT ON COLUMN MSG_INTERNAL.BACK_DATE IS '撤回时间';
COMMENT ON COLUMN MSG_INTERNAL.MSG_STATE IS '消息状态,0:发送，1：撤回';
COMMENT ON COLUMN MSG_INTERNAL.CREATE_BY IS '创建者';
COMMENT ON COLUMN MSG_INTERNAL.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN MSG_INTERNAL.UPDATE_BY IS '更新者';
COMMENT ON COLUMN MSG_INTERNAL.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN MSG_INTERNAL.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN MSG_INTERNAL.REMARKS IS '备注';
COMMENT ON TABLE MSG_REMIND IS '消息提醒设置';
COMMENT ON COLUMN MSG_REMIND.ID IS '主键';
COMMENT ON COLUMN MSG_REMIND.REMIND_NOTICE IS '公告提醒，0：提醒，1：不提醒';
COMMENT ON COLUMN MSG_REMIND.REMIND_MSG IS '站内消息提醒，0：提醒，1：不提醒';
COMMENT ON COLUMN MSG_REMIND.CREATE_BY IS '创建者';
COMMENT ON COLUMN MSG_REMIND.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN MSG_REMIND.UPDATE_BY IS '更新者';
COMMENT ON COLUMN MSG_REMIND.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN MSG_REMIND.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN MSG_REMIND.REMARKS IS '备注';
COMMENT ON TABLE NEWS_HISTORY IS '新闻阅读历史';
COMMENT ON COLUMN NEWS_HISTORY.ID IS '主键';
COMMENT ON COLUMN NEWS_HISTORY.NEWS_ID IS '新闻主键';
COMMENT ON COLUMN NEWS_HISTORY.NEWS_READER IS '阅读者';
COMMENT ON COLUMN NEWS_HISTORY.READ_DATE IS '阅读时间';
COMMENT ON COLUMN NEWS_HISTORY.READ_NUM IS '阅读次数';
COMMENT ON COLUMN NEWS_HISTORY.CREATE_BY IS '创建者';
COMMENT ON COLUMN NEWS_HISTORY.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN NEWS_HISTORY.UPDATE_BY IS '更新者';
COMMENT ON COLUMN NEWS_HISTORY.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN NEWS_HISTORY.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN NEWS_HISTORY.REMARKS IS '备注';
COMMENT ON TABLE NOTICE_TYPE IS '公告类别';
COMMENT ON COLUMN NOTICE_TYPE.ID IS '主键';
COMMENT ON COLUMN NOTICE_TYPE.NT_NAME IS '类别名称';
COMMENT ON COLUMN NOTICE_TYPE.NT_FILE IS '图片路径';
COMMENT ON COLUMN NOTICE_TYPE.CREATE_BY IS '创建者';
COMMENT ON COLUMN NOTICE_TYPE.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN NOTICE_TYPE.UPDATE_BY IS '更新者';
COMMENT ON COLUMN NOTICE_TYPE.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN NOTICE_TYPE.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN NOTICE_TYPE.REMARKS IS '备注';
COMMENT ON TABLE SYS_OFFICE_BACKUP IS '医院科室备份';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.ID IS '编号';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.AREA_ID IS '归属区域';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.CODE IS '区域编码';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.TYPE IS '机构类型（1：公司；2：部门；3：小组）';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.GRADE IS '机构等级（1：一级；2：二级；3：三级；4：四级）';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.ADDRESS IS '联系地址';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.ZIP_CODE IS '邮政编码';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.MASTER IS '负责人';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.PHONE IS '电话';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.FAX IS '传真';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.EMAIL IS '邮箱';
COMMENT ON COLUMN SYS_OFFICE_BACKUP.BACKUP_DATE IS '备份时间';
COMMENT ON TABLE SYS_OFFICE_LOG IS '部门操作日志';
COMMENT ON COLUMN SYS_OFFICE_LOG.ID IS '主键';
COMMENT ON COLUMN SYS_OFFICE_LOG.LOG_START IS '时间';
COMMENT ON COLUMN SYS_OFFICE_LOG.LOG_TYPE IS '备份类别 0：开始，1：结束  2：异常';
COMMENT ON COLUMN SYS_OFFICE_LOG.REMARKS IS '备注 出现操作异常或其他信息的标注';
COMMENT ON TABLE SYS_USER_BACKUP IS '用户表数据备份';
COMMENT ON COLUMN SYS_USER_BACKUP.ID IS '编号';
COMMENT ON COLUMN SYS_USER_BACKUP.COMPANY_ID IS '归属公司';
COMMENT ON COLUMN SYS_USER_BACKUP.OFFICE_ID IS '归属部门';
COMMENT ON COLUMN SYS_USER_BACKUP.LOGIN_NAME IS '登录名';
COMMENT ON COLUMN SYS_USER_BACKUP.PASSWORD IS '密码';
COMMENT ON COLUMN SYS_USER_BACKUP.NO IS '工号';
COMMENT ON COLUMN SYS_USER_BACKUP.NAME IS '姓名';
COMMENT ON COLUMN SYS_USER_BACKUP.EMAIL IS '邮箱';
COMMENT ON COLUMN SYS_USER_BACKUP.PHONE IS '电话';
COMMENT ON COLUMN SYS_USER_BACKUP.MOBILE IS '手机';
COMMENT ON COLUMN SYS_USER_BACKUP.USER_TYPE IS '用户类型';
COMMENT ON COLUMN SYS_USER_BACKUP.LOGIN_IP IS '最后登陆IP';
COMMENT ON COLUMN SYS_USER_BACKUP.LOGIN_DATE IS '最后登陆时间';
COMMENT ON COLUMN SYS_USER_BACKUP.PYDM IS '拼音码';
COMMENT ON COLUMN SYS_USER_BACKUP.BACKUP_DATE IS '备份时间';
COMMENT ON TABLE SYS_USER_LOG IS '用户操作日志';
COMMENT ON COLUMN SYS_USER_LOG.ID IS '主键';
COMMENT ON COLUMN SYS_USER_LOG.LOG_START IS '时间';
COMMENT ON COLUMN SYS_USER_LOG.LOG_TYPE IS '备份类别 0：开始，1：结束  2：异常';
COMMENT ON COLUMN SYS_USER_LOG.REMARKS IS '备注 出现操作异常或其他信息的标注';
COMMENT ON TABLE WS_FILES IS '文件管理';
COMMENT ON COLUMN WS_FILES.ID IS '主键';
COMMENT ON COLUMN WS_FILES.FILE_TITLE IS '文件标题';
COMMENT ON COLUMN WS_FILES.FILE_NAMES IS '文件';
COMMENT ON COLUMN WS_FILES.FILE_PATH IS '文件路径';
COMMENT ON COLUMN WS_FILES.CREATE_BY IS '创建者';
COMMENT ON COLUMN WS_FILES.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN WS_FILES.UPDATE_BY IS '更新者';
COMMENT ON COLUMN WS_FILES.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN WS_FILES.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN WS_FILES.REMARKS IS '备注';
COMMENT ON TABLE WS_NEWS IS '新闻信息';
COMMENT ON COLUMN WS_NEWS.ID IS '主键';
COMMENT ON COLUMN WS_NEWS.NEWS_TITLE IS '新闻标题';
COMMENT ON COLUMN WS_NEWS.NEWS_CONTENT IS '新闻内容';
COMMENT ON COLUMN WS_NEWS.NEWS_TOP IS '是否置顶，0：不置顶，1：置顶';
COMMENT ON COLUMN WS_NEWS.NEWS_SORT IS '排序';
COMMENT ON COLUMN WS_NEWS.TOP_START IS '置顶开始时间';
COMMENT ON COLUMN WS_NEWS.TOP_END IS '置顶结束时间';
COMMENT ON COLUMN WS_NEWS.NEWS_CLICK IS '点击次数';
COMMENT ON COLUMN WS_NEWS.CREATE_BY IS '创建者';
COMMENT ON COLUMN WS_NEWS.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN WS_NEWS.UPDATE_BY IS '更新者';
COMMENT ON COLUMN WS_NEWS.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN WS_NEWS.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN WS_NEWS.REMARKS IS '备注';
COMMENT ON TABLE WS_POST IS '岗位信息';
COMMENT ON COLUMN WS_POST.ID IS '主键';
COMMENT ON COLUMN WS_POST.POST_NAME IS '岗位名称';
COMMENT ON COLUMN WS_POST.POST_SORT IS '排序';
COMMENT ON COLUMN WS_POST.IS_VIEW IS '是否显示,0:显示，1：不显示';
COMMENT ON COLUMN WS_POST.CREATE_BY IS '创建者';
COMMENT ON COLUMN WS_POST.CREATE_DATE IS '创建时间';
COMMENT ON COLUMN WS_POST.UPDATE_BY IS '更新者';
COMMENT ON COLUMN WS_POST.UPDATE_DATE IS '更新时间';
COMMENT ON COLUMN WS_POST.DEL_FLAG IS '删除标记,0：正常，1：删除';
COMMENT ON COLUMN WS_POST.REMARKS IS '备注';



