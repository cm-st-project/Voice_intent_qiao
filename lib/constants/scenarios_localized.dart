import 'package:flutter/material.dart';
import '../models/scenario.dart';

class ScenariosLocalized {
  static List<ScenarioCategory> getScenarios(Locale locale) {
    if (locale.languageCode == 'zh') {
      return _getChineseScenarios();
    }
    return _getEnglishScenarios();
  }

  static List<ScenarioCategory> _getEnglishScenarios() {
    return [
      ScenarioCategory(
        name: "Social Rules",
        scenarios: [
          Scenario(
            subcategory: "Turn-taking in conversation",
            description:
                "You're having a conversation with a classmate who is telling a story. You want to add a comment.",
            action: "Wait until they pause or finish, then say your comment.",
            why:
                "Taking turns shows respect and makes conversations enjoyable for both people.",
          ),
          Scenario(
            subcategory: "Personal space",
            description:
                "You're talking to someone, but you're standing very close to them.",
            action: "Step back and leave about an arm's length of space.",
            why:
                "Respecting personal space helps others feel safe and comfortable.",
          ),
          Scenario(
            subcategory: "Greeting others",
            description:
                "You arrive at school and see your teacher and friends.",
            action:
                "Say 'Good morning' or 'Hi!' and make eye contact if you're comfortable.",
            why:
                "Greeting people helps start social interactions in a polite and friendly way.",
          ),
          Scenario(
            subcategory: "Staying on topic",
            description:
                "You're in a conversation about favorite foods, but you want to talk about your pet.",
            action:
                "Wait until the topic changes or ask, 'Can I tell you about my pet later?'",
            why:
                "Staying on topic shows you're listening and helps keep the conversation balanced.",
          ),
          Scenario(
            subcategory: "Interrupting",
            description:
                "Your friend is speaking with another classmate, and you want to say something right away.",
            action: "Say 'Excuse me' and wait for a pause before speaking.",
            why: "Not interrupting shows patience and helps others feel heard.",
          ),
        ],
      ),
      ScenarioCategory(
        name: "Intentions",
        scenarios: [
          Scenario(
            subcategory: "Requesting help",
            description:
                "You can't open your water bottle and you're struggling.",
            action: "Say 'Can you help me open this, please?'",
            why:
                "Asking clearly for help helps others understand what you need and allows them to support you.",
          ),
          Scenario(
            subcategory: "Giving a compliment",
            description:
                "You see a friend drew a great picture during art class.",
            action: "Say 'That's an awesome drawing!'",
            why:
                "Giving compliments helps build friendships and makes others feel good.",
          ),
          Scenario(
            subcategory: "Asking to join a group",
            description:
                "Some classmates are playing a game and you want to be part of it.",
            action: "Say 'Can I join your game?'",
            why: "Asking to join shows respect and helps you be included.",
          ),
        ],
      ),
      ScenarioCategory(
        name: "Contextual Awareness",
        scenarios: [
          Scenario(
            subcategory: "Formal vs. casual setting",
            description:
                "You are at a school awards ceremony where teachers and parents are present.",
            action:
                "Speak politely, avoid shouting, and listen quietly during announcements.",
            why:
                "Formal settings require respectful behavior to show you understand the situation.",
          ),
          Scenario(
            subcategory: "Understanding quiet zones",
            description:
                "You're in the library and feel excited to share something.",
            action: "Use a whisper or wait until you're outside to speak.",
            why:
                "Different places have different expectations, like quiet zones needing softer voices.",
          ),
        ],
      ),
      ScenarioCategory(
        name: "Interpretation",
        scenarios: [
          Scenario(
            subcategory: "Recognizing sarcasm",
            description: "Someone says, 'Nice job!' after you make a mistake.",
            action:
                "Pause and think — are they serious or joking? Ask a trusted adult if unsure.",
            why:
                "Sarcasm can sound like praise but usually means the opposite. Recognizing this helps avoid confusion.",
          ),
          Scenario(
            subcategory: "Reading body language",
            description:
                "A friend is looking away, arms crossed, and not laughing at jokes.",
            action:
                "They might be upset. Ask, 'Are you okay?' or give them space.",
            why:
                "Body language gives clues about how someone feels, even if they don't say it.",
          ),
        ],
      ),
    ];
  }

  static List<ScenarioCategory> _getChineseScenarios() {
    return [
      ScenarioCategory(
        name: "社交规则",
        scenarios: [
          Scenario(
            subcategory: "对话中的轮流发言",
            description: "你正在听一位同学讲故事，想要发表自己的看法。",
            action: "等到对方停顿或讲完后，再提出你的评论。",
            why: "轮流发言既表示尊重，也能让对话双方都感到愉快。",
          ),
          Scenario(
            subcategory: "个人空间",
            description: "你在和别人说话时，站得离对方太近了。",
            action: "向后退一步，保持大约一臂的距离。",
            why: "尊重个人空间有助于让对方感到安全与舒适。",
          ),
          Scenario(
            subcategory: "问候他人",
            description: "你到达学校，看见了老师和朋友们。",
            action: "说“早上好”或“你好！”；如果觉得自在，可以加上眼神交流。",
            why: "问候他人能礼貌而友好地开启社交互动。",
          ),
          Scenario(
            subcategory: "保持话题",
            description: "大家正在讨论最喜欢的食物，而你想聊聊自己的宠物。",
            action: "可以等话题转换，或问：“我稍后可以聊聊我的宠物吗？”",
            why: "保持话题不偏离，既表示你在认真倾听，也有助于维持对话的流畅。",
          ),
          Scenario(
            subcategory: "打断他人",
            description: "你的朋友正和另一位同学说话，你有急事想立刻开口。",
            action: "先说“打扰一下”，等对话停顿后再继续表达。",
            why: "不随意打断他人既体现耐心，也让对方感受到被尊重。",
          ),
        ],
      ),
      ScenarioCategory(
        name: "表达意图",
        scenarios: [
          Scenario(
            subcategory: "请求帮助",
            description: "你打不开水瓶，试了好几次也没成功。",
            action: "可以说：“请问你能帮我打开这个吗？”",
            why: "清晰地请求帮助，能让别人明白你的需求，也更愿意提供支持。",
          ),
          Scenario(
            subcategory: "给予赞美",
            description: "你看到朋友在美术课上画了一幅很棒的画。",
            action: "可以说：“这幅画真好看！”",
            why: "真诚的赞美有助于增进友谊，也让对方感到开心。",
          ),
          Scenario(
            subcategory: "请求加入群体",
            description: "一些同学在玩游戏，你也想一起参加。",
            action: "可以问：“我可以加入你们吗？”",
            why: "主动请求加入既显得尊重，也更容易让你融入集体。",
          ),
        ],
      ),
      ScenarioCategory(
        name: "情境意识",
        scenarios: [
          Scenario(
            subcategory: "正式与非正式场合",
            description: "你在学校颁奖典礼上，现场有老师和家长。",
            action: "注意礼貌用语，避免喧哗，宣布名单时保持安静聆听。",
            why: "正式场合需要举止得体，以体现你对场合的尊重。",
          ),
          Scenario(
            subcategory: "理解安静区域",
            description: "你在图书馆，突然想到一件事很想分享。",
            action: "可以小声耳语，或者等到离开后再讨论。",
            why: "不同场合有不同的礼仪要求，安静区域需要控制音量。",
          ),
        ],
      ),
      ScenarioCategory(
        name: "理解他人",
        scenarios: [
          Scenario(
            subcategory: "识别讽刺",
            description: "你犯错后，有人说：“干得真不错！”",
            action: "先停下来想一想：对方是认真的，还是在开玩笑？如果不确定，可以询问信任的成年人。",
            why: "讽刺听起来像表扬，但实际意思往往相反。识别讽刺能避免误解。",
          ),
          Scenario(
            subcategory: "阅读肢体语言",
            description: "你的朋友眼睛看向别处、双臂交叉，也没有笑。",
            action: "他们可能心情不好。可以问：“你还好吗？”或暂时给对方一些空间。",
            why: "肢体语言能透露一个人的情绪，即使他们什么也没说。",
          ),
        ],
      ),
    ];
  }
}
