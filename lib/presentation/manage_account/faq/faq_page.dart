import 'package:flutter/material.dart';
 

class FaqPage extends StatefulWidget {
  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  bool isOpen = false;
  int pageNumber = -1;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String email = '';
  String password = '';
  String teamId = '';

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

  final faqContent = [
    {
      'question': 'How long does my subscription plan last ?',
      'answer':
          'Each conversion plan expires 1 month from the date of purchase after which unused units will be cleared. To continue enjoying our services without interruption, do take a moment to renew your subscription before the expiration date.',
    },
    {
      'question': 'How much do you have to pay to convert my bet codes?',
      'answer':
          'This platform is completely free for your first 3 conversions, when you exhaust your 5 free conversions, you can subscribe to our flexible plans for more',
    },
     {
      'question': 'What should i do when my payment is successful but did not receive my UNITS?',
      'answer':
          'Do not panic. It has been made easier now, once you witness this situation just get to your pricing page to reconfirm the transaction with the button below the page. N.B this confirmation can only be valid within 24 hours from when the transaction was made.',
    },
    {
      'question': 'Do I have to sign up before I can convert my bet codes?',
      'answer':
          'Yes. Sign up to enjoy access to some of our other amazing features like the betting community, fixtures, live scores, and more.',
    },
    {
      'question': 'Why is my conversion not working ?',
      'answer': """
Conversions will not occur if
          
1. Trying to convert any other sports except football. 

2. Converting between two different countries. 

3. No Subscription plan after using up free conversions. 

4. Network related issues.

          """,
    },
    {
      'question': 'Can TellaSport convert on my behalf?',
      'answer':
          'No, we do not do conversions for users but we have made our platform novice friendly and have a support chat 💬 so it is easy to navigate without stress.',
    },
    {
      'question': 'Why is my subscription plan not reflecting after payment?',
      'answer':
          'Do not panic. There can be a delay with the third-party payment platform or network-related issues. Please reach out via support chat or email to resolve this issue.',
    },
    {
      'question':
          ' Why don’t my free conversions or community work on the website?',
      'answer':
          'Not to worry, every new user is entitled to this. If you experience difficulty using the website. You can download the TellaSport mobile app to access the 5 free conversions and free community anytime.',
    },
    {
      'question': 'Can anyone regardless of location use this platform?',
      'answer':
          'Yes, anyone can use this platform so long as the services provided are supported in your location. ',
    },
    {
      'question': 'Can I place a bet on this platform?',
      'answer':
          'No. This is not a betting platform, you can only Convert Bet Slip codes here.',
    },
    {
      'question': 'Are betting tips here guaranteed?',
      'answer':
          'TellaSport will never predict games for you. You may, however, get betting tips from punters in our communities.No be us go tell you wetin you go do, but remember to bet responsibly.',
    },
    {
      'question': 'Can a novice use this platform?',
      'answer':
          'We try to make every function on the website as easy to use as possible. If you require more assistance message us on the web chat.',
    },
    {
      'question': 'Do I need to login to check scores?',
      'answer':
          'No. you can follow your favourite teams or games on TellaSport, anytime, anywhere.',
    },
    {
      'question': 'My conversion units are finished. How do I get more Units?',
      'answer':
          'Click on “Convert”, then click on “Get Units” on the pop up box, select the package you want and pay.',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    double mainPadding = width < 480 ? width * 0.05 : width * 0.06;

    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: const Text('FAQ', style: TextStyle(color: Colors.white),),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Frequently Asked\nQuestions',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  height: 3,
                  width: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      width: double.infinity,
                      color: Colors.white,
                      child: Material(
                        type: MaterialType.card,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: faqContent.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _handleTap(index);
                                      });
                                    }),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors
                                                        .grey.shade200))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                faqContent[index]
                                                        ['question'] ??
                                                    '',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            active.contains(index)
                                                ? Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                    size: 28,
                                                  )
                                                : Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                    size: 28,
                                                  )
                                          ],
                                        )),
                                  ),
                                  Visibility(
                                    visible:
                                        active.contains(index) ? true : false,
                                    child: AnimatedContainer(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      width: double.infinity,
                                      duration: const Duration(seconds: 1),
                                      child: Text(
                                        faqContent[index]['answer'] ?? '',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Container(
                height: 150,
                color: const Color(0xFFf9f9f9),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      'Need support? Reach out to us',
                      maxLines: 2,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
