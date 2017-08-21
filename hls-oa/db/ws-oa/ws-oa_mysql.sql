SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE file_history;
DROP TABLE file_released;
DROP TABLE internal_receive;
DROP TABLE mail_receive;
DROP TABLE mail_send;
DROP TABLE msg_email;
DROP TABLE msg_internal;
DROP TABLE msg_remind;
DROP TABLE news_history;
DROP TABLE notice_type;
DROP TABLE ws_files;
DROP TABLE ws_news;
DROP TABLE ws_post;




/* Create Tables */

-- 文件下载记录
CREATE TABLE file_history
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 下载文件主键
	file_id varchar(64) NOT NULL COMMENT '下载文件主键',
	-- 下载者
	file_download varchar(64) NOT NULL COMMENT '下载者',
	-- 下载文件名
	file_name varchar(2100) COMMENT '下载文件名',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '文件下载记录';


-- 文件发布范围
CREATE TABLE file_released
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 文件主键
	file_id varchar(64) NOT NULL COMMENT '文件主键',
	-- 文件共享人，文件查看权，单个人共享
	file_share varchar(64) COMMENT '文件共享人，文件查看权，单个人共享',
	-- 文件授权者，共享文件的人（文件拥有人）
	file_grantee varchar(64) NOT NULL COMMENT '文件授权者，共享文件的人（文件拥有人）',
	-- 文件下载权，是否拥有文件下载权，0：有，1：无
	file_download char(1) DEFAULT '0' NOT NULL COMMENT '文件下载权，是否拥有文件下载权，0：有，1：无',
	-- 文件修改权，0：有，1：无
	file_edit char(1) DEFAULT '1' NOT NULL COMMENT '文件修改权，0：有，1：无',
	-- 共享文件到部门
	file_dep varchar(64) COMMENT '共享文件到部门',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '文件发布范围';


-- 消息接收人
CREATE TABLE internal_receive
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 消息ID
	msg_id varchar(64) NOT NULL COMMENT '消息ID',
	-- 发送人ID
	send_id varchar(64) NOT NULL COMMENT '发送人ID',
	-- 接收人ID
	receive_id varchar(64) NOT NULL COMMENT '接收人ID',
	-- 阅读时间
	read_date date COMMENT '阅读时间',
	-- 阅读状态,0:未读，1：已读
	read_state char(1) DEFAULT '0' NOT NULL COMMENT '阅读状态,0:未读，1：已读',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '消息接收人';


-- 邮件接收者信息
CREATE TABLE mail_receive
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 邮件接收者
	mail_receive varchar(64) NOT NULL COMMENT '邮件接收者',
	-- 邮件主键
	mail_id varchar(64) NOT NULL COMMENT '邮件主键',
	-- 发送者主键
	mail_sender varchar(64) NOT NULL COMMENT '发送者主键',
	-- 阅读状态,0:未读，1：已读
	mail_state varchar(1) DEFAULT '0' NOT NULL COMMENT '阅读状态,0:未读，1：已读',
	-- 阅读时间
	read_date date COMMENT '阅读时间',
	-- 删除标记,0:正常，1：删除
	is_del char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0:正常，1：删除',
	PRIMARY KEY (id)
) COMMENT = '邮件接收者信息';


-- 邮件发送信息
CREATE TABLE mail_send
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 邮件主键
	mail_id varchar(64) NOT NULL COMMENT '邮件主键',
	-- 发送者ID
	send_id varchar(64) NOT NULL COMMENT '发送者ID',
	-- 是否删除，0：正常，1：删除
	is_del char(1) DEFAULT '0' NOT NULL COMMENT '是否删除，0：正常，1：删除',
	-- 发送时间
	send_date date NOT NULL COMMENT '发送时间',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '邮件发送信息';


-- 内部邮件
CREATE TABLE msg_email
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 邮件接收者,多个接收者中间用‘,’分割
	mail_acceptor varchar(6000) NOT NULL COMMENT '邮件接收者,多个接收者中间用‘,’分割',
	-- 接收者姓名
	acceptor_names varchar(4000) NOT NULL COMMENT '接收者姓名',
	-- 邮件标题
	mail_title varchar(300) NOT NULL COMMENT '邮件标题',
	-- 邮件内容
	mail_content text NOT NULL COMMENT '邮件内容',
	-- 文件名称
	file_names varchar(6000) COMMENT '文件名称',
	-- 附件路径
	file_path varchar(6000) COMMENT '附件路径',
	-- 是否提醒,0:提醒，1：不提醒
	is_remind char(1) DEFAULT '1' NOT NULL COMMENT '是否提醒,0:提醒，1：不提醒',
	-- 是否发送,0:发送，1：草稿，2：撤回
	is_send char(1) DEFAULT '1' NOT NULL COMMENT '是否发送,0:发送，1：草稿，2：撤回',
	-- 发送时间
	send_date date COMMENT '发送时间',
	-- 存稿时间
	draft_date date NOT NULL COMMENT '存稿时间',
	-- 是否删除,0:正常，1：删除
	is_del char(1) DEFAULT '0' NOT NULL COMMENT '是否删除,0:正常，1：删除',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '内部邮件';


-- 内部消息
CREATE TABLE msg_internal
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 接收人名称
	acceptor_name varchar(3000) NOT NULL COMMENT '接收人名称',
	-- 收信人
	acceptor varchar(6400) NOT NULL COMMENT '收信人',
	-- 消息内容
	msg_content varchar(3000) NOT NULL COMMENT '消息内容',
	-- 消息类别,0:消息，1：系统通知
	msg_type varchar(1) DEFAULT '0' NOT NULL COMMENT '消息类别,0:消息，1：系统通知',
	-- 撤回时间
	back_date date COMMENT '撤回时间',
	-- 消息状态,0:发送，1：撤回
	msg_state char(1) DEFAULT '0' NOT NULL COMMENT '消息状态,0:发送，1：撤回',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '内部消息';


-- 消息提醒设置
CREATE TABLE msg_remind
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 公告提醒，0：提醒，1：不提醒
	remind_notice char(1) DEFAULT '1' NOT NULL COMMENT '公告提醒，0：提醒，1：不提醒',
	-- 站内消息提醒，0：提醒，1：不提醒
	remind_msg char(1) DEFAULT '0' NOT NULL COMMENT '站内消息提醒，0：提醒，1：不提醒',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '消息提醒设置';


-- 新闻阅读历史
CREATE TABLE news_history
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 新闻主键
	news_id varchar(64) NOT NULL COMMENT '新闻主键',
	-- 阅读者
	news_reader varchar(64) NOT NULL COMMENT '阅读者',
	-- 阅读时间
	read_date date NOT NULL COMMENT '阅读时间',
	-- 阅读次数
	read_num numeric(3) DEFAULT 0 NOT NULL COMMENT '阅读次数',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '新闻阅读历史';


-- 公告类别
CREATE TABLE notice_type
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 类别名称
	nt_name varchar(60) NOT NULL COMMENT '类别名称',
	-- 图片路径
	nt_file varchar(200) COMMENT '图片路径',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '公告类别';


-- 文件管理
CREATE TABLE ws_files
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 文件标题
	file_title varchar(1200) NOT NULL COMMENT '文件标题',
	-- 文件
	file_names varchar(2100) COMMENT '文件',
	-- 文件路径
	file_path varchar(2100) NOT NULL COMMENT '文件路径',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '文件管理';


-- 新闻信息
CREATE TABLE ws_news
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 新闻标题
	news_title varchar(300) NOT NULL COMMENT '新闻标题',
	-- 新闻内容
	news_content text NOT NULL COMMENT '新闻内容',
	-- 是否置顶，0：不置顶，1：置顶
	news_top char(1) DEFAULT '0' COMMENT '是否置顶，0：不置顶，1：置顶',
	-- 排序
	news_sort numeric(10,0) DEFAULT 0 COMMENT '排序',
	-- 置顶开始时间
	top_start date COMMENT '置顶开始时间',
	-- 置顶结束时间
	top_end date COMMENT '置顶结束时间',
	-- 点击次数
	news_click decimal(5) DEFAULT 0 NOT NULL COMMENT '点击次数',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '新闻信息';


-- 岗位信息
CREATE TABLE ws_post
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 岗位名称
	post_name varchar(60) NOT NULL COMMENT '岗位名称',
	-- 排序
	post_sort numeric(10,0) NOT NULL COMMENT '排序',
	-- 是否显示,0:显示，1：不显示
	is_view char(1) DEFAULT '0' NOT NULL COMMENT '是否显示,0:显示，1：不显示',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date timestamp NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date timestamp NOT NULL COMMENT '更新时间',
	-- 删除标记,0：正常，1：删除
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记,0：正常，1：删除',
	-- 备注
	remarks varchar(900) COMMENT '备注',
	PRIMARY KEY (id)
) COMMENT = '岗位信息';



