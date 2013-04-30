<!--
// JavaScript Document
//返回汉字的拼音的第一个字母
function GetPY(str)
{
    var ret = '';
    for(var i=0,len=str.length;i<len;i++)
    {
        var ch = str.charAt(i);
        ret += CheckCh(ch);
    }
    
    return ret;
}

function CheckCh(ch)
{
    var uni = ch.charCodeAt(0);
    var strChineseFirstPY = 'ydyqsxmwzssxjbymgcczqpssqbycdscdqldylybssjgyzzjjfkcclzdhwdwzjljpfyynwjjtmyhzwzhflzppqhgscyyynjqyxxgjhhsdsjnkktmomlcrxypsnqseccqzggllyjlmyzzsecykyyhqwjssggyxyzyjwwkdjhychmyxjtlxjyqbyxzldwrdjrwysrldzjpcbzjjbrcftleczstzfxxzhtrqhybdlyczssymmrfmyqzpwwjjyfcrwfdfzqpyddwyxkyjawjffxypsftzyhhyzyswcjyxsclcxxwzzxnbgnnxbxlzszsbsgpysyzdhmdzbqbzcwdzzyytzhbtsyybzgntnxqywqskbphhlxgybfmjebjhhgqtjcysxstkzhlyckglysmzxyalmeldccxgzyrjxsdltyzcqkcnnjwhjtzzcqljststbnxbtyxceqxgkwjyflzqlyhyxspsfxlmpbysxxxydjczylllsjxfhjxpjbtffyabyxbhzzbjyzlwlczggbtssmdtjzxpthyqtgljscqfzkjzjqnlzwlslhdzbwjncjzyzsqqycqyrzcjjwybrtwpyftwexcskdzctbzhyzzyyjxzcffzzmjyxxsdzzottbzlqwfckszsxfyrlnyjmbdthjxsqqccsbxyytsyfbxdztgbcnslcyzzpsazyzzscjcshzqydxlbpjllmqxtydzxsqjtzpxlcglqtzwjbhctsyjsfxyejjtlbgxsxjmyjqqpfzasyjntydjxkjcdjszcbartdclyjqmwnqnclllkbybzzsyhqqltwlccxtxllzntylnewyzyxczxxgrkrmtcndnjtsyyssdqdghsdbjghrwrqlybglxhlgtgxbqjdzpyjsjyjctmrnymgrzjczgjmzmgxmpryxkjnymsgmzjymkmfxmldtgfbhcjhkylpfmdxlqjjsmtqgzsjlqdldgjycalcmzcsdjllnxdjffffjczfmzffpfkhkgdpsxktacjdhhzddcrrcfqyjkqccwjdxhwjlyllzgcfcqdsmlzpbjjplsbcjggdckkdezsqcckjgcgkdjtjdlzycxklqscgjcltfpcqczgwpjdqyzjjbyjhsjdzwgfsjgzkqcczllpspkjgqjhzzljplgjgjjthjjyjzczmlzlyqbgjwmljkxzdznjqsyzmljlljkywxmkjlhskjgbmclyymkxjqlbmllkmdxxkwyxyslmlpsjqqjqxyxfjtjdxmxxllcxqbsyjbgwymbggbcyxpjygpepfgdjgbhbnsqjyzjkjkhxqfgqzkfhygkhdkllsdjqxpqykybnqsxqnszswhbsxwhxwbzzxdmnsjbsbkbbzklylxgwxdrwyqzmywsjqlcjxxjxkjeqxscyetlzhlyyysdzpaqyzcmtlshtzcfyzyxyljsdcjqagyslcqlyyyshmrqqkldxzscsssydycjysfsjbfrsszqsbxxpxjysdrckgjlgdkzjzbdktcsyqpyhstcldjdhmxmcgxyzhjddtmhltxzxylymohyjcltyfbqqxpfbdfhhtksqhzyywcnxxcrwhowgyjlegwdqcwgfjycsntmytolbygwqwesjpwnmlrydzsztxyqpzgcwxhngpyxshmyqjxztdppbfyhzhtjyfdzwkgkzbldntsxhqeegzzylzmmzyjzgxzxkhkstxnxxwylyapsthxdwhzympxagkydxbhnhxkdpjnmyhylpmgocslnzhkxxlpzzlbmlsfbhhgygyyggbhscyaqtywlxtzqcezydqdqmmhtkllszhlsjzwfyhqswscwlqazynytlsxthaznkzzszzlaxxzwwctgqqtddyztcchyqzflxpslzygpzsznglndqtbdlxgtctajdkywnsyzljhhzzcwnyyzywmhychhyxhjkzwsxhzyxlyskqyspslyzwmyppkbyglkzhtyxaxqsyshxasmchkdscrswjpwxsgzjlwwschsjhsqnhcsegndaqtbaalzzmsstdqjcjktscjaxplggxhhgxxzcxpdmmhldgtybysjmxhmrcpxxjzckzxshmlqxxtthxwzfkhcczdytcjyxqhlxdhypjqxylsyydzozjnyxqezysqyayxwypdgxddxsppyzndltwrhxydxzzjhtcxmczlhpyyyymhzllhnxmylllmdcppxhmxdkycyrdltxjchhzzxzlcclylnzshzjzzlnnrlwhyqsnjhxyntttkyjpychhyegkcttwlgqrlggtgtygyhpyhylqyqgcwyqkpyyyttttlhyhlltyttsplkyzxgzwgpydsszzdqxskcqnmjjzzbxyqmjrtffbtkhzkbxljjkdxjtlbwfzpptkqtztgpdgntpjyfalqmkgxbdclzfhzclllladpmxdjhlcclgyhdzfgyddgcyyfgydxkssebdhykdkdkhnaxxybpbyyhxzqgaffqyjxdmljcsqzllpchbsxgjyndybyqspzwjlzksddtactbxzdyzypjzqsjnkktknjdjgyypgtlfyqkasdntcyhblwdzhbbydwjrygkzyheyyfjmsdtyfzjjhgcxplxhldwxxjkytcyksssmtwcttqzlpbszdzwzxgzagyktywxlhlspbclloqmmzsslcmbjcszzkydczjgqqdsmcytzqqlwzqzxssfpttfqmddzdshdtdwfhtdyzjyqjqkypbdjyyxtljhdrqxxxhaydhrjlklytwhllrllrcxylbwsrszzsymkzzhhkyhxksmdsydycjpbzbsqlfcxxxnxkxwywsdzyqoggqmmyhcdzttfjyybgstttybykjdhkyxbelhtypjqnfxfdykzhqkzbyjtzbxhfdxkdaswtawajldyjsfhbldnntnqjtjnchxfjsrfwhzfmdryjyjwzpdjkzyjympcyznynxfbytfyfwygdbnzzzdnytxzemmqbsqehxfzmbmflzzsrxymjgsxwzjsprydjsjgxhjjgljjynzzjxhgxkymlpyyycxytwqzswhwlyrjlpxslsxmfswwklctnxnynpsjszhdzeptxmyywxyysywlxjqzqxzdcleeelmcpjpclwbxsqhfwwtffjtnqjhjqdxhwlbyznfjlalkyyjldxhhycstyywnrjyxywtrmdrqhwqcmfjdyzmhmyyxjwmyzqzxtlmrspwwchaqbxygzypxyyrrclmpymgksjszysrmyjsnxtplnbappypylxyyzkynldzyjzcznnlmzhharqmpgwqtzmxxmllhgdzxyhxkyxycjmffyyhjfsbssqlxxndycannmtcjcyprrnytyqnyymbmsxndlylysljrlxysxqmllyzlzjjjkyzzcsfbzxxmstbjgnxyzhlxnmcwscyzyfzlxbrnnnylbnrtgzqysatswryhyjzmzdhzgzdwybsscskxsyhytxxgcqgxzzshyxjscrhmkkbxczjyjymkqhzjfnbhmqhysnjnzybknqmclgqhwlznzswxkhljhyybqlbfcdsxdldspfzpskjyzwzxzddxjsmmegjscssmgclxxkyyylnypwwwgydkzjgggzggsycknjwnjpcxbjjtqtjwdsspjxzxnzxumelpxfsxtllxcljxjjljzxctpswxlydhlyqrwhsycsqyybyaywjjjqfwqcqqcjqgxaldbzzyjgkgxpltzyfxjltpadkyqhpmatlcpdckbmtxybhklenxdleegqdymsawhzmljtwygxlyqzljeeyybqqffnlyxrdsctgjgxyynkllyqkcctlhjlqmkkzgcyygllljdzgydhzwxpysjbzkdzgyzzhywyfqytyzszyezzlymhjjhtsmqwyzlkyywzcsrkqytltdxwctyjklwsqzwbdcqyncjsrszjlkcdcdtlzzzacqqzzddxyplxzbqjylzlllqddzqjyjyjzyxnyyynyjxkxdazwyrdljyyyrjlxlldyxjcywywnqcclddnyyynyckczhxxcclgzqjgkwppcqqjysbzzxyjsqpxjpzbsbdsfnsfpzxhdwztdwpptflzzbzdmyypqjrsdzsqzsqxbdgcpzswdwcsqzgmdhzxmwwfybpdgphtmjthzsmmbgzmbzjcfzwfzbbzmqcfmbdmcjxlgpnjbbxgyhyyjgptzgzmqbqtcgyxjxlwzkydpdymgcftpfxyztzxdzxtgkmtybbclbjaskytssqyymszxfjewlxllszbqjjjaklylxlycctsxmcwfkkkbsxlllljyxtyltjyytdpjhnhnnkbyqnfqyyzbyyessessgdyhfhwtcjbsdzztfdmxhcnjzymqwsryjdzjqpdqbbstjggfbkjbxtgqhngwjxjgdllthzhhyyyyyysxwtyyyccbdbpypzycczyjpzywcbdlfwzcwjdxxhyhlhwzzxjtczlcdpxujczzzlyxjjtxphfxwpywxzptdzzbdzcyhjhmlxbqxsbylrdtgjrrcttthytczwmxfytwwzcwjwxjywcskybzscctzqnhxnwxxkhkfhtswoccjybcmpzzykbnnzpbzhhzdlsyddytyfjpxyngfxbyqxcbhxcpsxtyzdmkysnxsxlhkmzxlyhdhkwhxxsskqyhhcjyxglhzxcsnhekdtgzxqypkdhextykcnymyyypkqyyykxzlthjqtbyqhxbmyhsqckwwyllhcyylnneqxqwmcfbdccmljggxdqktlxkgnqcdgzjwyjjlyhhqtttnwchmxcxwhwszjydjccdbqcdgdnyxzthcqrxcbhztqcbxwgqwyybxhmbymyqtyexmqkyaqyrgyzslfykkqhyssqyshjgjcnxkzycxsbxyxhyylstycxqthysmgscpmmgcccccmtztasmgqzjhklosqylswtmxsyqkdzljqqyplsycztcqqpbbqjzclpkhqzyyxxdtddtsjcxffllchqxmjlwcjcxtspycxndtjshjwxdqqjskxyamylsjhmlalykxcyydmnmdqmxmcznncybzkkyflmchcmlhxrcjjhsylnmtjzgzgywjxsrxcwjgjqhqzdqjdcjjzkjkgdzqgjjyjylxzxxcdqhhheytmhlfsbdjsyyshfystczqlpbdrfrztzykywhszyqkwdqzrkmsynbcrxqbjyfazpzzedzcjywbcjwhyjbqszywryszptdkzpfpbnztklqyhbbzpnpptyzzybqnydcpjmmcycqmcyfzzdcmnlfpbplngqjtbttnjzpzbbznjkljqylnbzqhksjznggqszzkyxshpzsnbcgzkddzqanzhjkdrtlzlswjljzlywtjndjzjhxyayncbgtzcssqmnjpjytyswxzfkwjqtkhtzplbhsnjzsyzbwzzzzlsylsbjhdwwqpslmmfbjdwaqyztcjtbnnwzxqxcdslqgdsdpdzhjtqqpswlyyjzlgyxyzlctcbjtktyczjtqkbsjlgmgzdmcsgpynjzyqyyknxrpwszxmtncszzyxybyhyzaxywqcjtllckjjtjhgdxdxyqyzzbywdlwqcglzgjgqrqzczssbcrpcskydznxjsqgxssjmydnstztpbdltkzwxqwqtzexnqczgwezkssbybrtssslccgbpszqszlccglllzxhzqthczmqgyzqznmcocszjmmzsqpjygqljyjppldxrgzyxccsxhshgtznlzwzkjcxtcfcjxlbmqbczzwpqdnhxljcthyzlgylnlszzpcxdscqqhjqksxzpbajyemsmjtzdxlcjyryynwjbngzztmjxltbslyrzpylsscnxphllhyllqqzqlxymrsycxzlmmczltzsdwtjjllnzggqxpfskygyghbfzpdkmwghcxmsgdxjmcjzdycabxjdlnbcdqygskydqtxdjjyxmszqazdzfslqxyjsjzylbtxxwxqqzbjzufbblylwdsljhxjyzjwtdjczfqzqzzdzsxzzqlzcdzfjhyspympqzmlpplffxjjnzzylsjeyqzfpfzksywjjjhrdjzzxtxxglghydxcskyswmmzcwybazbjkshfhjcxmhfqhyxxyzftsjyzfxyxpzlchmzmbxhzzsxyfymncwdabazlxktcshhxkxjjzjsthygxsxyyhhhjwxkzxssbzzwhhhcwtzzzpjxsnxqqjgzyzywllcwxzfxxyxyhxmkyyswsqmnlnaycyspmjkhwcqhylajjmzxhmmcnzhbhxclxtjpltxyjhdyylttxfszhyxxsjbjyayrsmxyplckduyhlxrlnllstyzyyqygyhhsccsmzctzqxkyqfpyyrpfflkquntszllzmwwtcqqyzwtllmlmpwmbzsstzrbpddtlqjjbxzcsrzqqygwcsxfwzlxccrszdzmcyggdzqsgtjswljmymmzyhfbjdgyxccpshxnzcsbsjyjgjmppwaffyfnxhyzxzylremzgzcyzsszdlljcsqfnxzkptxzgxjjgfmyyysnbtylbnlhpfzdcyfbmgqrrssszxysgtzrnydzzcdgpjafjfzknzblczszpsgcycjszlmlrszbzzldlsllysxsqzqlyxzlskkbrxbrbzcycxzzzeeyfgklzlyyhgzsgzlfjhgtgwkraajyzkzqtsshjjxdcyzuyjlzyrzdqqhgjzxsszbykjpbfrtjxllfqwjhylqtymblpzdxtzygbdhzzrbgxhwnjtjxlkscfsmwlsdqysjtxkzscfwjlbxftzlljzllqblsqmqqcgczfpbphzczjlpyyggdtgwdcfczqyyyqyssclxzsklzzzgffcqnwglhqyzjjczlqzzyjpjzzbpdccmhjgxdqdgdlzqmfgpsytsdyfwwdjzjysxyyczcyhzwpbykxrylybhkjksfxtzjmmckhlltnyymsyxyzpyjqycsycwmtjjkqyrhllqxpsgtlyycljscpxjyzfnmlrgjjtyzbxyzmsjyjhhfzqmsyxrszcwtlrtqzsstkxgqkgsptgcznjsjcqcxhmxggztqydjkzdlbzsxjlhyqgggthqszpyhjhhgyygkggcwjzzylczlxqsftgzslllmljskctbllzzszmmnytpzsxqhjcjyqxyzxzqzcpshkzzysxcdfgmwqrllqxrfztlystctmjcxjjxhjnxtnrztzfqyhqgllgcxszsjdjljcydsjtlnyxhszxcgjzyqpylfhdjsbpcczhjjjqzjqdybssllcmyttmqtbhjqnnygkyrqyqmzgcjkpdcgmyzhqllsllclmholzgdyyfzsljcqzlylzqjeshnylljxgjxlysyyyxnbzljsszcqqcjyllzltjyllzllbnylgqchxyyxoxcxqkyjxxxyklxsxxyqxcykqxqcsgyxxyqxygytqohxhxpyxxxulcyeychzzcbwqbbwjqzscszsslzylkdesjzwmymcytsdsxxscjpqqsqylyyzycmdjdzywcbtjsydjkcyddjlbdjjsodzysyxqqyxdhhgqqyqhdyxwgmmmajdybbbppbcmuupljzsmtxerxjmhqnutpjdcbssmssstkjtssmmtrcplzszmlqdsdmjmqpnqdxcfynbfsdqxyxhyaykqyddlqyyysszbydslntfqtzqpzmchdhczcwfdxtmyqsphqyyxsrgjcwtjtzzqmgwjjtjhtqjbbhwzpxxhyqfxxqywyyhyscdydhhqmnmtmwcpbszppzzglmzfollcfwhmmsjzttdhzzyffytzzgzyskyjxqyjzqbhmbzzlyghgfmshpzfzsnclpbqsnjxzslxxfpmtyjygbxlldlxpzjyzjyhhzcywhjylsjexfszzywxkzjluydtmlymqjpwxyhxsktqjezrpxxzhhmhwqpwqlyjjqjjzszcphjlchhnxjlqwzjhbmzyxbdhhypzlhlhlgfwlchyytlhjxcjmscpxstkpnhqxsrtyxxtesyjctlsslstdlllwwyhdhrjzsfgxtsyczynyhtdhwjslhtzdqdjzxxqhgyltzphcsqfclnjtclzpfstpdynylgmjllycqhysshchylhqyqtmzypbywrfqykqsyslzdqjmpxyyssrhzjnywtqdfzbwwtwwrxcwhgyhxmkmyyyqmsmzhngcepmlqqmtcwctmmpxjpjjhfxyyzsxzhtybmstsyjttqqqyylhynpyqzlcyzhzwsmylkfjxlwgxypjytysyxymzckttwlksmzsylmpwlzwxwqzssaqsyxyrhssntsrapxcpwcmgdxhxzdzyfjhgzttsbjhgyzszysmyclllxbtyxhbbzjkssdmalxhycfygmqypjycqxjllljgslzgqlycjcczotyxmtmttllwtgpxymzmklpszzzxhkqysxctyjzyhxshyxzkxlzwpsqpyhjwpjpwxqqylxsdhmrslzzyzwttcyxyszzshbsccstplwsscjchnlcgchssphylhfhhxjsxyllnylszdhzxylsxlwzykcldyaxzcmddyspjtqjzlnwqpssswctstszlblnxsmnyymjqbqhrzwtyydchqlxkpzwbgqybkfcmzwpzllyylszydwhxpsbcmljbscgbhxlqhyrljxyswxwxzsldfhlslynjlzyflyjycdrjlfsyzfsllcqyqfgjyhyxzlylmstdjcyhbzllnwlxxygyyhsmgdhxxhhlzzjzxczzzcyqzfngwpylcpkpyypmclqkdgxzggwqbdxzzkzfbxxlzxjtpjpttbytszzdwslchzhsltyxhqlhyxxxyyzyswtxzkhlxzxzpyhgchkcfsyhutjrlxfjxptztwhplyxfcrhxshxkyxxyhzqdxqwulhyhmjtbflkhtxcwhjfwjcfpqryqxcyyyqygrpywsgsungwchkzdxyflxxhjjbyzwtsxxncyjjymswzjqrmhxzwfqsylzjzgbhynslbgttcsybyxxwxyhxyyxnsqyxmqywrgyqlxbbzljsylpsytjzyhyzawlrorjmksczjxxxyxchdyxryxxjdtsqfxlyltsffyxlmtyjmjuyyyxltzcsxqzqhzxlyyxzhdnbrxxxjctyhlbrlmbrllaxkyllljlyxxlycrylcjtgjcmtlzllcyzzpzpcyawhjjfybdyyzsmpckzdqyqpbpcjpdcyzmdpbcyydycnnplmtmlrmfmmgwyzbsjgygsmzqqqztxmkqwgxllpjgzbqcdjjjfpkjkcxbljmswmdtqjxldlppbxcwrcqfbfqjczahzgmykphyyhzykndkzmbpjyxpxyhlfpnyygxjdbkxnxhjmzjxstrstldxskzysybzxjlxyslbzyslhxjpfxpqnbylljqkygzmcyzzymccslclhzfwfwyxzmwsxtynxjhpyymcyspmhysmydyshqyzchmjjmzcaagcfjbbhplyzylxxsdjgxdhkxxtxxnbhrmlyjsltxmrhnlxqjxyzllyswqgdlbjhdcgjyqycmhwfmjybmbyjyjwymdpwhxqldygpdfxxbcgjspckrssyzjmslbzzjfljjjlgxzgyxyxlszqyxbexyxhgcxbpldyhwettwwcjmbtxchxyqxllxflyxlljlssfwdpzsmyjclmwytczpchqekcqbwlcqydplqppqzqfjqdjhymmcxtxdrmjwrhxcjzylqxdyynhyyhrslsrsywwzjymtltllgtqcjzyabtckzcjyccqljzqxalmzyhywlwdxzxqdllqshgpjfjljhjabcqzdjgtkhsstcyjlpswzlxzxrwgldlzrlzxtgsllllzlyxxwgdzygbdphzpbrlwsxqbpfdwofmwhlypcbjccldmbzpbzzlcyqxldomzblzwpdwyygdstthcsqsccrsssyslfybfntyjszdfndpdhdzzmbblslcmyffgtjjqwftmtpjwfnlbzcmmjtgbdzlqlpyfhyymjylsdchdzjwjcctljcldtljjcpddsqdsszybndbjlggjzxsxnlycybjxqycbylzcfzppgkcxzdzfztjjfjsjxzbnzyjqttyjyhtyczhymdjxttmpxsplzcdwslshxypzgtfmlcjtycbpmgdkwycyzcdszzyhflyctygwhkjyylsjcxgywjcbllcsnddbtzbsclyzczzssqdllmqyyhfslqllxftyhabxgwnywyypllsdldllbjcyxjzmlhljdxyyqytdlllbugbfdfbbqjzzmdpjhgclgmjjpgaehhbwcqxaxhhhzchxyphjaxhlphjpgpzjqcqzgjjzzuzdmqyybzzphyhybwhazyjhykfgdpfqsdlzmljxkxgalxzdaglmdgxmwzqyxxdxxpfdmmssympfmdmmkxksyzyshdzkxsysmmzzzmsydnzzczxfplstmzdnmxckjmztyymzmzzmsxhhdczjemxxkljstlwlsqlyjzllzjssdppmhnlzjczyhmxxhgzcjmdhxtkgrmxfwmcgmwkdtksxqmmmfzzydkmsclcmpcgmhspxqpzdsslcxkyxtwlwjyahzjgzqmcsnxyymmpmlkjxmhlmlqmxctkzmjqyszjsyszhsyjzjcdajzybsdqjzgwzqqxfkdmsdjlfwehkzqkjpeypzyszcdwyjffmzzylttdzzefmzlbnpplplpepszalltylkckqzkgenqlwagyxydpxlhsxqqwqcqxqclhyxxmlyccwlymqyskgchlcjnszkpyzkcqzqljpdmdzhlasxlbydwqlwdnbqcryddztjybkbwszdxdtnpjdtctqdfxqqmgnxeclttbkpwslctyqlpwyzzklpygzcqqpllkccylpqmzczqcljslqzdjxlddhpzqdljjxzqdxyzqkzljcyqdyjppypqykjyrmpcbymcxkllzllfqpylllmbsglcysslrsysqtmxyxzqzfdzuysyztffmzzsmzqhzssccmlyxwtpzgxzjgzgsjsgkddhtqggzllbjdzlcbchyxyzhzfywxyzymsdbzzyjgtsmtfxqyxqstdgslnxdlryzzlryylxqhtxsrtzngzxbnqqzfmykmzjbzymkbpnlyzpblmcnqyzzzsjzhjctzkhyzzjrdyzhnpxglfztlkgjtctssyllgzrzbbqzzklpklczyssuyxbjfpnjzzxcdwxzyjxzzdjjkggrsrjkmsmzjlsjywqskyhqjsxpjzzzlsnshrnypztwchklpsrzlzxyjqxqkysjycztlqzybbybwzpqdwwyzcytjcjxckcwdkkzxsgkdzxwwyyjqyytcytdllxwkczkklcclzcqqdzlqlcsfqchqhsfsmqzzlnbjjzbsjhtszdysjqjpdlzcdcwjkjzzlpycgmzwdjjbsjqzsyzyhhxjpbjydssxdzncglqmbtsfsbpdzdlznfgfjgfsmpxjqlmblgqcyyxbqkdjjqyrfkztjdhczklbsdzcfjtplljgxhyxzcsszzxstjygkgckgyoqxjplzpbpgtgyjzghzqzzlbjlsqfzgkqqjzgyczbzqtldxrjxbsxxpzxhyzyclwdxjjhxmfdzpfzhqhqmqgkslyhtycgfrzgnqxclpdlbzcsczqlljblhbzcypzzppdymzzsgyhckcpzjgsljlnscdsldlxbmstlddfjmkdjdhzlzxlszqpqpgjllybdszgqlbzlslkyyhzttntjyqtzzpszqztlljtyyllqllqyzqlbdzlslyyzymdfszsnhlxznczqzpbwskrfbsyzmthblgjpmczzlstlxshtcsyzlzblfeqhlxflcjlyljqcbzlzjhhsstbrmhxzhjzclxfnbgxgtqjcztmsfzkjmssnxljkbhsjxntnlzdntlmsjxgzjyjczxyjyjwrwwqnztnfjszpzshzjfyrdjsfszjzbjfzqzzhzlxfysbzqlzsgyftzdcszxzjbqmszkjrhyjzckmjkhchgtxkxqglxpxfxtrtylxjxhdtsjxhjzjxzwzlcqsbtxwxgxtxxhxftsdkfjhzyjfjxrzsdllltqsqqzqwzxsyqtwgwbzcgzllyzbclmqqtzhzxzxljfrmyzflxysqxxjkxrmqdzdmmyybsqbhgzmwfwxgmxlzpyytgzyccdxyzxywgsyjyznbhpzjsqsyxsxrtfyzgrhztxszzthcbfclsyxzlzqmzlmplmxzjxsflbyzmyqhxjsxrxsqzzzsslyfrczjrcrxhhzxqydyhxsjjhzcxzbtynsysxjbqlpxzqpymlxzkyxlxcjlcysxxzzlxdllljjyhzxgyjwkjrwyhcpsgnrzlfzwfzznsxgxflzsxzzzbfcsyjdbrjkrdhhgxjljjtgxjxxstjtjxlyxqfcsgswmsbctlqzzwlzzkxjmltmjyhsddbxgzhdlbmyjfrzfsgclyjbpmlysmsxlszjqqhjzfxgfqfqbpxzgyyqxgztcqwyltlgwsgwhrlfsfgzjmgmgbgtjfsyzzgzyzaflsspmlpflcwbjzcljjmzlpjjlymqdmyyyfbgygyzmlyzdxqyxrqqqhsyyyqxyljtyxfsfsllgnqcyhycwfhcccfxpylypllzyxxxxxkqhhxshjzcfzsczjxcpzwhhhhhapylqalpqafyhxdylukmzqgggddesrnnzltzgchyppysqjjhclljtolnjpzljlhymheydydsqycddhgzundzclzyzllzntnyzgslhslpjjbdgwxpcdutjcklkclwkllcasstkzzdnqnttlyyzssysszzryljqkcqdhhcrxrzydgrgcwcgzqfffppjfzynakrgywyqpqxxfkjtszzxswzddfbbxtbgtzkznpzzpzxzpjszbmqhkcyxyldkljnypkyghgdzjxxeahpnzkztzcmxcxmmjxnkszqnmnlwbwwxjkyhcpstmcsqtzjyxtpctpdtnnpglllzsjlspblplqhdtnjnlyyrszffjfqwdphzdwmrzcclodaxnssnyzrestyjwjyjdbcfxnmwttbylwstszgybljpxglboclhpcbjltmxzljylzxcltpnclckxtpzjswcyxsfyszdkntlbyjcyjllstgqcbxryzxbxklylhzlqzlnzcxwjzljzjncjhxmnzzgjzzxtzjxycyycxxjyyxjjxsssjstssttppgqtcsxwzdcsyfptfbfhfbblzjclzzdbxgcxlqpxkfzflsyltuwbmqjhszbmddbcysccldxycddqlyjjwmqllcsgljjsyfpyyccyltjantjjpwycmmgqyysxdxqmzhszxpftwwzqswqrfkjlzjqqyfbrxjhhfwjjzyqazmyfrhcyybyqwlpexcczstyrlttdmqlykmbbgmyyjprkznpbsxyxbhyzdjdnghpmfsgmwfzmfqmmbcmzzcjjlcnuxyqlmlrygqzcyxzlwjgcjcggmcjnfyzzjhycprrcmtzqzxhfqgtjxccjeaqcrjyhplqlszdjrbcqhqdyrhylyxjsymhzydwldfryhbpydtsscnwbxglpzmlzztqsscpjmxxycsjytycghycjwyrxxlfemwjnmkllswtxhyyyncmmcwjdqdjzglljwjrkhpzggflccsczmcbltbhbqjxqdspdjzzgkglfqywbzyzjltstdhqhctcbchflqmpwdshyytqwcnzzjtlbymbpdyyyxsqkxwyyflxxncwcxypmaelykkjmzzzbrxyyqjfljpfhhhytzzxsgqqmhspgdzqwbwpjhzjdyscqwzktxxsqlzyymysdzgrxckkujlwpysyscsyzlrmlqsyljxbcxtlwdqzpcycykpppnsxfyzjjrcemhszmsxlxglrwgcstlrsxbzgbzgztcplujlslylymtxmtzpalzxpxjtjwtcyyzlblxbzlqmylxpghdslssdmxmbdzzsxwhamlczcpjmcnhjysnsygchskqmzzqdllkablwjxsfmocdxjrrlyqzkjmybyqlyhetfjzfrfksryxfjtwdsxxsysqjyslyxwjhsnlxyyxhbhawhhjzxwmyljcsslkydztxbzsyfdxgxzjkhsxxybssxdpynzwrptqzczenygcxqfjykjbzmljcmqqxuoxslyxxlylljdzbtymhpfsttqqwlhokyblzzalzxqlhzwrrqhlstmypyxjjxmqsjfnbxyxyjxxyqylthylqyfmlkljtmllhszwkzhljmlhljkljstlqxylmbhhlnlzxqjhxcfxxlhyhjjgbyzzkbxscqdjqdsujzyyhzhhmgsxcsymxfebcqwwrbpyyjqtyzcyqyqqzyhmwffhgzfrjfcdpxntqyzpdykhjlfrzxppxzdbbgzqstlgdgylcqmlchhmfywlzyxkjlypqhsywmqqgqzmlzjnsqxjqsyjycbehsxfszpxzwfllbcyyjdytdthwzsfjmqqyjlmqxxlldttkhhybfpwtyysqqwnqwlgwdebzwcmygculkjxtmxmyjsxhybrwfymwfrxyqmxysztzztfykmldhqdxwyynlcryjblpsxcxywlsprrjwxhqyphtydnxhhmmywytzcsqmtssccdalwztcpqpyjllqzyjswxmzzmmylmxclmxczmxmzsqtzppqqblpgxqzhfljjhytjsrxwzxsccdlxtyjdcqjxslqyclzxlzzxmxqrjmhrhzjbhmfljlmlclqnldxzlllpypsyjysxcqqdcmqjzzxhnpnxzmekmxhykyqlxsxtxjyyhwdcwdzhqyybgybcyscfgpsjnzdyzzjzxrzrqjjymcanyrjtldppyzbstjkxxzypfdwfgzzrpymtngxzqbyxnbufnqkrjqzmjegrzgyclkxzdskknsxkcljspjyyzlqqjybzssqlllkjxtbktylccddblsppfylgydtzjyqggkqttfzxbdktyyhybbfytyybclpdytgdhryrnjsptcsnyjqhklllzslydxxwbcjqspxbpjzjcjdzffxxbrmlazhcsndlbjdszblprztswsbxbcllxxlzdjzsjpylyxxyftfffbhjjxgbyxjpmmmpssjzjmtlyzjxswxtyledqpjmygqzjgdjlqjwjqllsjgjgygmscljjxdtygjqjqjcjzcjgdzzsxqgsjggcxhqxsnqlzzbxhsgzxcxyljxyxyydfqqjhjfxdhctxjyrxysqtjxyefyyssyyjxncyzxfxmsyszxyyschshxzzzgzzzgfjdltylnpzgyjyzyyqzpbxqbdztzczyxxyhhsqxshdhgqhjhgywsztmzmlhyxgebtylzkqwytjzrclekystdbcykqqsayxcjxwwgsbhjyzydhcsjkqcxswxfltynyzpzcczjqtzwjqdzzzqzljjxlsbhpyxxpsxshheztxfptlqyzzxhytxncfzyyhxgnxmywxtzsjpthhgymxmxqzxtsbczyjyxxtyyzypcqlmmszmjzzllzxgxzaajzyxjmzxwdxzsxzdzxleyjjzqbhzwzzzqtzpsxztdsxjjjznyazphxyysrnqdthzhyykyjhdzxzlswclybzyecwcycrylcxnhzydzydyjdfrjjhtrsqtxyxjrjhojynxelxsfsfjzghpzsxzszdzcqzbyyklsgsjhczshdgqgxyzgxchxzjwyqwgyhksseqzzndzfkwysstclzstsymcdhjxxyweyxczaydmpxmdsxybsqmjmzjmtzqlpjyqzcgqhxjhhlxxhlhdldjqcldwbsxfzzyyschtytyybhecxhykgjpxhhyzjfxhwhbdzfyzbcapnpgnydmsxhmmmmamynbyjtmpxyymcthjbzyfcgtyhwphftwzzezsbzegpfmtskftycmhfllhgpzjxzjgzjyxzsbbqsczzlzccstpgxmjsftcczjzdjxcybzlfcjsyzfgszlybcwzzbyzdzypswyjzxzbdsyuxlzzbzfygczxbzhzftpbgzgejbstgkdmfhyzzjhzllzzgjqzlsfdjsscbzgpdlfzfzszyzyzsygcxsnxxchczxtzzljfzgqsqyxzjqdccztqcdxzjyqjqchxztdlgscxzsyqjqtzwlqdqztqchqqjzyezzzpbwkdjfcjpztypqyqttynlmbdktjzpqzqzzfpzsbnjlgyjdxjdzzkzgqkxdlpzjtcjdqbxdjqjstcknxbxzmslyjcqmtjqwwcjqnjnlllhjcwqtbzqydzczpzzdzyddcyzzzccjttjfzdprrtztjdcqtqzdtjnplzbcllctzsxkjzqzpzlbzrbtjdcxfczdbccjjltqqpldcgzdbbzjcqdcjwynllzyzccdwllxwzlxrxntqqczxkqlsgdfqtddglrlajjtkuymkqlltzytdyyczgjwyxdxfrskstqtenqmrkqzhhqkdldazfkypbggpzrebzzykzzspegjxgykqzzzslysyyyzwfqzylzzlzhwchkypqgnpgblplrrjyxccsyyhsfzfybzyytgzxylxczwxxzjzblfflgskhyjzeyjhlpllllczgxdrzelrhgklzzyhzlyqszzjzqljzflnbhgwlczcfjyspyxzlzlxgccpzbllcybbbbubbcbpcrnnzczyrbfsrldcgqyyqxygmqzwtzytyjxyfwtehzzjywlccntzyjjzdedpzdztsyqjhdymbjnyjzlxtsstphndjxxbyxqtzqddtjtdyytgwscszqflshlglbczphdlyzjyckwtytylbnytsdsycctyszyyebhexhqdtwnygyclxtszystqmygzazccszzdslzclzrqxyyeljsbymxsxztembbllyyllytdqyshymrqwkfkbfxnxsbychxbwjyhtqbpbsbwdzylkgzskyhxqzjxhxjxgnljkzlyycdxlfyfghljgjybxqlybxqpqgztzplncypxdjyqydymrbesjyyhkxxstmxrczzywxyqybmcllyzhqyzwqxdbxbzwzmslpdmyskfmzklzcyqyczlqxfzzydqzpzygyjyzmzxdzfyfyttqtzhgspczmlccytzxjcytjmkslpzhysnzllytpzctzzcktxdhxxtqcyfksmqccyyazhtjpcylzlyjbjxtpnyljyynrxsylmmnxjsmybcsysylzylxjjqyldzlpqbfzzblfndxqkczfywhgqmrdsxycytxnqqjzyypfzxdyzfprxejdgyqbxrcnfyyqpghyjdyzxgrhtkylnwdzntsmpklbthbpyszbztjzszzjtyyxzphsszzbzczptqfzmyflypybbjqxzmxxdjmtsyskkbjzxhjcklpsmkyjzcxtmljyxrzzqslxxqpyzxmkyxxxjcljprmyygadyskqlsndhyzkqxzyztcghztlmlwzybwsyctbhjhjfcwztxwytkzlxqshlyjzjxtmplpycgltbzztlzjcyjgdtclklpllqpjmzpapxyzlkktkdzczzbnzdydyqzjyjgmctxltgxszlmlhbglkfwnwzhdxuhlfmkyslgxdtwwfrjejztzhydxykshwfzcqshktmqqhtzhymjdjskhxzjzbzzxympagqmstpxlsklzynwrtsqlszbpspsgzwyhtlkssswhzzlyytnxjgmjszsufwnlsoztxgxlsammlbwldszylakqcqctmycfjbslxclzzclxxksbzqclhjpsqplsxxckslnhpsfqqytxyjzlqldxzqjzdyydjnzptuzdskjfsljhylzsqzlbtxydgtqfdbyazxdzhzjnhhqbyknxjjqczmlljzkspldyclbblxklelxjlbqycxjxgcnlcqplzlzyjtzljgyzdzpltqcsxfdmnycxgbtjdcznbgbqyqjwgkfhtnpyqzqgbkpbbyzmtjdytblsqmpsxtbnpdxklemyycjynzctldykzzxddxhqshdgmzsjycctayrzlpyltlkxslzcggexclfxlkjrtlqjaqzncmbydkkcxglczjzxjhptdjjmzqykqsecqzdshhadmlzfmmzbgntjnnlgbyjbrbtmlbyjdzxlcjlpldlpcqdhlxzlycblcxzzjadjlnzmmsssmybhbsqkbhrsxxjmxsdznzpxlgbrhwggfcxgmsklltsjyycqltskywyyhywxbxqywpywykqlsqptntkhqcwdqktwpxxhcpthtwumssyhbwcrwxhjmkmzngwtmlkfghkjylsyycxwhyeclqhkqhttqkhfzldxqwyzyydesbpkyrzpjfyyzjceqdzzdlatzbbfjllcxdlmjssxegygsjqxcwbxsszpdyzcxdnyxppzydlyjczpltxlsxyzyrxcyyydylwwnzsahjsyqyhgywwaxtjzdaxysrltdpssyyfnejdxyzhlxlllzqzsjnyqyqqxyjghzgzcyjchzlycdshwshjzyjxcllnxzjjyyxnfxmwfpylcyllabwddhwdxjmcxztzpmlqzhsfhzynztlldywlslxhymmylmbwwkyxyadtxylldjpybpwuxjmwmllsafdllyflbhhhbqqltzjcqjldjtffkmmmbythygdcqrddwrqjxnbysnwzdbyytbjhpybyttjxaahgqdqtmystqxkbtzpkjlzrbeqqssmjjbdjotgtbxpgbktlhqxjjjcthxqdwjlwrfwqgwshckryswgftgygbxsdwdwrfhwytjjxxxjyzyslpyyypayxhydqkxshxyxgskqhywfdddpplcjlqqeewxksyykdypltjthkjltcyyhhjttpltzzcdlthqkzxqysteeywyyzyxxyysttjkllpzmcyhqgxyhsrmbxpllnqydqhxsxxwgdqbshyllpjjjthyjkyppthyyktyezyenmdshlcrpqfdgfxzpsftljxxjbswyysksflxlpplbbblbsfxfyzbsjssylpbbffffsscjdstzsxzryysyffsyzyzbjtbctsbsdhrtjjbytcxyjeylxcbnebjdsyxykgsjzbxbytfzwgenyhhthzhhxfwgcstbgxklsxywmtmbyxjstzscdyqrcytwxzfhmymcxlznsdjtttxrycfyjsbsdyerxjljxbbdeynjghxgckgscymblxjmsznskgxfbnbpthfjaafxyxfpxmypqdtzcxzzpxrsywzdlybbktyqpqjpzypzjznjpzjlzzfysbttslmptzrtdxqsjehbzylzdhljsqmlhtxtjecxslzzspktlzkqqyfsygywpcpqfhqhytqxzkrsgttsqczlptxcdyyzxsqzslxlzmycpcqbzyxhbsxlzdltcdxtylzjyyzpzyzltxjsjxhlpmytxcqrblzssfjzztnjytxmyjhlhpplcyxqjqqkzzscpzkswalqsblcczjsxgwwwygyktjbbztdkhxhkgtgpbkqyslpxpjckbmllxdzstbklggqkqlsbkktfxrmdkbftpzfrtbbrferqgxyjpzsstlbztpszqzsjdhljqlzbpmsmmsxlqqnhknblrddnxxdhddjcyygylxgzlxsygmqqgkhbpmxyxlytqwlwgcpbmqxcyzydrjbhtdjyhqshtmjsbyplwhlzffnypmhxxhpltbqpfbjwqdbygpnztpfzjgsddtqshzeawzzylltyybwjkxxghlfkxdjtmszsqynzggswqsphtlsskmclzxyszqzxncjdqgzdlfnykljcjllzlmzznhydsshthzzlzzbbhqzwwycrzhlyqqjbeyfxxxwhsrxwqhwpslmsskzttygyqqwrslalhmjtqjsmxqbjjzjxzyzkxbyqxbjxshztsfjlxmxzxfghkzszggylclsarjyhslllmzxelglxydjytlfbhbpnlyzfbbhptgjkwetzhkjjxzxxglljlstgshjjyqlqzfkcgnndjsszfdbctwwseqfhqjbsaqtgypqlbxbmmywxgslzhglzgqyflzbyfzjfrysfmbyzhqgfwzsyfyjjphzbyyzffwodgrlmftwlbzgycqxcdjygzyyyytytydwegazyhxjlzyyhlrmgrxxzclhneljjtjtpwjybjjbxjjtjteekhwsljplpsfyzpqqbdlqjjtyyqlyzkdksqjyyqzldqtgjqyzjsucmryqthtejmfctyhypkmhyzwjdqfhyyxwshctxrljhqxhccyyyjltkttytmxgtcjtzayyoczlylbszywjytsjyhbyshfjlygjxxtmzyyltxxypzlxyjzyzyypnhmymdyylblhlsyyqqllnjjymsoyqbzgdlyxylcqyxtszegxhzglhwbljheyxtwqmakbpqcgyshhegqcmwyywljyjhyyzlljjylhzyhmgsljljxcjjyclycjpcpzjzjmmylcqlnqljqjsxyjmlszljqlycmmhcfmmfpqqmfylqmcffqmmmmhmznfhhjgtthhkhslnchhyqdxtmmqdcyzyxyqmyqyltdcyyyzazzcymzydlzfffmmycqzwzzmabtbyztdmnzzggdftypcgqyttssffwfdtzqssystwxjhxytsxxylbyqhwwkxhzxwznnzzjzjjqjccchyyxbzxzcyztllcqxynjycyycynzzqyyyewyczdcjycchyjlbtzyycqwmpwpymlgkdldlgkqqbgychjxy';
    //如果不在汉字处理范围之内,返回原字符
    if(uni > 40869 || uni < 19968)
        return ch; 
    return strChineseFirstPY.charAt(uni-19968);
}

//去除字符串的前后空白
String.prototype.trim = function(){
      return this.replace(/(^\s*)|(\s*$)/g,"");
}
//判断字符串是否全为数字
String.prototype.IsNum = function(){
    var reg = /^\d+$/g;
    return reg.test(this);
}
//Open Editer Window
function OpenEditerWindow(Url,WindowName,Width,Height,SetObj)
{
	var ReturnStr = window.open(Url,WindowName,'toolbar=0,location=0,maximize=1,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,top=50,left=50,width='+Width+',height='+Height);
	if (ReturnStr!='')SetObj.value=ReturnStr;
	return ReturnStr;
}

function selectAll(f,mode)
{
	if(mode==true)
	{
	    for(i=0;i<f.length;i++)
	    {
		    if(f.elements[i].type=="checkbox")
		    {
			    f.elements[i].checked=true;
		    }
	    }
	}
	else
	{
	    for(i=0;i<f.length;i++)
	    {
		    if(f.elements[i].type=="checkbox")
		    {
			    f.elements[i].checked=false;
		    }
	    }
	}
}

//CSS背景控制
function overColor(Obj)
{
	var elements=Obj.childNodes;
	for(var i=0;i<elements.length;i++)
	{
		elements[i].className="TR_BG"
		Obj.bgColor="";//颜色要改
	}
	
}
function outColor(Obj)
{
	var elements=Obj.childNodes;
	for(var i=0;i<elements.length;i++)
	{
		elements[i].className="TR_BG_list";
		Obj.bgColor="";
	}
}

//CSS背景控制
function useroverColor(Obj)
{
	var elements=Obj.childNodes;
	for(var i=0;i<elements.length;i++)
	{
		elements[i].className="bg_over"
		Obj.bgColor="";//颜色要改
	}
	
}
function useroutColor(Obj)
{
	var elements=Obj.childNodes;
	for(var i=0;i<elements.length;i++)
	{
		elements[i].className="bg_out";
		Obj.bgColor="";
	}
}


function CheckNumber(Obj,DescriptionStr)
{
	if (Obj.value!='' && (isNaN(Obj.value) || Obj.value<0))
	{
		alert(DescriptionStr+"应填有效数字！");
		Obj.value="";
		Obj.focus();
	}
}
//菜单效果
		var menuOffX=2;	
		var menuOffY=32;	
		var fo_shadows=new Array();
		var linkset=new Array();
		
		var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
		var ns6=document.getElementById&&!document.all
		var ns4=document.layers
		
		function showmenu(e,index,p,paging){
			if (!document.all&&!document.getElementById&&!document.layers)
				return
			which=linkset[index];
			var pSize=25	//每页
			var pNum=Math.floor((which.length-1)/pSize)+1		//页
			
			clearhidemenu()
			ie_clearshadow()
			if (pNum==1){
				which=which.join("")
			}else{
				which=which.slice( (p-1)*pSize, p*pSize )
				which=which.join("")
				which+=""
				if (p==1)
				{
					which+="&nbsp;&nbsp;&nbsp;&nbsp;<font face=webdings color=gray>7</font>"
				}else{
					which+="&nbsp;&nbsp;&nbsp;&nbsp;<font face=webdings style=cursor:hand onclick=showmenu(event,"+ index +","+ (p-1) +",true) >7</font>"
				}
				if (p==pNum)
				{
					which+="<font face=webdings color=gray>8</font>"
				}else{
					which+="<font face=webdings style=cursor:hand onclick=showmenu(event,"+ index +","+ (p+1) +",true) >8</font>"
				}
				which+=""
			}
			
			menuobj=ie4? document.all.popmenu : ns6? document.getElementById("popmenu") : ns4? document.popmenu : ""
			menuobj.thestyle=(ie4||ns6)? menuobj.style : menuobj
			
			if (ie4||ns6)
				menuobj.innerHTML=which
				
			else{
				menuobj.document.write('<layer name=gui bgColor=#E6E6E6 width=165 onmouseover="clearhidemenu()" onmouseout="hidemenu()">'+which+'</layer>')
				menuobj.document.close()
			}
			menuobj.contentwidth=(ie4||ns6)? menuobj.offsetWidth : menuobj.document.gui.document.width
			menuobj.contentheight=(ie4||ns6)? menuobj.offsetHeight : menuobj.document.gui.document.height
			
			eventX=ie4? event.clientX : ns6? e.clientX : e.x
			eventY=ie4? event.clientY : ns6? e.clientY : e.y
			
			var rightedge=ie4? document.body.clientWidth-eventX : window.innerWidth-eventX
			var bottomedge=ie4? document.body.clientHeight-eventY : window.innerHeight-eventY
			
			
			if (!paging)
			{	
				if (rightedge<menuobj.contentwidth)
					menuobj.thestyle.left=ie4? document.body.scrollLeft+eventX-menuobj.contentwidth+menuOffX : ns6? window.pageXOffset+eventX-menuobj.contentwidth : eventX-menuobj.contentwidth
				else
					menuobj.thestyle.left=ie4? ie_x(event.srcElement)+menuOffX : ns6? window.pageXOffset+eventX : eventX
				
				if (bottomedge<menuobj.contentheight)
					menuobj.thestyle.top=ie4? document.body.scrollTop+eventY-menuobj.contentheight-event.offsetY+menuOffY : ns6? window.pageYOffset+eventY-menuobj.contentheight : eventY-menuobj.contentheight
				else
					menuobj.thestyle.top=ie4? ie_y(event.srcElement)+menuOffY : ns6? window.pageYOffset+eventY : eventY
			}
				
			menuobj.thestyle.visibility="visible"
			ie_dropshadow(menuobj,"#DCDCDC",3)
			return false
		}
		function ie_x(e){  
			var l=e.offsetLeft;  
			while(e=e.offsetParent){  
				l+=e.offsetLeft;  
			}  
			return l;  
		}  
		
		
		function ie_y(e){  
			var t=e.offsetTop;  
			while(e=e.offsetParent){  
				t+=e.offsetTop;  
			}  
			return t;  
		}  
		
		function ie_dropshadow(el, color, size)
		{
			var i;
			for (i=size; i>0; i--)
			{
				var rect = document.createElement('div');
				var rs = rect.style
				rs.position = 'absolute';
				rs.left = (el.style.posLeft + i) + 'px';
				rs.top = (el.style.posTop + i) + 'px';
				rs.width = el.offsetWidth + 'px';
				rs.height = el.offsetHeight + 'px';
				rs.zIndex = el.style.zIndex - i;
				rs.backgroundColor = color;
				var opacity = 1 - i / (i + 1);
				rs.filter = 'alpha(opacity=' + (100 * opacity) + ')';
				el.insertAdjacentElement('afterEnd', rect);		
				fo_shadows[fo_shadows.length] = rect;
			}
		}
		function ie_clearshadow()
		{
			for(var i=0;i<fo_shadows.length;i++)
			{
				if (fo_shadows[i])
					fo_shadows[i].style.display="none"
			}
			fo_shadows=new Array();
		}
		
		
		function contains_ns6(a, b) {
			while (b.parentNode)
				if ((b = b.parentNode) == a)
					return true;
			return false;
		}
		
		function hidemenu(){
			if (window.menuobj)
				menuobj.thestyle.visibility=(ie4||ns6)? "hidden" : "hide"
			ie_clearshadow()
		}
		
		function dynamichide(e){
			if (ie4&&!menuobj.contains(e.toElement))
				hidemenu()
			else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
				hidemenu()
		}
		
		function delayhidemenu(){
			if (ie4||ns6||ns4)
				delayhide=setTimeout("hidemenu()",800)
		}
		
		function clearhidemenu(){
			if (window.delayhide)
				clearTimeout(delayhide)
		}
		
		function highlightmenu(e,state){
			if (document.all)
				source_el=event.srcElement
			else if (document.getElementById)
				source_el=e.target
			if (source_el.className=="menuitems"){
				source_el.id=(state=="on")? "mouseoverstyle" : ""
			}
			else{
				while(source_el.id!="popmenu"){
					source_el=document.getElementById? source_el.parentNode : source_el.parentElement
					if (source_el.className=="menuitems"){
						source_el.id=(state=="on")? "mouseoverstyle" : ""
					}
				}
			}
		}
				

		function imgzoom(img,maxsize){
			var a=new Image();
			a.src=img.src
			if(a.width > maxsize * 4)
			{
				img.style.width=maxsize;
			}
			else if(a.width >= maxsize)
			{
				img.style.width=Math.round(a.width * Math.floor(4 * maxsize / a.width) / 4);
			}
			return false;
		}
		function zoom_img(e, o)
		{
		var zoom = parseInt(o.style.zoom, 10) || 100;
		zoom += event.wheelDelta / 12;
		if (zoom > 0) o.style.zoom = zoom + '%';
		return false;
		}  




position = function(x,y)
{
    this.x = x;
    this.y = y;
}

getPosition = function(oElement)
{
    var objParent = oElement
    var oPosition = new position(0,0);
    while (objParent.tagName != "BODY")
    {
        oPosition.x += objParent.offsetLeft;
        oPosition.y += objParent.offsetTop;
        objParent = objParent.offsetParent;
    }
    return oPosition;
} 

function showDiv(obj,content)

{
    var pos = getPosition(obj)
    var objDiv = document.createElement("div");
    objDiv.className="lionrong";//For IE
    objDiv.style.position = "absolute";
	var tempheight=pos.y;
	var tempwidth1,tempheight1;
	var windowwidth=document.body.clientWidth;
	
	var isIE5 = (navigator.appVersion.indexOf("MSIE 5")>0) || (navigator.appVersion.indexOf("MSIE")>0 && parseInt(navigator.appVersion)> 4);
	var isIE55 = (navigator.appVersion.indexOf("MSIE 5.5")>0);
	var isIE6 = (navigator.appVersion.indexOf("MSIE 6")>0);
	var isIE7 = (navigator.appVersion.indexOf("MSIE 7")>0);

	if(isIE5||isIE55||isIE6||isIE7){var tempwidth=pos.x+305;}else{var tempwidth=pos.x+312;}
	objDiv.style.width = "300px";
    objDiv.innerHTML = content;
	if (tempwidth>windowwidth)
	{
		tempwidth1=tempwidth-windowwidth
		objDiv.style.left = (pos.x-tempwidth1) + "px";
	}
	else
	{
		if(isIE5||isIE55||isIE6||isIE7){objDiv.style.left = (pos.x + 10) + "px";}else{objDiv.style.left = (pos.x) + "px";}
	}
	if(isIE5||isIE55||isIE6||isIE7){objDiv.style.top = (pos.y+16) + "px";}else{objDiv.style.top = (pos.y+16) + "px";}

    objDiv.style.display = "";
    document.onclick=function () { if(objDiv.style.display==""){objDiv.style.display="none";} }
    document.body.appendChild(objDiv);
}

function ShowDivPic(obj,Urls,exname,length)
{
    var Url = Urls.replace("\\","/");
    var pos = getPosition(obj)
    var objDiv = document.createElement("div");
    objDiv.className="lionrong";//For IE
    objDiv.id="showpic_id";
    objDiv.style.position = "absolute";
	var tempheight=pos.y;
	var tempwidth1,tempheight1;
	var windowwidth=document.body.clientWidth;
	
	var isIE5 = (navigator.appVersion.indexOf("MSIE 5")>0) || (navigator.appVersion.indexOf("MSIE")>0 && parseInt(navigator.appVersion)> 4);
	var isIE55 = (navigator.appVersion.indexOf("MSIE 5.5")>0);
	var isIE6 = (navigator.appVersion.indexOf("MSIE 6")>0);
	var isIE7 = (navigator.appVersion.indexOf("MSIE 7")>0);
	switch(exname)
	{
	    case ".jpg":case ".gif":case ".bmp":case ".ico":case ".png":case ".jpeg":case ".tif":
	        if(length<12000)
	        {
                if(Url=="")
                {
                    var content = "无图片";
                }
                else
                {
                    var content = "<img src='"+Url+"' border='0' />";
                }
            }
            else
            {
                var content = "<img src='"+Url+"' border='0' width='100px'/>";
            }
            break;
	    case ".swf":
	        if(length<12000)
	        {
            var content = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0\">";
            content+="<param name=\"movie\" value=\""+Url+"\" />"
            content+="<param name=\"quality\" value=\"high\" />"
            content+="<embed src=\""+Url+"\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\"></embed>"
            content+="</object>"
            }
            else
            {
            var content = "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0\" width=\"100px\">";
            content+="<param name=\"movie\" value=\""+Url+"\" />"
            content+="<param name=\"quality\" value=\"high\" />"
            content+="<embed src=\""+Url+"\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"100px\"></embed>"
            content+="</object>"
            }
            break;
            break;
	    case ".html":case ".htm":case ".aspx":case ".shtm":case ".shtml":case ".asp":
            var content = "Path:"+Url;
            break;
        default:
            var content = "Path:"+Url;
            break;
	}
	if(isIE5||isIE55||isIE6||isIE7){var tempwidth=pos.x+250;}else{var tempwidth=pos.x+250;}
    objDiv.innerHTML = content;
	if (tempwidth>windowwidth)
	{
		tempwidth1=tempwidth-windowwidth
		objDiv.style.left = (pos.x-tempwidth1) + "px";
	}
	else
	{
		if(isIE5||isIE55||isIE6||isIE7){objDiv.style.left = (pos.x) + "px";}else{objDiv.style.left = (pos.x) + "px";}
	}
	if(isIE5||isIE55||isIE6||isIE7){objDiv.style.top = (pos.y+18) + "px";}else{objDiv.style.top = (pos.y+18) + "px";}

	objDiv.style.left = "250px";
    objDiv.style.top = (pos.y-68) + "px";
    objDiv.style.display = "";
    document.onclick=function () { if(objDiv.style.display==""){objDiv.style.display="none";} }
    document.body.appendChild(objDiv);
}

function hiddDivPic()
{
    var objDiv = document.getElementById("showpic_id");
    if (objDiv!=null&&objDiv!="undefined")
    {
       document.body.removeChild(objDiv);
    }
}
function closediv(objDiv)
{
   objDiv.parentNode.removeChild(objDiv);
}

function showfDiv(obj,content,width)

{
    var pos = getPosition(obj);
    var objDiv = document.getElementById("s_id");
    if (objDiv==null)
    {
        objDiv = document.createElement("div");
        objDiv.id="s_id";
    }
    objDiv.className="selectStyle";
    objDiv.style.position = "absolute";
	var tempheight=pos.y;
	var tempwidth1,tempheight1;
	var windowwidth=document.body.clientWidth;
	
	var isIE5 = (navigator.appVersion.indexOf("MSIE 5")>0) || (navigator.appVersion.indexOf("MSIE")>0 && parseInt(navigator.appVersion)> 4);
	var isIE55 = (navigator.appVersion.indexOf("MSIE 5.5")>0);
	var isIE6 = (navigator.appVersion.indexOf("MSIE 6")>0);
	var isIE7 = (navigator.appVersion.indexOf("MSIE 7")>0);

	if(isIE5||isIE55||isIE6||isIE7){var tempwidth=pos.x+305;}else{var tempwidth=pos.x+312;}
	objDiv.style.width = width+"px";
    objDiv.innerHTML = content;
	if (tempwidth>windowwidth)
	{
		tempwidth1=tempwidth-windowwidth
		objDiv.style.left = (pos.x-tempwidth1) + "px";
	}
	else
	{
		if(isIE5||isIE55||isIE6||isIE7){objDiv.style.left = (pos.x) + "px";}else{objDiv.style.left = (pos.x) + "px";}
	}
	if(isIE5||isIE55||isIE6||isIE7){objDiv.style.top = (pos.y+22) + "px";}else{objDiv.style.top = (pos.y+22) + "px";}

    objDiv.style.display = "";
    document.ondblclick=function () { if(objDiv.style.display==""){objDiv.style.display="none";} }
    document.body.appendChild(objDiv);
}





function show(type,obj,title,label_width,height)
{
    var label_temp1 = "<div onmousedown=\"drag(event,$('LabelDivid'));\" class=\"titile_bg\" style=\"cursor:move;\">\
    <table style=\"width:100%;\">\
    <tr>\
    <td>\
    <font color=\"white\">" + title + "</font></td>\
    <td style=\"width:20px\">\
    <img src=\"../Images/disable.gif\" style=\"cursor:pointer;\" title=\"close\" onclick=\"closediv($('LabelDivid'));\" />\
    </td>\
    </tr>\
    </table>\
    </div>\
    <iframe src=";
    var label_temp2 = " frameborder=\"0\" id=\"select_main\" scrolling=\"yes\" name=\"select_main\" width=\"100%\" height=\""+height+"px\" />";
    var label_temp3 = "";
    switch(type)
    {
       
        case "ChannelLabel":
            label_temp3 = label_temp1 + "TempleAdd.aspx" + label_temp2;
            break;
        case "sNews":
            label_temp3 = label_temp1 + "../../configuration/system/ShowNews.aspx" + label_temp2;
            break;
    }
    showlabelDiv(obj,label_temp3,label_width);
}




function showlabelDiv(obj,content,width)
{
    var pos = getPosition(obj);
    var objDiv = document.getElementById("LabelDivid");
    if (objDiv==null)
    {
        objDiv = document.createElement("div");
        objDiv.id="LabelDivid";
    }
    objDiv.className="selectStyle";//For IE
    objDiv.style.position = "absolute";
	var tempheight=pos.y;
	var tempwidth1,tempheight1;
	var windowwidth=document.body.clientWidth;
	
	var isIE5 = (navigator.appVersion.indexOf("MSIE 5")>0) || (navigator.appVersion.indexOf("MSIE")>0 && parseInt(navigator.appVersion)> 4);
	var isIE55 = (navigator.appVersion.indexOf("MSIE 5.5")>0);
	var isIE6 = (navigator.appVersion.indexOf("MSIE 6")>0);
	var isIE7 = (navigator.appVersion.indexOf("MSIE 7")>0);

	if(isIE5||isIE55||isIE6||isIE7){var tempwidth=pos.x+305;}else{var tempwidth=pos.x+312;}
	objDiv.style.width = width+"px";
    objDiv.innerHTML = content;
	if (tempwidth>windowwidth)
	{
		tempwidth1=tempwidth-windowwidth
		objDiv.style.left = (pos.x-tempwidth1) + "px";
	}
	else
	{
		if(isIE5||isIE55||isIE6||isIE7){objDiv.style.left = (pos.x) + "px";}else{objDiv.style.left = (pos.x) + "px";}
	}
	if(isIE5||isIE55||isIE6||isIE7){objDiv.style.top = (pos.y+22) + "px";}else{objDiv.style.top = (pos.y+22) + "px";}

    objDiv.style.display = "";
    document.ondblclick=function () { if(objDiv.style.display==""){objDiv.style.display="none";} }
    document.body.appendChild(objDiv);
}

function ReturnLabelValue(value)
{
    IDContentTextBox.insertHTML(value);
    document.getElementById("LabelDivid").style.display="none";
    return;
}

function ReturnLabelValueText(value)
{
    try
    {
//        //IDContent.insertHTML(value)
//        IDContentTextBox.insertHTML(value);
        if(value!="")
        {
            var oEditor = FCKeditorAPI.GetInstance("Content");
            if (oEditor.EditMode==FCK_EDITMODE_WYSIWYG)
            {
               oEditor.InsertHtml(value);
            }else
            {
            return false;
            }
        }
    }
    catch(e)
    {
        insert(value);
    }
    finally
    {
        document.getElementById("LabelDivid").style.display="none";
        return;
    }
}

function ReturnNewsValueText(value)
{
    try
    {
        SubNewsContent.insertHTML(value);
    }
    catch(e)
    {
        insertNews(value);
    }
    finally
    {
        document.getElementById("LabelDivid").style.display="none";
        return;
    }
}

function insert(returnValue_lable)
{
	obj=document.getElementById("Content");
	obj.focus();
	if(document.selection==null)
	{
		var iStart = obj.selectionStart
		var iEnd = obj.selectionEnd;
		obj.value = obj.value.substring(0, iEnd) +returnValue_lable+ obj.value.substring(iEnd, obj.value.length);
	}else
	{
		var range = document.selection.createRange();
		range.text=returnValue_lable;
	}
}


function insertNews(returnValue_lable)
{
	obj=document.getElementById("SubNewsContent");
	obj.focus();
	if(document.selection==null)
	{
		var iStart = obj.selectionStart
		var iEnd = obj.selectionEnd;
		obj.value = obj.value.substring(0, iEnd) +returnValue_lable+ obj.value.substring(iEnd, obj.value.length);
	}else
	{
		var range = document.selection.createRange();
		range.text=returnValue_lable;
	}
}

function ReturnPageInfoValue(value)
{
    document.ListLabel.PageID.value=value;
    document.getElementById("LabelDivid").style.display="none";
    return;
}


    drag=function (a,o){
	    var d=document;if(!a)a=window.event;
		if(!a.pageX)a.pageX=a.clientX;
		if(!a.pageY)a.pageY=a.clientY;
	    var x=a.pageX,y=a.pageY;
	    if(o.setCapture)
		    o.setCapture();
	    else if(window.captureEvents)
		    window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
	    var backData = {x : o.style.top, y : o.style.left};
	    d.onmousemove=function(a){
		    if(!a)a=window.event;
		    if(!a.pageX)a.pageX=a.clientX;
		    if(!a.pageY)a.pageY=a.clientY;
		    var tx=a.pageX-x+parseInt(o.style.left),ty=a.pageY-y+parseInt(o.style.top);
		    o.style.left=tx+"px";
		    o.style.top=ty+"px";
			x=a.pageX;
			y=a.pageY;
	    };

	    d.onmouseup=function(a){
		    if(!a)a=window.event;
		    if(o.releaseCapture)
			    o.releaseCapture();
		    else if(window.captureEvents)
			    window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
		    d.onmousemove=null;
		    d.onmouseup=null;
		    if(!a.pageX)a.pageX=a.clientX;
		    if(!a.pageY)a.pageY=a.clientY;
		    if(!document.body.pageWidth)document.body.pageWidth=document.body.clientWidth;
		    if(!document.body.pageHeight)document.body.pageHeight=document.body.clientHeight;
		    if(a.pageX < 1 || a.pageY < 1 || a.pageX > document.body.pageWidth || a.pageY > document.body.pageHeight){
			    o.style.left = backData.y;
			    o.style.top = backData.x;
		    }
	    };
    }
 



function getHelpCode(code)
{
    var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
    var ns6=document.getElementById&&!document.all
    if (ie4)
    {
        var clipBoardContent=code;
        window.clipboardData.setData("Text",clipBoardContent);
        alert("帮助代码已经复制。代码："+code+"");
    }
    else
    {
        alert("FireFox浏览器用户请直接复制代码!");
    }
}

var intLeft = 2; 
function returnPage(Url) 
{
    if (0 == intLeft)
    {
        window.location.href=Url;
    }
    else 
    {
        intLeft -= 1;
        setTimeout("returnPage('"+Url+"')", 2000);
    }
}
//判断是否数组
function isArray(obj)
{   
  if(obj.constructor == window.Array)   
    return true;
  else   
    return false;
}
//-->

