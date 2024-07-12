import 'package:angel_eats_test/constants/gaps.dart';
import 'package:angel_eats_test/features/edit/views/widgets/edit_list_item.dart';
import 'package:flutter/material.dart';

class EditMenuModel {
  final String path;
  final String title;
  final Widget? subtitleWidget;
  final Widget? contentWidget;

  EditMenuModel({
    required this.path,
    required this.title,
    this.subtitleWidget,
    this.contentWidget,
  });
}

class EditScreen extends StatelessWidget {
  static String routeName = "edit";
  static String routeURL = "/edit";

  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<EditMenuModel> editList = [
      EditMenuModel(
        path: "",
        title: "닉네임",
        contentWidget: const Text("Nickname"),
      ),
      EditMenuModel(
        path: "",
        title: "이름",
        subtitleWidget: const Text(
          "본인인증 후 이름을 업데이트해 주세요",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
      EditMenuModel(
        path: "",
        title: "대표 이메일",
        contentWidget: const Text("abc@aa.com"),
      ),
      EditMenuModel(
        path: "",
        title: "비밀번호 변경",
      ),
      EditMenuModel(
        path: "",
        title: "휴대폰 번호 변경",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보 수정"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 25,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v10,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return EditListItem(
                          title: editList[index].title,
                          subtitleWidget: editList[index].subtitleWidget,
                          contentWidget: editList[index].contentWidget,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          height: 1,
                          color: colorScheme.primary.withOpacity(.2),
                        );
                      },
                      itemCount: editList.length,
                    ),
                  ),
                  Gaps.v10,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const EditListItem(
                      title: "로그인 기기 관리",
                      subtitleWidget: Text(
                        "본인인증 후 이름을 업데이트해 주세요",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const EditListItem(
                      title: "연동된 소셜 계정",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("로그아웃"),
                  SizedBox(
                    height: 12,
                    child: VerticalDivider(
                      color: colorScheme.primary.withOpacity(.2),
                    ),
                  ),
                  const Text("회원탈퇴"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
