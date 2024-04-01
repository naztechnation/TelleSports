class AppStrings {
  static const String appName = 'Lucacify';

  static const String networkErrorMessage = "Network error, try again later";


 static const rapidHeaders = {
    'x-rapidapi-host': "api-football-v1.p.rapidapi.com",
    'x-rapidapi-key': "104a201b57msh6b3ffdcac137f1ap129daejsnc0051ba3b1a0",
  };

  static const String bookieBaseUrl = 'https://convertbetcodes.com/api/';
  static const String rapidApiBaseUrl =
      'https://api-football-v1.p.rapidapi.com/v3/';

  static const String currentSeason = '2023';


static String rapidFixtureUrl({required String searchParameter}) =>
      '${rapidApiBaseUrl}fixtures?$searchParameter';

static String teamInfoUrl({required String teamId}) =>
      '${rapidApiBaseUrl}teams?id=$teamId';
  static String teamTransferUrl({required String teamId}) =>
      '${rapidApiBaseUrl}transfers?team=$teamId';
  static String coachInfoUrl({required String teamId}) =>
      '${rapidApiBaseUrl}coachs?team=$teamId';
  static String searchTeamsUrl({required String searchParameter}) =>
      '${rapidApiBaseUrl}teams?search=$searchParameter';
  static String teamsStandingsUrl({required String teamId}) =>
      '${rapidApiBaseUrl}standings?season=$currentSeason&team=$teamId';
  static String teamsSquadUrl({required String teamId}) =>
      '${rapidApiBaseUrl}players?season=$currentSeason&team=$teamId';
  static String trophiesUrl({required String id}) =>
      '${rapidApiBaseUrl}trophies?coach=$id';
  static String leagueTableUrl({required String leagueId}) =>
      '${rapidApiBaseUrl}standings?season=$currentSeason&league=$leagueId';

  static String teamStatsUrl({
    required String teamId,
    required String leagueId,
  }) =>
      '${rapidApiBaseUrl}teams/statistics?team=$teamId&league=$leagueId&season=$currentSeason';

  static String league =
      '${rapidApiBaseUrl}leagues?season=$currentSeason&current=true';


  ///flutterwave api
  static const String flutterwaveApiKey =
      "FLWPUBK_TEST-800484dab3ab798a88b3e7063141afac-X";

  ///base url

  static const String _baseUrl = 'https://tellasport.com/api/v1/';

  ///auth urls

  static String registerUserUrl = '${_baseUrl}register';

  static String loginUrl = '${_baseUrl}login';

  static String verifyCodeUrl = '${_baseUrl}email_verification';

  static String resendVerifyCodeUrl = '${_baseUrl}resend_code';
  static String forgetPasswordUrl = '${_baseUrl}forget_password';
  static String verifyForgetPasswordUrl = '${_baseUrl}verify_code';
  static String resetPasswordUrl = '${_baseUrl}reset_password';
  static String changePasswordPasswordUrl = '${_baseUrl}change_password';

  static String planUrl = '${_baseUrl}plans';
  static String confirmPaymentUrl = '${_baseUrl}confirm_flutterwave_subscription';
  static String reconfirmPaymentUrl = '${_baseUrl}reconfirm';
  static String conversionHistoryUrl = '${_baseUrl}conversation_history';
  static String getBookiesUrl = '${_baseUrl}bookies';
  static String getNotificationsUrl = '${_baseUrl}notification';
  static String getNotificationsDetailsUrl(String notifyId) => '${_baseUrl}notification/$notifyId';
  static String userWalletUrl = '${_baseUrl}user_wallet';
  static String converterUrl = '${_baseUrl}convert';
  static String updateUserProfileUrl = '${_baseUrl}profile';
  static String uploadUserImageUrl = '${_baseUrl}upload_profile_image';
  static String deleteUserUrl(String userId) => '${_baseUrl}delete-account/$userId';
  static String transferTellacoinUrl = '${_baseUrl}transfer-coin';
  static String updateAccountUrl = '${_baseUrl}update_account_details';
  static String getPredictionListUrl(String day) => '${_baseUrl}predictions?day=$day';
  static String postPredictionUrl = '${_baseUrl}predictions';
  static String predictionRatingUrl = '${_baseUrl}prediction_rating';
  static String reportUrl = '${_baseUrl}report';
  static String currencyUrl = '${_baseUrl}flutterwave_banks';
  static String payoutUrl = '${_baseUrl}request_payout';

  




    // firestore
  static const String usersCollection = 'users';
  static const String groupsCollection = 'groups';
  static const String statusCollection = 'status';
  static const String chatsCollection = 'chats';
  static const String callsCollection = 'calls';
  static const String messagesCollection = 'messages';

  // chat
  static const String userId = 'userId';
  static const String username = 'username';
  static const String profilePic = 'profilePic';
  static const String isGroupChat = 'isGroupChat';


  static const String degaultImage = '  https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg';

  
   static const String PRIVACY =
      """
Privacy Policy
Our Privacy Policy governs the privacy terms of our Website, Application (https://tellasport.com/), and any associated web-based applications (collectively, "Website"), (“tellasport.com”). Any capitalized terms not defined in our Privacy Policy have the meaning as specified in our Terms of Use. Our users' privacy is of utmost importance to us. Therefore, we have developed this Policy to help you understand how we collect, use, communicate, disclose, and make use of personal information. By using the website, you agree to the collection and use of information by this policy. Unless otherwise defined in this Privacy Policy, terms used herein have the same meanings as in our Terms of Use, accessible at (https://tellasport.com/). The following outlines our Privacy Policy:
1. Purpose Identification: Before or at the time of collecting personal information, we will identify the purposes for which information is being collected.
2. Limited Use: We will collect and use personal information solely to fulfill those purposes specified by us and for other compatible purposes unless we obtain the consent of the individual concerned or as required by law.
3. Data Retention: We will only retain personal information as long as necessary for the fulfillment of those purposes.
4. Lawful Collection: We will collect personal information by lawful and fair means and, where appropriate, with the knowledge or consent of the individual concerned.
5. Data Relevance and Accuracy: Personal data should be relevant to the purposes for which it is to be used and, to the extent necessary for those purposes, should be accurate, complete, and up-to-date.
6. Security Measures: We will protect personal information by implementing reasonable security safeguards against loss or theft, as well as unauthorized access, disclosure, copying, use, or modification.
7. Transparency: We will make readily available to customers information about our policies and practices relating to the management of personal information.
We are committed to conducting our business by these principles to ensure that the confidentiality of personal information is maintained and protected. If you have any questions regarding our Privacy Policy, please contact us at [contact@tellasport.com](mailto:contact@tellasport.com).
Your Privacy
[https://tellasport.com/](https://tellasport.com/) follows all legal requirements to protect your privacy. Our Privacy Policy is a legal statement that explains how we may collect information from you, how we may share your information, and how you can limit our sharing of your information. We utilize the Personal Data you offer in a way that is consistent with this Personal Privacy Policy. If you provide Personal Data for a particular reason, we could make use of the Personal Data in connection with the reason for which it was provided. For example, registration info sent when developing your account might be used to suggest products to you based on past acquisitions. We might use your Data to offer access to services on the Website and monitor your use of such services. [https://tellasport.com/](https://tellasport.com/) may also utilize your Data and various other personally non-identifiable information gathered through the Website to assist us with improving the material and functionality of the Website, to better comprehend our users, and to improve our services. You will see terms in our Privacy Policy that are capitalized. These terms have meanings as described in the Definitions section below.
Definitions
- Non-Personal Information: Information that is not personally identifiable to you and that we automatically collect when you access our Website with a web browser. It may also include publicly available information that is shared between you and others.
- Personally Identifiable Information: non-public information that is personally identifiable to you and obtained for us to provide you with our website. Personally, Identifiable Information may include information such as your name, email address, and other related information that you provide to us or that we obtain about you.
Information We Collect
Generally, you control the amount and type of information you provide to us when using our Website. As a Visitor, you can browse our website to find out more about our Website. You are not required to provide us with any Personally Identifiable Information as a Visitor.
We collect personal information whenever you provide it to us. This personal information may include the following:
- Name, email ID, and mobile number.
- Technical and analytical information obtained through cookies.
- Other information you provide to us.
Computer Information Collected
When you use our Website, we automatically collect certain computer information from the interaction of your mobile phone or web browser with our Website. Such information is typically considered Non-Personal Information. We also collect the following:
Automatic Information:
We automatically receive information from your web browser or mobile device. This information includes the name of the website from which you entered our Website if any, as well as the name of the website to which you're headed when you leave our website. This information also includes the IP address of your computer/proxy server that you use to access the Internet, your Internet Website provider name, web browser type, type of mobile device, and computer operating system. We use all of this information to analyze trends among our Users to help improve our Website.
Log Data:
Like many Website operators, we collect information that your browser sends whenever you visit our Website ("Log Data"). This Log Data may include information such as your computer's Internet Protocol ("IP") address, browser type, browser version, the pages of our Website that you visit, the time and date of your visit, the time spent on those pages, and other statistics.
Our Services are not directed to persons under the age of 18 years. We do not knowingly collect Personally Identifiable Information from children under 18 years. If a parent or guardian becomes aware that his or her child has provided us with Personally Identifiable Information without their consent, he or she should contact us at [contact@tellasport.com or Tellasport@gmail.com](mailto:contact@tellasport.com or Tellasport@gmail.com). If we become aware that a child under 18 years has provided us with Personally Identifiable Information, we will delete such information from our record.
How We Use Your Information
We use the information we receive from you as follows:
- Responding to any inquiries which you make to us relating to any of our services,
- Monitoring site usage to develop and administer our websites,
- Promoting our products and services to you, as well as the products and services of our affiliates,
- Delivering email communications, newsletters, and other correspondence to which you subscribe,
- Conducting other marketing activities,
- Communicating with you regarding your Membership at [https://tellasport.com/](https://tellasport.com/) and
- Responding to your inquiries and other correspondence, or request that you provide feedback to us.
How We Share Information
We may disclose your personal information to:
- Our infrastructure providers,
- A third party who acquires our business, and
- Law enforcement and regulatory agencies in connection with any investigation to help prevent unlawful activity or as otherwise required by law.
Reasons We Collect and Use Your Personal Information
We may use your information in the following ways:
- Where it is necessary to perform our contract with you,
- Where it is required by law,
- Where you have provided consent, provided that you can withdraw this consent at any time,
- Where it is necessary for our legitimate interests as a business.
Your Rights
You have rights under data protection laws, in certain circumstances, including to:
- Request access to personal information that we may process about you,
- Require us to correct any inaccuracies in your information free of charge,
- Require us to erase personal data that we may process about you where this is no longer required to be processed by us, and
- To object to or restrict our processing of some of your personal information in certain circumstances.
If you wish to exercise any of these rights, you should write your request and provide us with enough information to identify you. If we need further information, we will let you know. If you have any concerns or questions as to how we process your information please do contact us.
Reviewing and Changing Your Profile
Following registration, you can review and change the information you submitted during registration through the 'Edit Profile. If you change any information, we may keep track of your old information. You can also change your registration information such as name, address, city, state, zip code, country, phone number, profile, and other information. To remove your profile so that others cannot view it, contact our customer support team at [support@tellasport.com](mailto:support@tellasport.com).
We will retain in our files information you have requested to remove for certain circumstances, such as to resolve disputes, troubleshoot problems, and enforce our Terms of Use. Further, such prior information is never completely removed from our databases due to technical and legal constraints, including stored 'backup' systems. Therefore, you should not expect that all of your personally identifiable information will be completely removed from our databases in response to your requests.
Control of your Password
You are responsible for all actions taken with your login information and password. Therefore, we recommend that you do not disclose your account password or login information to any third parties. If you choose to share this information with third parties to provide you additional services, you are responsible for all actions taken with your login information and password and therefore should review each third party's privacy policy. If you lose control of your password, you may lose substantial control over your personally identifiable information and may be subject to legally binding actions taken on your behalf. Therefore, if your password has been compromised for any reason, you should immediately change your password.
Security
The security of your Personal Information is important to us, but remember that no method of transmission over the Internet or electronic storage method is 100% secure. While we strive to use commercially acceptable means to protect your Personal Information, we cannot guarantee its absolute security. We utilize practical protection measures to safeguard against the loss, abuse, and modification of the individual Data under our control. Personal Data is kept in a secured database and always sent out using an encrypted SSL method when supported by your web browser. No Web or email transmission is ever totally protected or mistake-cost-free. For example, emails sent out to or from the Website may not be protected. You must take unique care in deciding what info you send to us using email.
Privacy Policy Updates
We reserve the right to change the Terms of Use and Privacy Policy from time to time as we see fit, and your continued use of the site will signify your acceptance of any adjustment to these terms. We may not announce such changes on our website. Therefore, you agree that you will review our Terms of Use and Privacy Policy documents regularly. Should it be that you do not accept any of the modifications or amendments to the Terms of Use, you may terminate your use of this website immediately.
DISCLAIMER
If you require any more information or have any questions about our site’s disclaimer, please feel free to contact us by email at support@tellasport.com or tellasport@gmail.com
All the information on this website – https://tellasport.com/, – is published in good faith and for general information purposes only. https://tellasport.com/does do not make any warranties about the completeness, reliability, and accuracy of this information. Any action you take upon the information you find on this website (https://www.tellasport.com/), is strictly at your own risk. https://tellasport.com/will not be liable for any losses and/or damages in connection with the use of our website.
From our website, you can maybe able to visit other websites by following hyperlinks to such external sites. While we strive to provide only quality links to useful and ethical websites, we have no control over the content and nature of these sites. These links to other websites do not imply a recommendation for all the content found on these sites. Site owners and content may change without notice and may occur before we have the opportunity to remove a link that may have gone ‘bad’.
Please be also aware that when you leave our website, other sites may have different privacy policies and terms that are beyond our control. Please be sure to check the Privacy Policies of these sites as well as their “Terms of Service” before engaging in any business or uploading any information.
Consent
By using our website, you hereby consent to our disclaimer and agree to its terms.
Update
Should we update, amend, or make any changes to this document, those changes will be promptly posted here. """;

  static const String TERMS_SERVICE = """
 1. Acceptance of Terms
 
Welcome to Tellasport! We're thrilled to provide you with a dynamic social network designed for sports enthusiasts. This includes our website, located at www.tellasport.com (the "Site"), and our corresponding mobile application. Our offerings encompass a variety of content, such as text, images, audio, code, and more (collectively known as the “Content”), along with a range of features and services provided through the Site and app.
Before diving into the excitement, it's essential to review and understand the following Terms of Use (referred to as the “Terms”). By accessing or utilizing our Services, or by clicking to accept or agree to these Terms where prompted, you signify your agreement to:

1. Accept and abide by these Terms.
2. Consent to the collection, use, disclosure, and handling of information as outlined in our Privacy Policy (accessible online at https://Tellasport.com/).
3. Adhere to any additional terms, rules, and conditions of participation that Tellasport may introduce periodically.
Should you disagree with any aspect of these Terms, kindly refrain from accessing or utilizing the Content or Services.

2. Modification of Terms of Use

Except for Section 15, which pertains to binding arbitration and waiver of class action rights, Tellasport reserves the right, at its sole discretion, to modify or replace the Terms of Use at any time. The most current version of these Terms will be posted on our Site. It is your responsibility to review and become familiar with any such modifications. In the event of a material revision to the Terms, as determined solely by us, we will notify you via the email address associated with your account. Your continued use of the Services following any modification to the Terms constitutes your acceptance of the modified Terms of Use.


3. Eligibility
By using our Services, you represent and warrant that you are fully able and competent to enter into and comply with the terms, conditions, obligations, affirmations, representations, and warranties outlined in these terms. Specifically:
- You are confirming that you are 18 years of age or older.
- You agree to abide by these Terms of Use and any other agreements between you and Tellasport regarding your use of the Service.
Failure to meet the eligibility requirements outlined in this section will result in the termination of your authorization to use the Service.
4. Conditions of Participation
4.1 Registration
To participate in a contest on the Service, you must register for an account. By registering, you agree to provide accurate, current, and complete information about yourself (referred to as the “Registration Data”), and to promptly update this information to maintain its accuracy. Tellasport reserves the right to deny access to areas requiring registration or terminate your account if the provided information is inaccurate, not current, or incomplete.
4.2 Account Security
Upon registration for online account access, you must provide a valid email address and create a Username and Password. Your Username must not promote commercial ventures or contain offensive content, as determined solely by Tellasport. You are responsible for maintaining the confidentiality of your account credentials and are liable for all activities associated with your account. Notify Tellasport immediately of any unauthorized account access or security breaches. Tellasport may, at its discretion, deny access or block transactions made using your account without prior notice if unauthorized use is suspected.
4.3 Communications and Information Practices
By registering for the Service, you may receive commercial communications from Tellasport. You have the option to opt out of receiving these communications using the provided unsubscribe functionality. However, we may still communicate with you via email as permitted by applicable law.
4.4 Disqualification and Service Modifications
Tellasport reserves the right to disqualify, suspend, limit, or terminate your account if your conduct is deemed improper, unfair, fraudulent, or detrimental to the operation of the Service or other users. Improper conduct includes, but is not limited to, falsifying personal information, violating the rules, tampering with the Service, or abusing the Service. In the event of unforeseen circumstances affecting the Service's operation, Tellasport may cancel, terminate, modify, or suspend the Service at its sole discretion. Such actions will be communicated via notification on the Site.
5. Service and Chats
5.1 Service
Tellasport provides a platform for users to send and receive messages and images publicly and in private chats.
5.2 Private Chats
Tellasport facilitates direct messaging between users, allowing for easy exchange of messages.
As part of the Service, Tellasport may send administrative messages to users, such as notifications about new features or welcome messages for new users. By signing up for the Service, you agree to receive such messages.
Tellasport administrators and moderators endeavor to promptly remove or edit any objectionable material. By agreeing to these Terms:
(i) You understand that posts on the feed and in groups represent the views of the author, not Tellasport, its administrators, moderators, or webmaster, and therefore, Tellasport is not liable for the content posted, including but not limited to features such as posting GIFs through Giphy, sharing links, onboarding processes, or displaying trending posts.
(ii) You agree not to post commercial solicitations or advertise products or services.
(iii) You agree not to post abusive, obscene, vulgar, slanderous, hateful, threatening, sexually-oriented, or otherwise unlawful material. Violation of this may result in immediate and permanent banning, with relevant authorities informed, and IP addresses recorded.
(iv) You acknowledge that Tellasport's webmaster, administrator, and moderators have the right to remove, edit, move, or close any topic at their discretion..
(v) You consent to the storage of any personal information you provide in a database. While Tellasport endeavors to protect this information, it cannot be held responsible for any unauthorized access due to hacking attempts.
6. Conduct
As a condition of use, you agree not to employ the Services for unlawful or prohibited purposes. If you share content on the Service, you are solely responsible for its legality and any resultant harm.
By using the Service, you affirm that you own or have the rights to share any content you post. You agree not to engage in prohibited activities, including:
(i) Copying, distributing, or disclosing any part of the Service.
(ii) Using automated systems to access the Service excessively.
(iii) Interfering with the proper functioning of the Service.
(iv) Transmitting spam or unsolicited emails.
(v) Attempting to compromise system security.
(vi) Uploading malicious software.
(vii) Harvesting personal information.
(viii) Using the Service for commercial solicitation.
(ix) Impersonating others or conducting fraud.
(x) Interfering with Service operations.
(xi) Accessing content through unauthorized means.
(xii) Using artificial means to inflate standings on leaderboards.
(xiii) Advertising or soliciting without explicit consent.
(xiv) Transferring profiles.
7. Violation of Rules and User Content
Violation of our rules may result in the removal of your Content from the Service and/or the cancellation of your account. You acknowledge and agree that Tellasport reserves the right to remove any User Content and terminate any Tellasport account at any time for any reason, including upon receipt of claims or allegations relating to such User Content. To report violations, please email support@Tellasport.com.
8. User Content
You understand that all Content made available on the Service by a user (“User Content”), including profile information and communications, is the sole responsibility of the user. You are entirely responsible for all User Content you upload, post, share, or otherwise make available via the Service. Tellasport may pre-screen User Content but reserves the right to refuse, delete, modify, and move any User Content that violates these Terms or is otherwise objectionable. You acknowledge and agree to evaluate and bear all risks associated with the use or disclosure of any User Content. By using the Service, you grant Tellasport a license to use, distribute, reproduce, modify, and publicly display User Content.
9. Interactions and Disputes
You are solely responsible for your interactions with other users of the Service. Tellasport reserves the right to monitor disputes between users but has no obligation to do so.
10. Indemnity
You agree to indemnify, defend, and hold harmless Tellasport and its affiliates from any losses, liabilities, expenses, damages, or claims arising from your use of the Software and/or Service, your violation of these Terms, or any acts or omissions that implicate publicity rights, defamation, or invasion of privacy.
11. Warranty Disclaimers
The Software and Service are provided on an "as is" and "as available" basis. Tellasport and its affiliates disclaim all warranties, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. Tellasport does not guarantee the accuracy, completeness, or usefulness of the Service, and you rely on it at your own risk.
12. Limitation on Liability
Tellasport and its affiliates will not be liable for any indirect, incidental, special, consequential, or exemplary damages arising from your use of the Software or Service. Tellasport's total liability, regardless of the forum or basis of any action or claim, will not exceed the total amount paid by you to Tellasport for the Software or Service or \$50, whichever is greater.
13. Our Proprietary Rights
All title, ownership, and intellectual property rights in the Service are owned by Tellasport or its licensors. You agree not to copy, modify, sell, distribute, or create derivative works based on the Service without Tellasport's authorization.
14. Links
Tellasport is not responsible for the content of external sites linked to the Service. You acknowledge and agree that Tellasport shall not be liable for any damage or loss caused by or in connection with the use of such content.
15. Termination and Suspension
Tellasport may terminate or suspend the Service and your Tellasport account without prior notice or liability. Upon termination, your right to use the Service will cease. Certain provisions of the Terms will survive termination, including Conditions of Participation, Conduct, Indemnity, Warranty Disclaimers, Limitation on Liability, Our Proprietary Rights, Links, and Termination.
16. No Third Party Beneficiaries
There shall be no third-party beneficiaries to the Terms.
Application License
You are granted a limited, non-exclusive, non-transferable license to use the app for personal use. Tellasport reserves all rights not expressly granted to you.
Content
Content transmitted through the Service is not representative of Tellasport's opinions. Links transmitted in group chats or publicly are not endorsed by or affiliated with Tellasport. The Terms govern all use of the Service.
16.1 Content Licensing
By using Tellasport and submitting Content publically, direct messages to users, or a group chat, you grant Tellasport a worldwide, royalty-free, perpetual, fully sublicensable, and non-exclusive license to reproduce, modify, adapt, and publish the Content in connection with the Service. Without limiting any of those representations or warranties, Tellasport has the right (though not the obligation) to, in its sole discretion (i) refuse or remove any content that, in Tellasport's opinion, violates any Tellasport policy or is in any way harmful or objectionable, or (ii) terminate or deny access to and use of the Service to any individual or entity for any reason, in Tellasport's sole discretion. This may include modifying or stopping the Service in its entirety.
17. General Information
17.1 Entire Agreement
These Terms constitute the entire agreement between Tellasport and you concerning the subject matter hereof, and may only be modified by a written amendment signed by an authorized executive of Tellasport, or by the posting by Tellasport of a revised version. You agree that any notice, agreements, disclosure, or other communications that we send to you electronically will satisfy any legal communication requirements, including that such communications be in writing or otherwise authorized.
17.2 Waiver and Severability of Terms
The failure of Tellasport to exercise or enforce any right or provision of the Terms shall not constitute a waiver of such right or provision. Suppose any provision of the Terms is found by an arbitrator or court of competent jurisdiction to be invalid. In that case, the parties nevertheless agree that the arbitrator or court should endeavor to give effect to the parties’ intentions as reflected in the provision, and the other provisions of the Terms remain in full force and effect.
17.3 Statute of Limitations
You agree that regardless of any statute or law to the contrary, any claim or cause of action arising out of or related to the use of the Service or the Terms must be filed within one (1) week after such claim or cause of action arose or be forever barred.
17.4 Section Titles
The section titles in the Terms are for convenience only and have no legal or contractual effect.
17.5 Communications
Users with questions, complaints, or claims concerning the Service may contact us using the relevant contact information set forth above or send an email to contact@Tellasport.com.

 """;


  
}
