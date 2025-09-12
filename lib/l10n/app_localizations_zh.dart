// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Voice Intent';

  @override
  String get appSubtitle => '社交沟通助手';

  @override
  String get splashDescription => '理解情感与社交互动';

  @override
  String get pragmaticLanguage => '语言的使用';

  @override
  String get pragmaticLanguageDesc => '学习社交语言的使用方式';

  @override
  String get emotionsInSpeech => '语言的情感';

  @override
  String get emotionsInSpeechDesc => '分析语音中的情感';

  @override
  String get literalVsFigurative => '字面还是比喻？';

  @override
  String get literalVsFigurativeDesc => '理解语言的含义';

  @override
  String get pragmaticScenarios => '语言的场景';

  @override
  String get pragmaticScenariosDesc => '话语背后的含义';

  @override
  String get speechInputHint => '输入或点击麦克风按钮开始说话…';

  @override
  String get speechNotAvailable => '语音识别暂不可用';

  @override
  String get chooseActivity => '选择一个活动来开始学习！';

  @override
  String get listening => '聆听中…';

  @override
  String get languageSwitch => '语言';

  @override
  String get english => 'English';

  @override
  String get chinese => '中文';

  @override
  String get emotionInSpeech => '语言的情感';

  @override
  String get recordingYourVoice => '按下按钮然后开始说话';

  @override
  String get speakNaturally => '用平常的语气说话，我来分析你语言中的情感！';

  @override
  String get literalVsFigurativeTitle => '字面还是比喻？';

  @override
  String get understandingLanguageTypes => '理解语言的类型';

  @override
  String get literal => '字面语言';

  @override
  String get literalDescription => '词语最直接的意思。比如，一个人说“下雨了”，说明真的在下雨。';

  @override
  String get figurative => '比喻语言';

  @override
  String get figurativeDescription =>
      '说一个事情，但实际意思是另一个事情。比如，一个人说”累成狗了“，不是真的变成狗了，而是比喻自己很累。';

  @override
  String get sarcastic => '讽刺语言';

  @override
  String get sarcasticDescription => '“说反话”，夸张地表达相反的含义。比如，一个人在暴风雨中说：“真是好天气！”';

  @override
  String get analyze => '分析';

  @override
  String get typeOfLanguage => '语言类型';

  @override
  String get whatItReallyMeans => '真实含义';

  @override
  String get whyThisType => '为什么属于这种类型？';

  @override
  String get howToUnderstandRespond => '如何理解/\n回应';

  @override
  String get pragmaticLanguageTitle => '语言的使用';

  @override
  String get understandingPragmaticLanguage => '理解语言的使用';

  @override
  String get pragmaticLanguageDescription =>
      '这是指我们在社交情境中如何运用语言，包括理解语境、含义和一些社会规则。';

  @override
  String get languageUse => '语言运用';

  @override
  String get speakerIntent => '说话者意图';

  @override
  String get whatItMeans => '含义';

  @override
  String get suggestedResponse => '建议回应';

  @override
  String get pragmaticScenariosTitle => '语用场景';

  @override
  String get situation => '情境';

  @override
  String get expectedAction => '恰当做法';

  @override
  String get why => '原因';

  @override
  String scenarioCounter(int current, int total) {
    return '场景 $current / $total';
  }

  @override
  String get appName => '语音意图';

  @override
  String get socialRules => '社交规则';

  @override
  String get intentions => '意图表达';

  @override
  String get contextualAwareness => '情境意识';

  @override
  String get interpretation => '理解与解读';

  @override
  String get turnTakingInConversation => '对话中的轮流发言';

  @override
  String get turnTakingDescription => '你正在听一位同学讲故事，想要发表自己的看法。';

  @override
  String get turnTakingAction => '等到对方停顿或讲完后，再提出你的评论。';

  @override
  String get turnTakingWhy => '轮流发言既表示尊重，也能让对话双方都感到愉快。';
}
