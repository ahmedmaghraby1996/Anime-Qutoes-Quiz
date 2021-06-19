import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:anime_quiz_app/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'endscreen.dart';
import 'question.dart';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int ad;
  MyHomePage([this.ad]);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int i = 0;

  List<Question> questions = [
    Question(
        anime: "Naruto",
        character: "Kimimaro",
        quote:
            "Against the power of will I posses... The capability of my body is nothing.",
        pic:
            "https://i.pinimg.com/236x/a2/8c/f5/a28cf5a94e403edb3f9fc5cbc104b271.jpg"),
    Question(
        anime: "Mirai Nikki",
        character: "Akise Aru",
        quote: "Not knowing everything in this world is fun.",
        pic:
            "https://i.pinimg.com/236x/eb/da/1e/ebda1e1ff815a8853e84c9f99b86b4b6.jpg"),
    Question(
        anime: "Fairy Tail",
        character: "Mirajane Strauss",
        quote:
            "People cry, not because they're weak. Its because they've been strong for too long.",
        pic:
            "https://i.pinimg.com/236x/cf/9a/4b/cf9a4b08aa83433370e67fa0fc0e96c2.jpg"),
    Question(
        anime: "Yahari Ore No Seishun Love Come Wa Machigatteiru",
        character: "Hachiman Hikigaya",
        quote:
            "Everyone has something they hold dear, something they never want to lose. That's why they pretend. That's why they hide the truth. And that's why they lie.",
        pic:
            "https://i.pinimg.com/236x/57/5a/7f/575a7f97de35abb15b49525111f162ae.jpg"),
    Question(
        anime: "Bakemonogatari",
        character: "Senjougahara Hitagi",
        quote:
            "Right now, I'm afraid of losing you. Although my life hasn't been very fortunate until now, I'm glad if I caught your eye because of that misfortune. Because of that, I was able to fall for you. So we'll definitely do something, but I want to wait just a bit. So, right now, the last thing I can offer you... Is this starry sky.",
        pic:
            "https://i.pinimg.com/236x/4a/d4/32/4ad432ac9808b9cea71b5460248afe51.jpg"),
    Question(
        anime: "Black Rock Shooter",
        character: "Mato Kuroi",
        quote:
            "To me, nothing is painful. There is no such thing as anguish. Even if some things seem like they hurt, deep down, everyone is a nice person. We can understand each other, or so I thought; or so I liked to think. I didn't want to wallow in misery. I didn't want to become spiteful. I just didn't want to be hurt. I didn't want to be hated.",
        pic:
            "https://i.pinimg.com/236x/73/18/1f/73181fb1b56e08651b80f40e45b76c5e.jpg"),
    Question(
        anime: "Yu Yu Hakusho",
        character: "Kazuma Kuwabara",
        quote:
            "Kurama really is a fox thing, and to think I let him near my kitten!",
        pic:
            "https://i.pinimg.com/236x/fb/d5/d0/fbd5d02d0450b4cb4cab9f13614a722f.jpg"),
    Question(
        anime: "Bleach",
        character: "Grimmjow Jeagerjaques",
        quote:
            "[to Ichigo] Don't forget my name, Soul Reaper, and you better pray that you never hear it again! Grimmjow Jaegerjaquez...because the next time you hear my name, you'll be a dead man...I promise.",
        pic:
            "https://i.pinimg.com/236x/ff/d4/49/ffd44932e3a04ec8c8b7c3e0a5b3bdd9.jpg"),
    Question(
        anime: "Soul Eater",
        character: "Patricia Thompson",
        quote: "Yeah it's going to be freaking awesome!",
        pic:
            "https://i.pinimg.com/236x/69/fe/55/69fe55c1106c2dbab4d8e9ef745b15a4.jpg"),
    Question(
        anime: "Grisaia no Kajitsu",
        character: "Kazuki Kazami",
        quote:
            "I believe that \"I could have done something\" is the most frustrating regret of them all.",
        pic:
            "https://i.pinimg.com/236x/e9/7a/d3/e97ad388a8dc4d1e3f3837147064f20f.jpg"),
    Question(
        anime: "Fate/zero",
        character: "Kotomine Kirei",
        quote:
            "Conflict is humanity's primal instinct. Eliminating it would mean eliminating humanity itself.",
        pic:
            "https://i.pinimg.com/236x/fa/0e/5c/fa0e5cd9bc13aae5865fe0ad8d0024b6.jpg"),
    Question(
        anime: "Fate/zero",
        character: "Gilgamesh",
        quote:
            "To unite dreams beneath a banner of conquest. I praise your efforts. But, warriors... did you not understand? That all dreams must disappear when the dreamer wakes. Every last one of them. Therefore, it was inevitable that I would stand in your way. King of Conquerors, know the end of your eternal dream. I, myself, shall show you harsh reality. Now awaken, Ea! A worthy stage has been set for you! Look up and behold... Enuma Elish!",
        pic:
            "https://i.pinimg.com/236x/62/8a/3e/628a3ea1e35eb70c1975a425ff870fc9.jpg"),
    Question(
        anime: "Baka to Test to Shoukanjuu",
        character: "Sakamoto Yuuji",
        quote:
            "Listen up you guys! This is the final battle! Grit your teeth and get ready to go with all your might! We're only aiming to win! It doesn't matter whether we're idiots or ordinary people or smart people! Everyone's to do whatever they can do! We're definitely... going to win this battle! Just watch, 3rd years...! I'm going to smash those heads of yours and show you how capable these idiots you look down on really are!",
        pic:
            "https://i.pinimg.com/236x/6e/71/7a/6e717a7a52b9d33a69773ab708bdbefa.jpg"),
    Question(
        anime: "Eyeshield 21",
        character: "Anezaki Mamori",
        quote:
            "You listen carefully, Sena. That's the one person you definitely do not want to associate with! That one called Hiruma, he's like a demon! Once he gets his eye on you, he'll drain all the life out of you until there's nothing left but skin and bones!",
        pic:
            "https://i.pinimg.com/236x/bd/e9/02/bde902c5d11af3698effa955243db5eb.jpg"),
    Question(
        anime: "Avatar: The Last Airbender",
        character: "Sokka",
        quote:
            "You want to walk into a Fire Nation town when they're all fired up with their, you know, fire?",
        pic:
            "https://i.pinimg.com/236x/a8/ea/bc/a8eabc0b201ff88cdffa1d4a720e59d0.jpg"),
    Question(
        anime: "Fairy Tail",
        character: "Mavis Vermillion",
        quote:
            "There are walls that can't be broken through power alone. But if there is a power that can break through those walls, it is the power of feelings.",
        pic:
            "https://i.pinimg.com/236x/01/d0/3f/01d03f9662c1921a12c0236314a8796f.jpg"),
    Question(
        anime: "Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka",
        character: "Hestia",
        quote:
            "In the end, guilt is just the question of whether you're capable of forgiving yourself or not. If you've really changed, then prove it with your actions.",
        pic:
            "https://i.pinimg.com/236x/04/26/91/0426919956987241a69da03fcbe6dfef.jpg"),
    Question(
        anime: "Bleach",
        character: "Tousen Kaname",
        quote:
            "[about his deceased friend] I never overcame my shyness and told her that I actually liked clouds.",
        pic:
            "https://i.pinimg.com/236x/8e/d9/ee/8ed9ee77d9fc878ef2e4613058f0f0f5.jpg"),
    Question(
        anime: "Bleach",
        character: "Toushirou Hitsugaya",
        quote:
            "[to Luppi] Hyourinmaru is the strongest of all ice-type Zanpakutoes. Your weapon may have eight arms, but mine is all the water in the atmosphere! Sennen Hyourou!! [causes several pillars of ice to form, before using them to crush Luppi] Sorry. Eight wasn't enough.",
        pic:
            "https://i.pinimg.com/236x/99/67/f5/9967f54a02d2961bfa0541f029ea03ce.jpg"),
    Question(
        anime: "Baccano!",
        character: "Graham Specter",
        quote:
            "Oh, life is fun! Try sayin' that ten times fast ten thousand times a minute every day for the rest of your life and it'll screw with your head so bad that all problems will disappear like MAGIC! Okay okay okay, I've gotten past the sadness and as of now I'm evolving to a HIGHER STAAAATE! Right? Tell me you all think so! Life is a magnificent beast, and it excites me!",
        pic:
            "https://i.pinimg.com/236x/b6/6d/bd/b66dbde9829f939789d62b5a1046f371.jpg"),
    Question(
        anime: "Hai to Gensou no Grimgar",
        character: "Haruhiro",
        quote:
            "Nobody knows what will happen in the future. Something even better might happen tomorrow.",
        pic:
            "https://i.pinimg.com/236x/e4/68/64/e46864a644388c31f7f798bcd7728691.jpg"),
    Question(
        anime: "Denpa Onna to Seishun Otoko",
        character: "Denpa Onna to Seishun Otoko",
        quote:
            "People's mind are like alien existence. We don't know where they are, and we can barely scratch the surface of what they really are.",
        pic:
            "https://i.pinimg.com/236x/80/1a/46/801a461f040fcce2c68244d0d7e5e19f.jpg"),
    Question(
        anime: "Zetsuen No Tempest",
        character: "Yoshino Takigawa",
        quote: "Lovers don't need words to communicate.",
        pic:
            "https://i.pinimg.com/236x/1b/f2/7e/1bf27e12c415036e01815878cc9c5540.jpg"),
    Question(
        anime: "Pokémon",
        character: "Haruka",
        quote:
            "But just between you and I, what I'm more interested in is traveling and seeing new places. (screams as she goes down a hill after being scared by a Duskull) I guess I... shoulda worn a... (crashes into a tree) helmet.",
        pic:
            "https://i.pinimg.com/236x/84/40/b5/8440b58040009739ee1b7f02f0b629f3.jpg"),
    Question(
        anime: "Princess Princess",
        character: "Tooru Kouno",
        quote:
            "When things change, isn't it better to get used to the new situation quickly? If that's the case, it's better to know what you have to do. Rejecting everything and doing things half-heartedly won't make it any easier. Hanging onto your pride will only weigh you down. So, to make life easier, sometimes it's best to go along with what other people want. As I said, it's just like the old saying: \"When in Rome, do as the Romans do\". Instead of others forcing it upon you, it's easier for you to want to do it yourself, right? You should try it, Mikoto. You'll be happier.",
        pic:
            "https://i.pinimg.com/236x/20/2c/df/202cdf5b6c64bed86fbeff4a279364fb.jpg"),
    Question(
        anime: "One Piece",
        character: "Brook",
        quote: "\"Loneliness\" is no longer part of my vocabulary.",
        pic:
            "https://i.pinimg.com/236x/3b/39/3e/3b393e554a8a1ccd82d1af76ba2d8d06.jpg"),
    Question(
        anime: "Yahari Ore No Seishun Love Come Wa Machigatteiru",
        character: "Yukino Yukinoshita",
        quote:
            "I think, if you want to improve yourself, you should challenge your own limits.",
        pic:
            "https://i.pinimg.com/236x/de/bb/36/debb368d668c7373c80166e38726d685.jpg"),
    Question(
        anime: "Natsuyuki Rendezvous",
        character: "Atsushi Shimao",
        quote:
            "At the end of my life, it was just the two of us... You told me not to leave then so I decided not to go anywhere.",
        pic:
            "https://i.pinimg.com/236x/13/e8/c7/13e8c7ca98cc60b7f5d6852cdf27b953.jpg"),
    Question(
        anime: "Deadman Wonderland",
        character: "Shiro",
        quote: "Being awesome is being nothing but yourself~",
        pic:
            "https://i.pinimg.com/236x/0d/20/15/0d2015a78e01cb5855920c228ea0469f.jpg"),
    Question(
        anime: "Aldnoah.Zero",
        character: "Inaho Kaizuka",
        quote: "Human beings aren't known for remaining calm and rational.",
        pic:
            "https://i.pinimg.com/236x/5f/4e/73/5f4e731deace064a14293af8db53df88.jpg"),
    Question(
        anime: "Soul Eater",
        character: "Death the Kid",
        quote:
            "That is why I prefer using you two pistols. There is symmetry to wielding you two, right? (Getting aggravated) But when you two are in human form, your hairstyles and your heights are completely different... (Grabs their breasts) Even your cup sizes are completely different!",
        pic:
            "https://i.pinimg.com/236x/db/c6/1f/dbc61fe0db199cf0f131c24acf2089d7.jpg"),
    Question(
        anime: "Fruits Basket",
        character: "Kyoko Honda",
        quote:
            "I love you!! Even if you go bald or like underage girls, I can handle it! I'm crazy with love!! (Young Kyoko talking to Tohru's fatherher husband)",
        pic:
            "https://i.pinimg.com/236x/a3/c2/e0/a3c2e01f3ee6894eea8c7f56cad8611c.jpg"),
    Question(
        anime: "Koi to Uso",
        character: "Nejima Yukari",
        quote:
            "Even though you like someone already, your partner is decided for you... and you can't do anything about that crush. Because everyone keeps getting in the way... and saying you can't... But... when you're the one in love... the only thing that feels true... is that feeling.",
        pic:
            "https://i.pinimg.com/236x/0f/f1/85/0ff185756897b9ff1762efc12b100a58.jpg"),
    Question(
        anime: "Gintama",
        character: "Kotarō Katsura",
        quote:
            "We could drive them off the entire earth if we had your strength, Gintoki!",
        pic:
            "https://i.pinimg.com/236x/a8/b3/b4/a8b3b401cd6ea5206823dacf85f28bd5.jpg"),
    Question(
        anime: "Hirunaka no Ryuusei",
        character: "Yuyuka Nekota",
        quote:
            "You wouldn't get an answer no matter how much you think about it. Love is not Japanese nor Math. It doesn't need thoughts of reasons. You will be aware of it when that person is next to you.",
        pic:
            "https://i.pinimg.com/236x/eb/1d/79/eb1d79a2ca329614e2517bfa6a1d9a86.jpg"),
    Question(
        anime: "Hyouka",
        character: "Oreki Houtarou",
        quote:
            "People remember their high school days as the high point of their lives. People say these things because everyone holds fond memories of their time in high school; however, I doubt that every high school student would want to remember their school life that way. For example, if neither studying, nor sports, nor socializing are of interest to someone, what then? What if there are students who prefer to keep a low profile? Though I guess that would be a pretty lonely way to live.",
        pic:
            "https://i.pinimg.com/236x/41/c0/6a/41c06a5b550ebbca0e95ef706ad24a08.jpg"),
    Question(
        anime: "Tonari No Kaibutsu-kun",
        character: "Yoshida Haru",
        quote:
            "I have someone I like. I never had the confidence and I’ve doubted my feelings countless of times. But, when she stays by my side and smiles with me, I feel like I can do anything.",
        pic:
            "https://i.pinimg.com/236x/60/c0/82/60c082a424ec86912e54782d553b9650.jpg"),
    Question(
        anime: "Hataraku Maou-sama!",
        character: "Ashiya Shirou",
        quote: "Sometimes it's necessary to courageously retreat.",
        pic:
            "https://i.pinimg.com/236x/53/5d/88/535d88c1887f26a5d0a9813cdcdab052.jpg"),
    Question(
        anime: "Bungou Stray Dogs",
        character: "Francis Scott Key Fitzgerald",
        quote:
            "Wealth is a nightmare. With each coveted thing we buy, we lose a thing we dream about.",
        pic:
            "https://i.pinimg.com/236x/10/0d/56/100d563b25c53efc0c877533783224fd.jpg"),
    Question(
        anime: "Mahou Shoujo Madoka Magica",
        character: "Sayaka Miki",
        quote:
            "It really shouldn't be all that uncommon - having a wish you'd go so far as to trade your life for. I think there are a lot of people in the world with wishes and desires like that. If we can't think of anything, it just means that we really haven't had anything that bad happen to us. We've had too much given to us and have become dull and stupid. It makes me wonder: Why us?\n\nDon't you think it's unfair? I'm sure there are other people who'd really want a chance like this.",
        pic:
            "https://i.pinimg.com/236x/32/bd/c7/32bdc70968ddc0427767bf575fe2c236.jpg"),
    Question(
        anime: "Bleach",
        character: "Tousen Kaname",
        quote:
            "to Komamura Don't make me laugh. Aizen-sama has given me something far more powerful than a bankai.",
        pic:
            "https://i.pinimg.com/236x/8e/d9/ee/8ed9ee77d9fc878ef2e4613058f0f0f5.jpg"),
    Question(
        anime: "Tamako Market",
        character: "Kunio Yaobi",
        quote:
            "If you think music is only made of sounds, you're mistaken. Silence is also part of music.",
        pic:
            "https://i.pinimg.com/236x/37/24/d9/3724d9c377173ed843c798b613619ba2.jpg"),
    Question(
        anime: "Kami Nomi zo Shiru Sekai",
        character: "Keima Katsuragi",
        quote:
            "If everyone were perfect, there would be no need to look out for others. Sympathy or love is needed because people are imperfect. A perfect human cannot love anyone.",
        pic:
            "https://i.pinimg.com/236x/b3/94/d5/b394d59a2a1a2e951fa23f84a7b6ee3e.jpg"),
    Question(
        anime: "Nisekoi",
        character: "Ichijou Raku",
        quote:
            "But... If you're the kind of person who can devote herself like that to someone, then I'll bet you anything there's someone out there who'll fall in love with you.",
        pic:
            "https://i.pinimg.com/564x/7a/ac/c0/7aacc022e2175103821013adc4c75701.jpg"),
    Question(
        anime: "Shingeki no Kyojin",
        character: "Levi Ackerman",
        quote:
            "The difference in judgement between you and me, originates from different rules derived from past experience.",
        pic:
            "https://i.pinimg.com/236x/40/7b/32/407b329f274abb8a436dc8c98d2588ad.jpg"),
    Question(
        anime: "Death Note",
        character: "Mello",
        quote:
            "Oh, I almost forgot. In the event that anyone besides big-headed Near or the deluded murderer is reading these notes, then I should at least perform the basic courtesy of introducing myself, here at the end of the prologue. I am your narrator, your navigator, your storyteller. For anyone else but those two, my identity may be of no interest, but I am the old world's runner-up, the best dresser that died like a dog, Mihael Keehl. I once called myself Mello and was addressed by that name, but that was a long time ago.",
        pic:
            "https://i.pinimg.com/236x/13/47/bf/1347bf8351759f9af1d5cea52f8a73be.jpg"),
    Question(
        anime: "Tower Of God",
        character: "Twenty-Fifth Baam",
        quote: "Your god is a fragment of your imagination from your weakness.",
        pic:
            "https://i.pinimg.com/236x/9b/d5/3d/9bd53da0e90947321960f3e0282edad8.jpg"),
    Question(
        anime: "SERVAMP",
        character: "Shirota Mahiru",
        quote:
            "I was curious. Mikuni-san and Tsuyuki-senpai are the same. You say you'll \"destroy\" vampires. You never say \"kill\". Senpai. You've never seen a vampire playing games while lazing around the house, have you? A vampire crying that they're \"sorry for lying\" and regretting... A really bothersome NEET vampire who fought to protect a human he had just met too! I've seen a lot more than just their bad sides. They're all my comrades. You know, it'd be good if you just talked about what's bothering you too. Neither humans nor vampires need reasons to want to protect or save something. If they find C3 is weakening, the balance between humans and non-humans will collapse. If we suffer major damage from Tsubaki's side and asked you all for help, can you guarantee that none of the other vampires would attack C3? I don't really know... what the situation between vampires and C3 is, but, simply put, we need to protect it all, so that nobody gets hurt!",
        pic:
            "https://i.pinimg.com/236x/36/2a/40/362a40c3a0ceacefbb0ba38978c45720.jpg"),
    Question(
        anime: "Hataraku Maou-sama!",
        character: "Rika Suzuki",
        quote:
            "If people want to, they can become angels or demons themselves.",
        pic:
            "https://i.pinimg.com/236x/64/77/39/647739d25edc01ec7823d8737db71d4c.jpg"),
    Question(
        anime: "Haikyuu!!",
        character: "Shōyō Hinata",
        quote: "It's true that I'm not very tall. However! I can jump!",
        pic:
            "https://i.pinimg.com/236x/e1/26/e1/e126e1b5ca88b9bfa4182fad3a695036.jpg"),
    Question(
        anime: "Fruits Basket",
        character: "Sohma Hatori",
        quote:
            "It's true, crying unexpectedly does make you feel better. When you're an adult you forget that.",
        pic:
            "https://i.pinimg.com/236x/62/9c/d9/629cd990a6bf6d1f95e855dc885561fd.jpg"),
    Question(
        anime: "Dragon Ball",
        character: "Bulma",
        quote:
            "Yamcha, I was worried about you. For all I knew, you were dead in a ditch in a country you can't pronounce. You'll have to make this up to me. And you're going to enjoy it.",
        pic:
            "https://i.pinimg.com/236x/ca/9c/a6/ca9ca6ebf42dc0acb57e019905597443.jpg"),
    Question(
        anime: "Neon Genesis Evangelion",
        character: "Rei Ayanami",
        quote: "Those who hate themselves, cannot love or trust others.",
        pic:
            "https://i.pinimg.com/236x/1a/e1/0f/1ae10f526661e3b924ca9fde83e2b514.jpg"),
    Question(
        anime: "Yu Yu Hakusho",
        character: "Yuusuke Urameshi",
        quote: "You can't end a good party without someone on the floor.",
        pic:
            "https://i.pinimg.com/236x/1a/99/e8/1a99e8c630e0bdd54ff1609c7bd112e3.jpg"),
    Question(
        anime: "CLANNAD",
        character: "Yoshino Yūsuke",
        quote:
            "He realized that he had lost sight of something important. No matter what turn he took he should have kept singing. Even if his songs couldn’t save the world, he could still sing songs for her. Don’t ever lose sight of what’s important to you.",
        pic:
            "https://i.pinimg.com/236x/17/b2/24/17b22454468aaa0151c2f95a56d21958.jpg"),
    Question(
        anime: "Dragon Ball Z",
        character: "Android 17",
        quote:
            "A beautiful speech, I can see it now, you truly are a prince with the royal blood of a Saiyan.",
        pic:
            "https://i.pinimg.com/236x/b3/a0/e9/b3a0e9904b07eb5cd5aa85c3ae017464.jpg"),
    Question(
        anime: "The Garden of Sinners",
        character: "Aozaki Touko",
        quote:
            "The words “fly” and “fall” are tied together. But the more you're hooked to flying, the more you forget about that fact. As a result, you end up trying to reach the skies even after you die. Not falling to the ground, but falling toward the sky.",
        pic:
            "https://i.pinimg.com/236x/68/9f/c2/689fc23eaa459630e740ee1aff73f8f2.jpg"),
    Question(
        anime: "Hunter X Hunter",
        character: "Kurapika",
        quote:
            "A beast in human's clothing understands better than anyone how people want to be treated.",
        pic:
            "https://i.pinimg.com/236x/47/25/ef/4725efa3141943edb3854f1433f66922.jpg"),
    Question(
        anime: "Magi - The Labyrinth of Magic",
        character: "Alibaba Saluja",
        quote:
            "Friends are like balloons. Once you let them go, you can't get them back. So I'm going to tie you to my heart, so to never lose you.",
        pic:
            "https://i.pinimg.com/236x/0c/10/01/0c1001168f9b302f69e557faae97c22d.jpg"),
    Question(
        anime: "Code Geass: Lelouch of the Rebellion",
        character: "Lelouch Lamperouge",
        quote:
            "Shut up! I did what I had to do. People lie to survive. No one is blameless.",
        pic:
            "https://i.pinimg.com/236x/a4/30/8e/a4308e202b0b9c2e4e9d41c9b8d4a06d.jpg"),
    Question(
        anime: "A Certain Scientific Railgun",
        character: "Kuroko Shirai",
        quote:
            "If you have the will to follow through with your beliefs, the results will follow naturally.",
        pic:
            "https://i.pinimg.com/236x/b3/ed/41/b3ed4117f8c46c6203167ed90beee8bc.jpg"),
    Question(
        anime: "One Piece",
        character: "Dracule Mihawk",
        quote: "I'm not stupid enough to use a cannon to hunt a rabbit.",
        pic:
            "https://i.pinimg.com/236x/3f/31/4c/3f314cd7ec6b3feef93f91c76df7ef11.jpg"),
    Question(
        anime: "Kino No Tabi",
        character: "Kino",
        quote:
            "Being able to forget things you want to forget, and being able to remember things you want to remember, is such a great thing, you know?",
        pic:
            "https://i.pinimg.com/236x/b8/79/b4/b879b4c5ad97623f6b066264158ab820.jpg"),
    Question(
        anime: "Fairy Tail",
        character: "Erza Scarlet",
        quote:
            "Always trying to make myself seem strong... So I locked my own heart in a suit of armor.",
        pic:
            "https://i.pinimg.com/236x/07/cc/57/07cc5707c0ef95e4f71d0a7592b7da26.jpg"),
    Question(
        anime: "Toriko",
        character: "Toriko",
        quote:
            "In this world, there's no such thing as \"failure\" in the first place. The one who knows the \"ways to win\" more than anyone is also the one who's experienced the most \"mistakes\". In other words... You could say \"failure\" is equal to \"success\"... Couldn't you?",
        pic:
            "https://i.pinimg.com/236x/2b/99/72/2b9972c37d307c90c2a1fcaa8a3f985d.jpg"),
    Question(
        anime: "Fate/zero",
        character: "Rider",
        quote:
            "Then you swear that, once I defeat an enemy, you will buy me pants?",
        pic:
            "https://i.pinimg.com/236x/4b/bf/2a/4bbf2af2d9a0caa26c14b1e56784ec00.jpg"),
    Question(
        anime: "Kekkai Sensen",
        character: "Mary Macbeth",
        quote:
            "Don't you think it's futile to live in fear of death? I mean, everyone is going to die sometime, so is there any point in pretending not to see it for the present? Or instead, I wonder if they think it doesn't concern them, since they aren't going to die.",
        pic:
            "https://i.pinimg.com/236x/c0/42/87/c04287dee578c225d7ec0afc0e1ef739.jpg"),
    Question(
        anime: "Pokémon",
        character: "Kojirou",
        quote: "We have a proud tradition of failure to uphold!",
        pic:
            "https://i.pinimg.com/236x/17/7c/c7/177cc79bd7ad1724a21862e118538db3.jpg"),
    Question(
        anime: "Nanbaka",
        character: "Uno",
        quote: "There's more to a real man than just his good looks!",
        pic:
            "https://i.pinimg.com/236x/be/08/3b/be083b42828f5752778bc2035cbdb09e.jpg"),
    Question(
        anime: "World Trigger",
        character: "Osamu Mikumo",
        quote: "Rules make the world work. They don't protect you.",
        pic:
            "https://i.pinimg.com/236x/5b/e3/6c/5be36c80f3c5bbe2fb0080aaee0cc13b.jpg"),
    Question(
        anime: "Fate/stay night",
        character: "Emiya Kiritsugu",
        quote: "Saving someone means not saving someone else.",
        pic:
            "https://i.pinimg.com/236x/36/0b/cd/360bcde55985358f635c667cb1e68dc9.jpg"),
    Question(
        anime: "Yu Yu Hakusho",
        character: "Hiei",
        quote:
            "Kurama, do not make me come over there and remove that precious thing you call a voice box.",
        pic:
            "https://i.pinimg.com/236x/3b/ab/4f/3bab4f9436016d0d6752937ff01b20d5.jpg"),
    Question(
        anime: "Bakemonogatari",
        character: "Koyomi Araragi",
        quote: "I don't want that kind of twisted love.",
        pic:
            "https://i.pinimg.com/236x/e9/af/3b/e9af3bfc6aaac2f6b813bda561267c25.jpg"),
    Question(
        anime: "Inuyasha",
        character: "Inuyasha",
        quote:
            "I'm a half-demon, more egotistical and greedy than any other living creature — that's what human beings are, right?.. But with human blood flowing through my veins, I never give up! Don't you understand? When you have someone to protect, your power increases multifold!",
        pic:
            "https://i.pinimg.com/236x/99/21/da/9921daf77eeda4542a973d2ee33292e4.jpg"),
    Question(
        anime: "CLANNAD",
        character: "Furukawa Nagisa",
        quote:
            "Life can bring lots of hardships, but it's always important to keep in mind that there are people around you who care for you, and are willing to help you through whatever you're dealing with.",
        pic:
            "https://i.pinimg.com/236x/64/36/7a/64367a7add12d0a2deb22d1fd777a445.jpg"),
    Question(
        anime: "Soul Eater",
        character: "Medusa Gorgon",
        quote:
            "Um well Miss Maka? Can you do me a favor and help me out with your father? I can't get him off my leg.",
        pic:
            "https://i.pinimg.com/236x/b7/73/be/b773be35db09ae708b12a65d1ae6eb8f.jpg"
            ""),
    Question(
        anime: "Ao no Exorcist",
        character: "Shima Kinzou",
        quote: "I can only tell the fortune of girls.",
        pic:
            "https://i.pinimg.com/236x/e2/f3/41/e2f34105973eac5566273a169eedc296.jpg"),
    Question(
        anime: "One Piece",
        character: "Monkey D. Luffy",
        quote:
            "Power isn't determined by your size, but the size of your heart and dreams!",
        pic:
            "https://i.pinimg.com/236x/42/08/e8/4208e8d74cadc712cf15101d009bc3b8.jpg"),
    Question(
        anime: "Bleach",
        character: "Kurosaki Isshin",
        quote: "GOOD MOOOORNING ICHIGOOOOOO!!!!",
        pic: "https://i.pinimg.com/236x/23/83/14/2383140e6e52343666b7109ab776688c.jpg"),
    Question(
        anime: "Neon Genesis Evangelion",
        character: "Misato Katsuragi",
        quote: "Survivability takes priority.",
        pic:
            "https://i.pinimg.com/236x/e9/af/ab/e9afaba7037da6a18a15a00eb212ac1f.jpg"),
    Question(
        anime: "Avatar: The Last Airbender",
        character: "Azula",
        quote:
            "*to Zuko* Why would father want YOU back? Except to lock you up where you can no longer embarrass him!",
        pic:
            "https://i.pinimg.com/236x/6a/af/31/6aaf3101b3fcf43e660351b38d6e8192.jpg"),
    Question(
        anime: "Deadman Wonderland",
        character: "Ganta Igarashi",
        quote:
            "There's nothing that won't change, every day things will change a little bit more.",
        pic:
            "https://i.pinimg.com/236x/17/3c/a2/173ca2bf4b560ccd5bf8988152528c68.jpg"),
    Question(
        anime: "Bakemonogatari",
        character: "Senjougahara Hitagi",
        quote:
            "Although my life hasn't been very fortunate until now, I'm glad if I caught your eye because of that misfortune...",
        pic: "Senjougahara Hitagi"),
    Question(
        anime: "CLANNAD",
        character: "Sagara Misae",
        quote:
            "If you get all worked up yourself, you’ll always get someone who’ll rebel. Being too eager brings negative results.",
        pic:
            "https://i.pinimg.com/236x/87/10/2b/87102b2448db17347c63817b908bad00.jpg"),
    Question(
        anime: "Gintama",
        character: "Shimura Shinpachi",
        quote:
            "[Shinpachi and Kagura are stuck in a trashcan, and have been pushed onto the train tracks. Shinpachi sees a train coming]This timing's just like some manga!",
        pic:
            "https://i.pinimg.com/236x/da/32/76/da3276782e4058c9b9a9d85477d7aa94.jpg"),
    Question(
        anime: "Pokémon",
        character: "Kasumi",
        quote:
            "Very funny. Carrots, peppers, and bugs! Everyone has something they don't like and I don't like bugs!",
        pic:
            "https://i.pinimg.com/236x/b9/a4/12/b9a4122a607f289096039de228deb840.jpg"),
    Question(
        anime: "Shingeki no Kyojin",
        character: "Ymir",
        quote:
            "Living this way is my way of getting revenge!! I'm going to be living proof that your fate isn't decided at birth!! So what about you?! You're going to kill yourself, the ultimate act of submission. Is that how much you want to please the people who treated you like a nuisance?! Why are you trying to hurt yourself?! If your will is that strong... Then shouldn't you be able to change your fate?!",
        pic:
            "https://i.pinimg.com/236x/20/02/ca/2002ca9b681885d4a64fc113e8e44d75.jpg"),
    Question(
        anime: "Kokoro Connect",
        character: "Taichi Yaegashi",
        quote:
            "What you can't accomplish alone, becomes doable when you're with someone else.",
        pic:
            "https://i.pinimg.com/236x/05/32/3c/05323c313b7a8bf239f7d65de2110fef.jpg"),
    Question(
        anime: "Fullmetal Alchemist",
        character: "Edward Elric",
        quote: "By the way, I don't get my skills from a pocketwatch.",
        pic:
            "https://i.pinimg.com/236x/fe/7e/32/fe7e32c974bde46bc188332ca3fa7810.jpg"),
    Question(
        anime: "Naruto",
        character: "Hatake Kakashi",
        quote:
            "I'm Hatake Kakashi. Things I like and things I hate? I don't feel like telling you that. My dreams for the future? Never really thought about that. As for my hobbies... I have lots of hobbies.",
        pic:
            "https://i.pinimg.com/236x/8e/e4/8d/8ee48d2bf6da5ce3d542142621e474e7.jpg"),
    Question(
        anime: "Death Note",
        character: "Near",
        quote:
            "I've wanted to make him taste his own pathetic failure with all my heart.",
        pic:
            "https://i.pinimg.com/236x/ff/02/b9/ff02b973a48e347a7dc71c1a36a1a0a0.jpg"),
    Question(
        anime: "Steins;Gate",
        character: "Moeka Kiryū",
        quote:
            "People... need to be needed by someone in order to live. If a person isn't needed, they're worthless!",
        pic:
            "https://i.pinimg.com/236x/ca/00/92/ca009270748901171c54420670e93589.jpg"),
    Question(
        anime: "Kuroshitsuji",
        character: "Grell Sutcliff",
        quote:
            "Look what happens when you're not fast enough! You get CUT! It's more fun when it hurts a little bit though, isn't it?",
        pic:
            "https://i.pinimg.com/236x/9e/c8/3b/9ec83bac18606b90aa066c8744f4b1e2.jpg"),
    Question(
        anime: "Pokémon",
        character: "Ash Ketchum",
        quote: "I'm an apple for a day and I need a doctor right away...",
        pic:
            "https://i.pinimg.com/236x/f6/f9/53/f6f95397b8817397e485a7c049b889c1.jpg"),
    Question(
        anime: "Vinland Saga",
        character: "Canute",
        quote:
            "The world...God's divine creation...Is so brimming with love...Yet there is no love in the hearts of men.",
        pic:
            "https://i.pinimg.com/236x/8f/ec/73/8fec739dd165b331f18bcfa4c96fa721.jpg"),
    Question(
        anime: "Toradora!",
        character: "Taiga Aisaka",
        quote:
            "I hate waiting, but if waiting means being able to be with you I'll wait for as long as forever.",
        pic:
            "https://i.pinimg.com/236x/05/47/61/054761e12ef1649af5473f42bafba9b3.jpg"),
    Question(
        anime: "Angel Beats!",
        character: "Yuzuru Otonashi",
        quote:
            "One person needed courage to face the past.\nAnother person needed effort to make a dream come true.\nYet another person needed time and friends.\nWhat about you?",
        pic:
            "https://i.pinimg.com/236x/95/7f/f8/957ff8d21afd2c505b6797ebdccf5ed6.jpg"),
    Question(
        anime: "Sword Art Online",
        character: "Akihiko Kayaba",
        quote: "In every world, once you die, you're gone.",
        pic:
            "https://i.pinimg.com/236x/00/89/98/008998d54e3cf14483c6cadb898a3c53.jpg"),
    Question(
        anime: "Air",
        character: "Yukito Kunisaki",
        quote:
            "There is a meaning for wings that cannot fly! It's a precious memory of when you once flew in the sky.",
        pic:
            "https://i.pinimg.com/236x/46/05/3c/46053cc32ff5b6387fd1930b89d1471c.jpg"),
    Question(
        anime: "Bleach",
        character: "Kira Izuru",
        quote:
            "War is not heroic. War is not exhilarating. War is full of despair. It's dark. It's dreadful. It's a thing of sorrow and gloom.",
        pic:
            "https://i.pinimg.com/236x/7a/1b/58/7a1b589f7eccd25d31241dcdf5ecaf8e.jpg"),
    Question(
        anime: "Dragon Ball",
        character: "Vegeta",
        quote:
            "Don't remind me. I'm mad enough to hurt somebody and pounding you just might be the therapy I need.",
        pic:
            "https://i.pinimg.com/236x/0b/d8/01/0bd801ea701a6e0908e270d281d19274.jpg"),
    Question(
        anime: "Kuroko No Basket",
        character: "Taiga Kagami",
        quote: "This is our show. We're the ones who are writing the script.",
        pic:
            "https://i.pinimg.com/236x/7b/2e/63/7b2e630c311c9d4e84c135e2af137f55.jpg"),
    Question(
        anime: "Bleach",
        character: "Ulquiorra Schiffer",
        quote:
            "(To Ichigo Kurosaki) Do not allow yourself to be shaken. Do not weaken your stance. Open your senses. And do not let your guard down for an instant.",
        pic:
            "https://i.pinimg.com/236x/e8/64/da/e864daa77d45fd52e812e8c5e0b1ac61.jpg"),
    Question(
        anime: "Soul Eater",
        character: "Black Star",
        quote:
            "Assassins Rule Number Two - Transpositional Thinking: Analyze the target in order to predict his thoughts and movements.",
        pic:
            "https://i.pinimg.com/236x/5e/6b/78/5e6b78601c2d7bd73ec9d78832f9fba6.jpg"),
    Question(
        anime: "CLANNAD",
        character: "Sakagami Tomoyo",
        quote:
            "I've already decided. Getting good grades and listening to teachers can take me somewhere high and far away, but what if that's not where I want to go? Right here, by your side, Tomoya, is the only place I want to be.",
        pic:
            "https://i.pinimg.com/236x/51/86/b8/5186b89483fc18c6f40befe2da78a125.jpg"),
    Question(
        anime: "Gintama",
        character: "Gintoki Sakata",
        quote:
            "What is it, you? Bang bang banging on people's heads like that. Are you hoping to become a tambourine player? If you don't like Shin-chan, then how about Sen-chan from secret operation?",
        pic:
            "https://i.pinimg.com/236x/30/e3/95/30e395688db8bcec38f59bc90fe83e3f.jpg"),
    Question(
        anime: "Tokyo Ghoul",
        character: "Kaneki Ken",
        quote:
            "Human relationships are chemical reactions. If you have a reaction then you can never return back to your previous state of being.",
        pic:
            "https://i.pinimg.com/236x/02/df/a1/02dfa1fc75e8bc057cc957987fbcc6fa.jpg"),
    Question(
        anime: "Sword Art Online",
        character: "Kazuto Kirigaya",
        quote:
            "All this time, I seriously thought that it's better to die than to live your life alone."),
    Question(
        anime: "Yu-Gi-Oh!",
        character: "Yami Yugi",
        quote: "It's game time!",
        pic:
            "https://i.pinimg.com/236x/f9/61/a1/f961a1cbfd579bfb56514a4dff1f2462.jpg"),
    Question(
        anime: "Highschool Of The Dead",
        character: "Kouta Hirano",
        quote:
            "(to Komuro Takashi) In a war like this, there is no surrender or shit like that.",
        pic:
            "https://i.pinimg.com/236x/ac/b6/f3/acb6f39e72f8da546d8d666bb6b44836.jpg"),
    Question(
        anime: "Gintama",
        character: "Kotarō Katsura",
        quote: "Love is based on unpredictable events.",
        pic:
            "https://i.pinimg.com/236x/9d/78/78/9d78784e56cd24fa86239a575b8e3c20.jpg"),
    Question(
        anime: "Ao Haru Ride",
        character: "Yoshioka Futaba",
        quote:
            "If you lose something, just build it again. And this time, with a greater care.",
        pic:
            "https://i.pinimg.com/236x/5b/9d/2c/5b9d2cce88635d3e90a751d126f4264b.jpg"),
    Question(
        anime: "Dragon Ball Z",
        character: "Whis",
        quote:
            "Well, I wonder what the prince would do if he knew, you authorized Planet Vegeta’s destruction from the start?",
        pic:
            "https://i.pinimg.com/236x/b8/f0/4b/b8f04b69d23638da8bf8e848baa65d05.jpg"),
    Question(
        anime: "Detective Conan",
        character: "Shinichi Kudou",
        quote:
            "People's feelings sometimes go astray and lead to irreversible consequences.",
        pic:
            "https://i.pinimg.com/236x/92/eb/17/92eb174b5ae3ded5ffef48e7471002ac.jpg"),
    Question(
        anime: "Naruto",
        character: "Madara Uchiha",
        quote:
            "Man seeks peace, yet at the same time yearning for war... Those are the two realms belonging solely to man. Thinking of peace whilst spilling blood is something that only humans could do. They're two sides of the same coin... to protect something... another must be sacrificed.",
        pic:
            "https://i.pinimg.com/236x/61/09/59/610959be44ba196fdf7145ad54000894.jpg"),
    Question(
        anime: "Dragon Ball Z",
        character: "Vegeta",
        quote:
            "Every time I reach a new level of strength, a greater power appears to challenge my authority. It’s as if fate is laughing at me with a big stupid grin, just like Kakarot.",
        pic:
            "https://i.pinimg.com/236x/0b/d8/01/0bd801ea701a6e0908e270d281d19274.jpg"),
    Question(
        anime: "Shingeki no Kyojin: Lost Girls",
        character: "Carly Stratmann",
        quote:
            "They don't know that once you lose something, you can never get it back again.",
        pic:
            "https://i.pinimg.com/236x/00/eb/d7/00ebd7219c5a0068282acc0be384d4be.jpg"),
    Question(
        anime: "Fullmetal Alchemist: Brotherhood",
        character: "Lust",
        quote:
            "Blood calls for blood, while hatred begets hatred, and the energy that comes forth begins to take root in this earth and engraves a crest of blood. They never learn, no matter how many times history is repeated. Humans are foolish, sorrowful creatures.",
        pic:
            "https://i.pinimg.com/236x/8b/c3/5a/8bc35a06713311d324378a25a79396a9.jpg"),
    Question(
        anime: "Claymore",
        character: "Teresa",
        quote:
            "[Last words] All right then, I'll put you out of your misery. [Her hands are sliced off] Eh?",
        pic:
            "https://i.pinimg.com/236x/98/d9/e1/98d9e14acc71ec535560b6c18b9a07e8.jpg"),
    Question(
        anime: "Steins;Gate",
        character: "Kurisu Makise",
        quote: "Who'd eat a pervert's banana? *blushing*",
        pic:
            "https://i.pinimg.com/236x/a3/09/c3/a309c3d99b7881a0db4390fceadca653.jpg"),
    Question(
        anime: "Pokémon",
        character: "Kojirou",
        quote: "This steak is too well done. Take it back and make it rare.",
        pic:
            "https://i.pinimg.com/236x/17/7c/c7/177cc79bd7ad1724a21862e118538db3.jpg"),
    Question(
        anime: "Shingeki no Kyojin",
        character: "Hange Zoe",
        quote:
            "If there's something you don't understand, learn to understand it.",
        pic:
            "https://i.pinimg.com/236x/0c/1a/29/0c1a290da9113da126668d533b36f3dd.jpg"),
    Question(
        anime: "Naruto Shippūden",
        character: "Pain",
        quote:
            "Feel pain, think about pain, accept pain, know pain... Shinra Tensei!",
        pic:
            "https://i.pinimg.com/236x/a4/f4/b5/a4f4b57def9711a180534002d07fe301.jpg"),
    Question(
        anime: "Durarara!!",
        character: "Kyohei Kadota",
        quote:
            "If you want to run from your past, fine. But whatever you do, don't run away from your present or worse, your future.",
        pic:
            "https://i.pinimg.com/236x/ff/db/02/ffdb022119ec5398bc04e17f4b10bdb1.jpg"),
    Question(
        anime: "Sword Art Online",
        character: "Asuna Yūki",
        quote:
            "Sometimes the things that matter the most are right in front of you.",
        pic:
            "https://i.pinimg.com/236x/e8/40/c1/e840c117e27fd3e5bf6751a5e85039df.jpg"),
    Question(
        anime: "Fullmetal Alchemist",
        character: "Scar",
        quote:
            "For one that turns against God to come in person to receive judgement... Today is a good day!",
        pic:
            "https://i.pinimg.com/236x/ee/6a/1b/ee6a1b214e490d53dd07f4c3e455cb1a.jpg"),
    Question(
        anime: "Fairy Tail",
        character: "Gajeel Redfox",
        quote:
            "You taught me what it means to love, and for that I will be eternally grateful.",
        pic:
            "https://i.pinimg.com/236x/cd/0a/be/cd0abe511e2d1c00a77784d7ea71c21e.jpg"),
    Question(
        anime: "Naruto",
        character: "Nara Shikamaru",
        quote:
            "*To Temari* It really doesn't matter to me if I ever become a chūnin or not, but I guess I shouldn't let myself be beaten by a female, so let's do it.",
        pic:
            "https://i.pinimg.com/236x/91/88/0b/91880bcac6bebedb280b8de85006d525.jpg"),
    Question(
        anime: "Death Note",
        character: "Ryuk",
        quote: "That was worth an academy award, Light.",
        pic:
            "https://i.pinimg.com/236x/6c/ad/c8/6cadc89fb96008750ade409020c4a903.jpg"),
    Question(
        anime: "Cowboy Bebop",
        character: "Faye Valentine",
        quote:
            "They often say that humans can't live alone. But you can live pretty long by yourself. Instead of feeling alone in a group, it's better to be alone in your solitude.",
        pic:
            "https://i.pinimg.com/236x/94/c8/e1/94c8e1af876d7cc771a0b3026105e45b.jpg"),
    Question(
        anime: "Dragon Ball",
        character: "Son Goku",
        quote: "That's what you think, Captain Cocky!",
        pic:
            "https://i.pinimg.com/236x/11/df/d8/11dfd8a854ec1ee9fa2fd218ed536aae.jpg"),
    Question(
        anime: "One Piece",
        character: "Eustass Kid",
        quote:
            "Compared to the \"righteous\" greed of the rulers, the criminals of the world seem much more honorable. When scum rules the world, only more scum is born.",
        pic:
            "https://i.pinimg.com/236x/10/9d/53/109d535a623497b7a26e293b5f98db4e.jpg"),
    Question(
        anime: "Naruto",
        character: "Naruto Uzumaki",
        quote: "To become Hokage is my dream!",
        pic:
            "https://i.pinimg.com/236x/1f/23/3c/1f233cab210553510a44d266b8a64daf.jpg"),
    Question(
        anime: "Fullmetal Alchemist: Brotherhood",
        character: "Greed",
        quote:
            "Oh, you're one of those guys... You don't care if somebody beats the crap out of you, but if someone lays a finger on a family member, you completely freak out. What a waste...",
        pic:
            "https://i.pinimg.com/236x/1c/5d/d7/1c5dd7696b398ca858b0a500e356f14e.jpg"),
    Question(
        anime: "Naruto",
        character: "Kankuro",
        quote:
            "A fair warning... we ninja of the Sand aren't as easygoing as those of the Leaf. But getting close to Kuroari so carelessly...isn't good!",
        pic:
            "https://i.pinimg.com/236x/39/0d/27/390d27682429c3a8ae916c2bcf772fb6.jpg"),
    Question(
        anime: "Fullmetal Alchemist",
        character: "Van Hohenheim",
        quote:
            "[To Father] You've certainly mellowed out... you used to be fun, full of life and emotion. Lust, Greed, Sloth, Gluttony, Envy, Wrath, and Pride. Of course, excessive want will destroy anyone, but those same desires are necessary to understand what it means to be human. Why did you rid yourself of them?",
        pic:
            "https://i.pinimg.com/236x/fc/5f/ab/fc5fab94d551ff149f36fc42a0ac3b73.jpg"),
    Question(
        anime: "Akame ga KILL!",
        character: "Susanoo",
        quote:
            "No matter how sturdy something appears, it should have some weakness.",
        pic:
            "https://i.pinimg.com/236x/43/97/92/439792b77b7b18d6ea7434ebcdf7622e.jpg"),
    Question(
        anime: "Mirai Nikki",
        character: "Gasai Yuno",
        quote:
            "Everything in this world is just a game and we are merely the pawns.",
        pic:
            "https://i.pinimg.com/236x/ea/cc/0e/eacc0e81a867b627f122ba3d1914f7e2.jpg"),
    Question(
        anime: "Fullmetal Alchemist",
        character: "Riza Hawkeye",
        quote:
            "If the ways of this world are based on equivalent exchange, as alchemy says, then in order to allow for a new generation to enjoy good fortune, the price that we must pay, is to carry the bodies of the dead across a river of blood.",
        pic:
            "https://i.pinimg.com/236x/a4/ed/ba/a4edbab69aa17eb91c1535eb8259efcf.jpg"),
    Question(
        anime: "Kuroko No Basket",
        character: "Tetsuya Kuroko",
        quote:
            "No matter how many more points you have at the end of the game, if you're not happy, that's not a victory.",
        pic:
            "https://i.pinimg.com/236x/57/ff/ee/57ffee9ddfa0f4f1d97c6ca22b44ab07.jpg"),
    Question(
        anime: "Shingeki no Kyojin",
        character: "Armin Arlelt",
        quote:
            "We're going to explore the outside world someday, right? Far beyond these walls, there's flaming water, land made of ice, and fields of sand spread wide. It's the world my parents wanted to go to.",
        pic:
            "https://i.pinimg.com/236x/7e/b0/54/7eb0549c345268f86fb187c51f371100.jpg"),
    Question(
        anime: "Sword Art Online",
        character: "Kazuto Kirigaya",
        quote:
            "Whether here or in the real world, you can cry when it hurts. There's no rule that you can't show feelings just because it's a game.",
        pic:
            "https://i.pinimg.com/236x/69/4a/e6/694ae6891924dbb3cd105d455f7bf2bd.jpg"),
    Question(
        anime: "Psycho-Pass",
        character: "Makishima Shougo",
        quote:
            "Beautiful flowers, too, eventually wither and fall. That's the fate of all living beings.",
        pic:
            "https://i.pinimg.com/236x/4e/f0/42/4ef042a38d5f65eb646a26eda1f02d20.jpg"),
    Question(
        anime: "Dragon Ball Z",
        character: "Beerus",
        quote:
            "Now all that is left is the destruction of earth, but I think it would be a waste to destroy it. The food of this planet is very delicious.",
        pic:
            "https://i.pinimg.com/236x/96/dc/90/96dc90f46568ab223628cc0dc002dd09.jpg"),
    Question(
        anime: "Deadman Wonderland",
        character: "Ganta Igarashi",
        quote:
            "It doesn't matter whether this world is crazy or not. It doesn't matter if this absurdity is real. It doesn't matter how messed up this place may be... I want to survive.",
        pic:
            "https://i.pinimg.com/236x/49/a3/0f/49a30fe51a0acaec99a04cf834b1d1e8.jpg"),
    Question(
        anime: "Bleach",
        character: "Soi Fon",
        quote:
            "I'll show you a real assassination. No... Maybe you won't even be able to see it.",
        pic:
            "https://i.pinimg.com/236x/98/87/8f/98878fbb20f525771670586798db52ee.jpg"),
    Question(
        anime: "Naruto",
        character: "Jiraiya",
        quote:
            "Getting dumped always makes a man stronger. But then again, men aren't meant to pursue happiness.",
        pic:
            "https://i.pinimg.com/236x/97/c8/49/97c84938fa55449c6d7cc2799cec7f70.jpg"),
    Question(
        anime: "Yu-Gi-Oh!",
        character: "Seto Kaiba",
        quote:
            "Let me get this straight. You're going to defeat me with a creampuff and an elf?",
        pic:
            "https://i.pinimg.com/236x/af/28/fe/af28fe5f6ee1f8092e91907b64514951.jpg"),
    Question(
        anime: "One Piece",
        character: "Sanji",
        quote:
            "I couldn't confess my feelings for you, so I watched you from afar, being happy with someone else.",
        pic:
            "https://i.pinimg.com/236x/05/7f/47/057f473e3a2351a04a550618aa9092b8.jpg"),
    Question(
        anime: "One Punch Man",
        character: "Saitama",
        quote:
            "In exchange for gaining strength, have I lost something more important as a human being? Emotions used to swirl within me when I fought. Fear, impatience, anger... But now... Day after day, after one punch I go home unharmed and wash my gloves.",
        pic:
            "https://i.pinimg.com/236x/6f/fc/cb/6ffccb553633847594598a51712a89b8.jpg"),
    Question(
        anime: "Naruto",
        character: "Might Guy",
        quote:
            "You're right, all efforts are pointless... If you don't believe in yourself.",
        pic:
            "https://i.pinimg.com/236x/9b/82/16/9b821668e2ecaec876104bb364e1f707.jpg"),
  ];int ad=0;
List<String> imgs=["images/download-_5_.jpg","images/download-_6_.jpg","images/images-_2__1.jpg","images/images-_3__1.jpg"];
  double space = -1000;
bool clicked=false,play=false;
List<int>nums;
   AnimationController _controller;
  Animation<double> _animation;
  var colors=[Color.fromARGB(255, 244, 238, 232),Color.fromARGB(255, 244, 238, 232),Color.fromARGB(255, 244, 238, 232)];
  @override
  var result;
  checknet()async{
    result = await (Connectivity().checkConnectivity());
    print(result);
  }

  void initState() {
 checknet();
      _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
     _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    Timer(Duration(microseconds: 300), () {
      setState(() {
        space = 0;
        if(widget.ad!=null)
        ad=widget.ad;
      });
    });
questions.shuffle();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose;
  }

  @override
  Widget build(BuildContext context) {
    print(questions.length.toString());


    if(clicked==true){Timer(Duration(milliseconds: 300), () {
    nums = [
        Random().nextInt(questions.length),
        Random().nextInt(questions.length),
        i
      ];
    nums.shuffle();

    });}
   else{



    nums = [
        Random().nextInt(questions.length),
        Random().nextInt(questions.length),
        i
      ];



    nums.shuffle();
    imgs.shuffle();
    colors[0]=Color.fromARGB(255, 244, 238, 232);
    colors[1]=Color.fromARGB(255, 244, 238, 232);
    colors[2]=Color.fromARGB(255, 244, 238, 232);}
    return Scaffold(
        body:
result==ConnectivityResult.none?Center(child: Text("This app requires internet",style: TextStyle(fontSize: 20),),):
        SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 143, 214, 225),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Card(
                  elevation: 5,
                  child: Container(
                    color:Colors.grey ,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      questions[i].quote,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  )),

              AnimatedPositioned(
                top: 100,
                curve: Curves.linear,
                left: space,
                duration: Duration(seconds: 1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 5,
                          child: Container(
                             color: colors[0],
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: questions[nums[0]].character ==
                                      questions[i].character
                                  ? Colors.green
                                  : Colors.red,
                              onTap: () {
                                setState(() {
                                  clicked=true;
                                });
                                questions[nums[0]].character ==
                                        questions[i].character
                                    ? setState(() {
                                      play=true;
                                      _controller.repeat(max: 1,min: .7);
                                      clicked=false;
                                      colors[0]=Colors.lightGreenAccent;
                                      i++;
                                        space = -1000;
                                        Timer(Duration(milliseconds: 1000), () {
                                          setState(() {
                                            space = 0;
play=false;

                                          });
                                        });
                                      })
                                    :


                                setState(() {colors[0]=Colors.redAccent; questions[nums[1]].character ==
                                    questions[i].character
                                    ?colors[1]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
                                questions[nums[2]].character ==
                                    questions[i].character
                                    ?colors[2]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
ad++;
                                Timer(Duration(milliseconds: 300), () {
                                  print(i.toString());
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => EndScreen(i,ad)));});
                                });



                              },
                              child: Column(children: [
                                Container(
                                  height: 180,
                                  child: CachedNetworkImage(
                                    imageUrl: questions[nums[0]].pic,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Text(
                                  questions[nums[0]].character,style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                ),
                                Text(questions[nums[0]].anime, maxLines: 1,style:TextStyle(fontSize: 16,color: Colors.black54))
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(

                          elevation: 5,
                          child: Container(
                            color: colors[1],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: questions[nums[1]].character ==
                                        questions[i].character
                                    ? Colors.green
                                    : Colors.red,
                                onTap: () {
                                  setState(() {
                                    clicked=true;
                                  });
                                  questions[nums[1]].character ==
                                          questions[i].character
                                      ? setState(() {
                                        play=true;
                                        _controller.repeat(min: .7,max: 1);

                                          i++;

                                          colors[1]=Colors.greenAccent;
                                          clicked=false;
                                          space = -1000;
                                          Timer(Duration(milliseconds: 1000), () {
                                            setState(() {
                                              play=false;


                                              space = 0;
                                            });
                                          });
                                        })
                                      :   setState(() {colors[1]=Colors.redAccent; questions[nums[0]].character ==
                                      questions[i].character
                                      ?colors[0]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
                                  questions[nums[2]].character ==
                                      questions[i].character
                                      ?colors[2]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
ad++;
                                  Timer(Duration(milliseconds: 300), () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => EndScreen(i,ad)));});
                                  });
                                },
                                child: Column(children: [
                                  Container(
                                    height: 180,
                                    child: CachedNetworkImage(
                                      imageUrl: questions[nums[1]].pic,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Text(questions[nums[1]].character,
                                      maxLines: 1,),
                                  Text(questions[nums[1]].anime, maxLines: 1,)
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            color: colors[2],
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: questions[nums[2]].character ==
                                      questions[i].character
                                  ? Colors.green
                                  : Colors.red,
                              onTap: () {
                                setState(() {
                                  clicked=true;
                                });
                                questions[nums[2]].character ==
                                        questions[i].character
                                    ? setState(() {
                                        i++;
                                        play=true;
                                        _controller.repeat(min: .7,max: 1,);
                                        colors[2]=Colors.lightGreenAccent;
                                        clicked=false;
                                        space = -1000;
                                        Timer(Duration(milliseconds: 1000), () {
                                          setState(() {
                                            space = 0;
                                            play=false;

                                          });
                                        });
                                      })
                                    :   setState(() {colors[2]=Colors.redAccent; questions[nums[0]].character ==
                                    questions[i].character
                                    ?colors[0]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
                                questions[nums[1]].character ==
                                    questions[i].character
                                    ?colors[1]=Colors.lightGreenAccent:Colors.deepOrangeAccent;
ad++;
                                Timer(Duration(milliseconds: 300), () {
                                  print(i.toString());
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => EndScreen(i,ad)));});
                                });
                              },
                              child: Column(children: [
                                Container(
                                  height: 180,
                                  child: CachedNetworkImage(
                                    imageUrl: questions[nums[2]].pic,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Text(questions[nums[2]].character,
                                    maxLines: 1,),
                                Text(questions[nums[2]].anime, maxLines: 1,)
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),



           play==true?   Positioned(
                right: 250,
                top:130,


                child: RotationTransition(
                  alignment: Alignment.centerLeft,
                  turns: _animation,
                  child:ClipRRect(borderRadius:BorderRadius.circular(100) ,child: Image.asset(imgs[0],fit: BoxFit.fill,width: 80,height: 80,)),

                ),
              ):Container(),
            ],
          ),
        ],
      ),
    ));
  }
}
