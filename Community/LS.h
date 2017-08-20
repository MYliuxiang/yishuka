//
//  LS.h
//  Community
//
//  Created by 未来社区 on 16/6/20.
//  Copyright © 2016年 李江. All rights reserved.
//

#ifndef LS_h
#define LS_h

//185-0033-5907 小宛电话

#import "ZLPhoto.h"
#import "JPUSHService.h"
//老师
//15881888155
//15528888252
//18728414122
//学生
//15583369555
//13086327277
//15181899668
//密码就是账号，一样的


//友盟
//http://www.umeng.com/
//帐号：yishuka_1@163.com
//密码：yishuka123
//
//极光推送
//https://www.jpush.cn/
//帐号：yishuka_1@163.com
//密码：yishuka123


//shenxin4@hotmail.com
//Shenxin123,.!



#define  YOUPAINOTICE         @"youpainotice"      //消息推送

#define birthday   @"birthday"
#define Address    @"address"
#define Description @"Description"


//头像主URL
#define  URL_photoUser                   @"http://123.57.8.68/"


#define  URL_getRegCode                 Main_URL@"getRegCode" //获取验证码
#define  URL_login                      Main_URL@"login" //登录
#define  URL_updateMemberInfo           Main_URL@"updateMemberInfo" //修改用户信息
#define  URL_shangchuan                 @"http://123.57.8.68/index.php?m=Api&c=WebService&a=uploadImgApp"
#define  URL_agencyApplySub             Main_URL@"agencyApplySub"  //我要应聘
#define  URL_agencyInfoCommentList      Main_URL@"agencyInfoCommentList" //评论列表
#define  URL_agencyCommentSub           Main_URL@"agencyCommentSub" //发表评论
#define  URL_agencyClassList            Main_URL@"agencyClassList" //班级列表
#define  URL_shiping                    @"http://123.57.8.68/index.php?m=Api&c=WebService&a=uploadMp4App"//上传视频

#define  URL_courseMp4Sub               Main_URL@"courseMp4Sub" //上传回课详情
#define  URL_getTeacherAgency           Main_URL@"getTeacherAgency" //机构列表
#define  URL_getTeacherAgencyClass      Main_URL@"getTeacherAgencyClass" //所属班级列表
#define  URL_infoAddSub                 Main_URL@"infoAddSub" //添加通告
#define  URL_infoUpdatePage             Main_URL@"infoUpdatePage" //修改通告
#define  URL_infoUpdateSub              Main_URL@"infoUpdateSub" //上传修改通告
#define  URL_infoDel                    Main_URL@"infoDel" //删除
#define  URL_ClassSignSub               Main_URL@"ClassSignSub"//班级报名
#define  URL_login                      Main_URL@"login" //找回密码
#define  URL_getNoteNews                Main_URL@"getNoteNews" //私信

#define  URL_editMemberPassword                      Main_URL@"editMemberPassword" //修改密码



#define weakSelf(weakSelf) __weak typeof(self) weakSelf = self


#endif /* LS_h */
