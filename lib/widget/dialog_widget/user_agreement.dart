import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';

class UserAgreement extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 120.w,left: 40.w,right: 40.w),
      child:Stack(
        children: [
          Column(
            children: [
              Text('用户协议',
                style: TextStyle(
                    fontSize: 48.sp,
                    color: Colours.text_333,
                    fontWeight: FontWeight.w700
                ),),
              SizedBox(height: 24.w,),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 56.w),
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Scrollbar(
                      child: SingleChildScrollView(child: Text('''记账鲜生用户协议
发布日期：2024-01-18
生效日期：2024-01-18
欢迎阅读记账鲜生服务条款协议(下称“本协议”)。本协议阐述之条款和条件适用于您使用的记账鲜生所提供 的各种工具和服务(下称“服务”)。

1. 接受条款

以任何方式使用记账鲜生服务即表示您同意自己与记账鲜生订立本协议，且您将受本协议的条款和条件(“条款”) 约束。 记账鲜生可随时自行决定修订本协议“条款”。您应在条款修改后第一次登录时仔细阅读修订后的“条款”，如您对修订后的条款有异议，您有权选择停止继续使用“服务”； 一旦您继续使用“服务”，则表示您已接受经修订的“条款”，当您与记账鲜生发生争议时，应以最新的服务协议为准。 除另行明确声明外，任何使“服务”范围扩大或功能增强的新内容均受本协议约束。除非经记账鲜生的授权高层管理人员签订书面协议，本协议不得另行作出修订。

2. 谁可使用记账鲜生

“服务”仅供能够根据相关法律订立具有法律约束力的合约的个人或公司、个体工商户等形式的企业使用。因此，您的年龄必须在十八周岁或以上，才可使用本公司服务。如不符合本项条件，请勿使用“服务”。记账鲜生可随时自行全权决定拒绝向任何人士提供“服务”。“服务”不会提供给 被暂时或永久中止资格的记账鲜生用户。

3. 您的资料和供买卖的物品

“您的资料”包括您在注册、交易或列举物品过程中、在任何公开信息场合或通过任何电子邮件形式，向本公司或其他用户提供的任何资料，包括数据、文本、软件、 音乐、声响、照片、图画、影像、词句或其他材料。您应对“您的资料”负全部责任，而本公司仅作为您在网上发布和刊登“您的资料”的被动渠道。但是，倘若本公司 认为“您的资料”可能使本公司承担任何法律或道义上的责任，或可能使本公司 (全部或部分地) 失去本公司的互联网服务供应商或其他供应商的服务，或您未在 记账鲜生规定的期限内登录或再次登录网站，则本公司可自行全权决定对“您的资料”采取本公司认为必要或适当的任何行动，包括但不限于删除该类资料。 您特此保证，您对提交给记账鲜生的“您的资料”拥有全部权利，包括全部版权。您确认，记账鲜生没有责任去认定或决定您提交给本公司的资料哪些是应当受到 保护的，对享有“服务”的其他用户使用“您的资料”，本公司也不必负责。

3.1 注册义务

如您在记账鲜生注册，您同意：维持并及时更新会员资料，使其保持真实、准确、完整和反映当前情况。倘若您提供任何不真实、不准确、不完整或不能反映当前情况的资料，或记账鲜生有 合理理由怀疑该等资料不真实、不准确、不完整或不能反映当前情况，记账鲜生有权暂停或终止您的注册身份及资料，并拒绝您在目前或将来对“服务”(或其任何部份) 以任何形式使用。 您同意，记账鲜生可向您提交的注册信息中包含的电话、手机号码，电子邮箱发送商业类广告信息。

3.2 会员注册名、密码和保密

在登记过程中，您将选择会员注册名和密码。您须自行负责对您的会员注册名和密码保密，且须对您在会员注册名和密码下发生的所有活动承担责任。您同意： (a) 如发现任何人未经授权使用您的会员注册名或密码，或发生违反保密规定的任何其他情况，您会立即通知记账鲜生； 及 (b) 确保您在每个上网时段结束时，以正确步骤离开网站或客户端。 记账鲜生不能也不会对因您未能遵守本款规定而发生的任何损失或损毁负责。


4. 您授予本公司的许可使用权

您授予记账鲜生独家的、全球通用的、永久的、免费的许可使用权利 (并有权在多个层面对该权利进行再授权)，使本我们有权(全部或部份地) 使用、 复制、修订、改写、发布、翻译、分发、执行和展示"您的资料"或制作其派生作品，和/或以现在已知或日后开发的任何形式、媒体或技术，将"您的资料"纳入其他作品内。


在不透露单个用户隐私资料的前提下，我们有权对整个用户数据库进行推演、计算、分析、梳理、挖掘应用，并在此基础上 对用户数据库进行商业上的利用。我们保证不对外公开或向第三方提供可能体现出单个用户的信息资料及用户在使用网络服务时存储在我们处的非公开内容。

5. 隐私

尽管有第4条所规定的许可使用权，记账鲜生将仅根据本公司的隐私声明使用“您的资料”。我们隐私声明的全部条款属于本协议的一部份，因此，您必须仔细阅读。 

6. 终止或访问限制

您同意，在记账鲜生未向您收费的情况下，记账鲜生可自行全权决定以任何理由 (包括但不限于记账鲜生认为您已违反本协议的字面意义和精神，或您以不符合 本协议的字面意义和精神的方式行事，或您在超过90天的时间内未以您的账号及密码登录网站) 终止您的“服务”密码、账户 (或其任何部份) 或您对“服务”的使用， 并删除和丢弃您在使用“服务”中提交的 “您的资料”。您同意，在记账鲜生向您收费的情况下，记账鲜生应基于合理的怀疑且经电子邮件通知的情况下实施上述终 止服务的行为。记账鲜生同时可自行全权决定，在发出通知或不发出通知的情况下，随时停止提供“服务”或其任何部份。您同意，根据本协议的任何规定终止您使用 “服务”之措施可在不发出事先通知的情况下实施，并承认和同意，记账鲜生可立即使您的账户无效，或撤销您的账户以及在您的账户内的所有相关资料和档案， 和/或禁止您进一步接入该等档案或“服务”。 账号终止后，记账鲜生没有义务为您保留原账号中或与之相关的任何信息，或转发任何未曾阅读或发送的信息给您或第三方。此外，您同意， 记账鲜生不会就终止您接入“服务”而对您或任何第三者承担任何责任。第5、8各条应在本协议终止后继续有效。


7. 服务“按现状”提供

本公司会尽一切努力使您在使用记账鲜生的过程中得到乐趣。遗憾的是，本公司不能随时预见到任何技术上的问题或其他困难。该等困难可能会导致数据损失或其他服务中断。 为此，您明确理解和同意，您使用“服务”的风险由您自行承担。“服务”以“按现状”和“按可得到”的基础提供。记账鲜生明确声明不作出任何种类的所有明示或暗示的保证， 包括但不限于关于适销性、适用于某一特定用途和无侵权行为等方面的保证。记账鲜生对下述内容不作保证：(i)“服务”会符合您的要求； (ii)“服务”不会中断，且适时、安全和不带任何错误；(iii) 通过使用“服务”而可能获取的结果将是准确或可信赖的； 及 (iv) 您通过“服务”而购买或获取的任何产品、服务、资料或其他材料的质量将符合您的预期。 通过使用“服务”而下载或以其他形式获取任何材料是由您自行全权决定进行的，且与此有关的风险由您自行承担， 对于因您下载任何该等材料而发生的您的电脑系统的任何损毁或任何数据损失，您将自行承担责任。 您从记账鲜生或通过或从“服务”获取的任何口头或书面意见或资料，均不产生未在本协议内明确载明的任何保证。

8. 责任范围

您明确理解和同意，记账鲜生不对因下述任一情况而发生的任何损害赔偿承担责任，包括但不限于利润、商誉、使用、数据等方面的损失或其他无形损失的损害赔偿 (无论记账鲜生是否已被告知该等损害赔偿的可能性)：(i) 使用或未能使用“服务”；(ii) 因通过或从“服务”购买或获取任何货物、样品、数据、资料或服务， 或通过或从“服务”接收任何信息或缔结任何交易所产生的获取替代货物和服务的费用；(iii) 未经批准接入或更改您的传输资料或数据； (iv) 任何第三者对“服务”的声明或关于“服务”的行为；或 (v) 因任何原因而引起的与“服务”有关的任何其他事宜，包括疏忽。

''')),
                    ),
                  ))
            ],
          ),
          Positioned(
              bottom: 0.w,
              right: 20.w,
              left: 20.w,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.primary,
                            foregroundColor: Colors.white),
                        child: Text(
                          '了解了',
                          style: TextStyle(
                              fontSize: 28.sp, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Get.back();
                        }),
                  )
                ],
              ))
        ],
      ) ,
    );
  }
}
