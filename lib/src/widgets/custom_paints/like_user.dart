import 'package:cupizz_app/src/base/base.dart';

class LikeUserCustomPainter extends CustomPainter {
  final Color color;

  LikeUserCustomPainter({this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(size.width * 0.4350000, size.height * 0.2055556);
    path_0.cubicTo(
        size.width * 0.4658478,
        size.height * 0.2055544,
        size.width * 0.4957411,
        size.height * 0.2162489,
        size.width * 0.5195878,
        size.height * 0.2358167);
    path_0.cubicTo(
        size.width * 0.5434333,
        size.height * 0.2553856,
        size.width * 0.5597567,
        size.height * 0.2826167,
        size.width * 0.5657767,
        size.height * 0.3128711);
    path_0.cubicTo(
        size.width * 0.5717956,
        size.height * 0.3431256,
        size.width * 0.5671389,
        size.height * 0.3745311,
        size.width * 0.5525978,
        size.height * 0.4017367);
    path_0.cubicTo(
        size.width * 0.5380578,
        size.height * 0.4289422,
        size.width * 0.5145344,
        size.height * 0.4502644,
        size.width * 0.4860356,
        size.height * 0.4620711);
    path_0.cubicTo(
        size.width * 0.4575367,
        size.height * 0.4738767,
        size.width * 0.4258256,
        size.height * 0.4754356,
        size.width * 0.3963067,
        size.height * 0.4664822);
    path_0.cubicTo(
        size.width * 0.3667867,
        size.height * 0.4575289,
        size.width * 0.3412856,
        size.height * 0.4386167,
        size.width * 0.3241467,
        size.height * 0.4129689);
    path_0.cubicTo(
        size.width * 0.3070078,
        size.height * 0.3873211,
        size.width * 0.2992922,
        size.height * 0.3565233,
        size.width * 0.3023144,
        size.height * 0.3258244);
    path_0.cubicTo(
        size.width * 0.3053367,
        size.height * 0.2951256,
        size.width * 0.3189100,
        size.height * 0.2664244,
        size.width * 0.3407222,
        size.height * 0.2446111);
    path_0.cubicTo(
        size.width * 0.3530733,
        size.height * 0.2321900,
        size.width * 0.3677656,
        size.height * 0.2223422,
        size.width * 0.3839478,
        size.height * 0.2156378);
    path_0.cubicTo(
        size.width * 0.4001311,
        size.height * 0.2089344,
        size.width * 0.4174833,
        size.height * 0.2055067,
        size.width * 0.4350000,
        size.height * 0.2055556);
    path_0.lineTo(size.width * 0.4350000, size.height * 0.2055556);
    path_0.close();
    path_0.moveTo(size.width * 0.4350000, size.height * 0.1611111);
    path_0.cubicTo(
        size.width * 0.3998389,
        size.height * 0.1611111,
        size.width * 0.3654678,
        size.height * 0.1715378,
        size.width * 0.3362322,
        size.height * 0.1910722);
    path_0.cubicTo(
        size.width * 0.3069967,
        size.height * 0.2106067,
        size.width * 0.2842100,
        size.height * 0.2383711,
        size.width * 0.2707544,
        size.height * 0.2708567);
    path_0.cubicTo(
        size.width * 0.2572989,
        size.height * 0.3033411,
        size.width * 0.2537789,
        size.height * 0.3390856,
        size.width * 0.2606378,
        size.height * 0.3735711);
    path_0.cubicTo(
        size.width * 0.2674978,
        size.height * 0.4080567,
        size.width * 0.2844289,
        size.height * 0.4397344,
        size.width * 0.3092922,
        size.height * 0.4645967);
    path_0.cubicTo(
        size.width * 0.3341544,
        size.height * 0.4894589,
        size.width * 0.3658322,
        size.height * 0.5063911,
        size.width * 0.4003178,
        size.height * 0.5132511);
    path_0.cubicTo(
        size.width * 0.4348022,
        size.height * 0.5201100,
        size.width * 0.4705478,
        size.height * 0.5165900,
        size.width * 0.5030322,
        size.height * 0.5031344);
    path_0.cubicTo(
        size.width * 0.5355167,
        size.height * 0.4896789,
        size.width * 0.5632822,
        size.height * 0.4668922,
        size.width * 0.5828167,
        size.height * 0.4376567);
    path_0.cubicTo(
        size.width * 0.6023511,
        size.height * 0.4084211,
        size.width * 0.6127778,
        size.height * 0.3740500,
        size.width * 0.6127778,
        size.height * 0.3388889);
    path_0.cubicTo(
        size.width * 0.6127778,
        size.height * 0.2917389,
        size.width * 0.5940478,
        size.height * 0.2465211,
        size.width * 0.5607078,
        size.height * 0.2131811);
    path_0.cubicTo(
        size.width * 0.5273678,
        size.height * 0.1798411,
        size.width * 0.4821500,
        size.height * 0.1611111,
        size.width * 0.4350000,
        size.height * 0.1611111);
    path_0.lineTo(size.width * 0.4350000, size.height * 0.1611111);
    path_0.close();

    final paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);

    final path_1 = Path();
    path_1.moveTo(size.width * 0.4350000, size.height * 0.6044444);
    path_1.cubicTo(
        size.width * 0.4730311,
        size.height * 0.6043433,
        size.width * 0.5107256,
        size.height * 0.6115556,
        size.width * 0.5460333,
        size.height * 0.6256889);
    path_1.cubicTo(
        size.width * 0.5794611,
        size.height * 0.6390211,
        size.width * 0.6100522,
        size.height * 0.6585822,
        size.width * 0.6361778,
        size.height * 0.6833333);
    path_1.cubicTo(
        size.width * 0.6616478,
        size.height * 0.7073356,
        size.width * 0.6821211,
        size.height * 0.7361356,
        size.width * 0.6964222,
        size.height * 0.7680778);
    path_1.cubicTo(
        size.width * 0.7047922,
        size.height * 0.7868011,
        size.width * 0.7108444,
        size.height * 0.8064767,
        size.width * 0.7144444,
        size.height * 0.8266667);
    path_1.lineTo(size.width * 0.1555556, size.height * 0.8266667);
    path_1.cubicTo(
        size.width * 0.1591533,
        size.height * 0.8064844,
        size.width * 0.1652022,
        size.height * 0.7868167,
        size.width * 0.1735667,
        size.height * 0.7681000);
    path_1.cubicTo(
        size.width * 0.1878689,
        size.height * 0.7361489,
        size.width * 0.2083467,
        size.height * 0.7073411,
        size.width * 0.2338222,
        size.height * 0.6833333);
    path_1.cubicTo(
        size.width * 0.2599467,
        size.height * 0.6585744,
        size.width * 0.2905367,
        size.height * 0.6390056,
        size.width * 0.3239667,
        size.height * 0.6256667);
    path_1.cubicTo(
        size.width * 0.3592756,
        size.height * 0.6115411,
        size.width * 0.3969711,
        size.height * 0.6043367,
        size.width * 0.4350000,
        size.height * 0.6044444);
    path_1.lineTo(size.width * 0.4350000, size.height * 0.6044444);
    path_1.close();
    path_1.moveTo(size.width * 0.4350000, size.height * 0.5600000);
    path_1.cubicTo(
        size.width * 0.2539778,
        size.height * 0.5600000,
        size.width * 0.1072222,
        size.height * 0.6992889,
        size.width * 0.1072222,
        size.height * 0.8711111);
    path_1.lineTo(size.width * 0.7627778, size.height * 0.8711111);
    path_1.cubicTo(
        size.width * 0.7627778,
        size.height * 0.6992889,
        size.width * 0.6160222,
        size.height * 0.5600000,
        size.width * 0.4350000,
        size.height * 0.5600000);
    path_1.close();

    final paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1, paint_1_fill);

    final path_2 = Path();
    path_2.moveTo(size.width * 0.1166711, size.height * 0.1652000);
    path_2.cubicTo(
        size.width * 0.1061092,
        size.height * 0.1554256,
        size.width * 0.09228500,
        size.height * 0.1500000,
        size.width * 0.07793711,
        size.height * 0.1500000);
    path_2.cubicTo(
        size.width * 0.07034289,
        size.height * 0.1500078,
        size.width * 0.06282522,
        size.height * 0.1515278,
        size.width * 0.05581678,
        size.height * 0.1544711);
    path_2.cubicTo(
        size.width * 0.04880822,
        size.height * 0.1574144,
        size.width * 0.04244733,
        size.height * 0.1617244,
        size.width * 0.03709989,
        size.height * 0.1671511);
    path_2.cubicTo(
        size.width * 0.01429200,
        size.height * 0.1902056,
        size.width * 0.01430167,
        size.height * 0.2262656,
        size.width * 0.03711933,
        size.height * 0.2492222);
    path_2.lineTo(size.width * 0.1081894, size.height * 0.3207556);
    path_2.cubicTo(
        size.width * 0.1098372,
        size.height * 0.3236722,
        size.width * 0.1130167,
        size.height * 0.3255556,
        size.width * 0.1166711,
        size.height * 0.3255556);
    path_2.cubicTo(
        size.width * 0.1181711,
        size.height * 0.3255411,
        size.width * 0.1196478,
        size.height * 0.3251722,
        size.width * 0.1209811,
        size.height * 0.3244789);
    path_2.cubicTo(
        size.width * 0.1223144,
        size.height * 0.3237867,
        size.width * 0.1234678,
        size.height * 0.3227878,
        size.width * 0.1243478,
        size.height * 0.3215656);
    path_2.lineTo(size.width * 0.1962222, size.height * 0.2492222);
    path_2.cubicTo(
        size.width * 0.2190400,
        size.height * 0.2262556,
        size.width * 0.2190400,
        size.height * 0.1902056,
        size.width * 0.1962033,
        size.height * 0.1671122);
    path_2.cubicTo(
        size.width * 0.1908589,
        size.height * 0.1616956,
        size.width * 0.1845022,
        size.height * 0.1573944,
        size.width * 0.1775011,
        size.height * 0.1544578);
    path_2.cubicTo(
        size.width * 0.1704989,
        size.height * 0.1515211,
        size.width * 0.1629900,
        size.height * 0.1500056,
        size.width * 0.1554044,
        size.height * 0.1500000);
    path_2.cubicTo(
        size.width * 0.1410567,
        size.height * 0.1500022,
        size.width * 0.1272333,
        size.height * 0.1554267,
        size.width * 0.1166711,
        size.height * 0.1652000);
    path_2.lineTo(size.width * 0.1166711, size.height * 0.1652000);
    path_2.close();
    path_2.moveTo(size.width * 0.1824967, size.height * 0.1809078);
    path_2.cubicTo(
        size.width * 0.1976478,
        size.height * 0.1962356,
        size.width * 0.1976567,
        size.height * 0.2201778,
        size.width * 0.1825167,
        size.height * 0.2354267);
    path_2.lineTo(size.width * 0.1166711, size.height * 0.3017011);
    path_2.lineTo(size.width * 0.05082544, size.height * 0.2354267);
    path_2.cubicTo(
        size.width * 0.03568467,
        size.height * 0.2201778,
        size.width * 0.03569444,
        size.height * 0.1962356,
        size.width * 0.05080600,
        size.height * 0.1809467);
    path_2.cubicTo(
        size.width * 0.05817278,
        size.height * 0.1735711,
        size.width * 0.06780778,
        size.height * 0.1695122,
        size.width * 0.07793711,
        size.height * 0.1695122);
    path_2.cubicTo(
        size.width * 0.08806644,
        size.height * 0.1695122,
        size.width * 0.09766267,
        size.height * 0.1735711,
        size.width * 0.1049713,
        size.height * 0.1809278);
    path_2.lineTo(size.width * 0.1098179, size.height * 0.1858056);
    path_2.cubicTo(
        size.width * 0.1107172,
        size.height * 0.1867122,
        size.width * 0.1117856,
        size.height * 0.1874322,
        size.width * 0.1129611,
        size.height * 0.1879233);
    path_2.cubicTo(
        size.width * 0.1141378,
        size.height * 0.1884133,
        size.width * 0.1153978,
        size.height * 0.1886667,
        size.width * 0.1166711,
        size.height * 0.1886667);
    path_2.cubicTo(
        size.width * 0.1179444,
        size.height * 0.1886667,
        size.width * 0.1192044,
        size.height * 0.1884133,
        size.width * 0.1203800,
        size.height * 0.1879233);
    path_2.cubicTo(
        size.width * 0.1215567,
        size.height * 0.1874322,
        size.width * 0.1226244,
        size.height * 0.1867122,
        size.width * 0.1235244,
        size.height * 0.1858056);
    path_2.lineTo(size.width * 0.1283700, size.height * 0.1809278);
    path_2.cubicTo(
        size.width * 0.1430267,
        size.height * 0.1662056,
        size.width * 0.1678600,
        size.height * 0.1662444,
        size.width * 0.1824967,
        size.height * 0.1809078);
    path_2.lineTo(size.width * 0.1824967, size.height * 0.1809078);
    path_2.close();

    final paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawPath(path_2, paint_2_fill);

    final path_3 = Path();
    path_3.moveTo(size.width * 0.1172256, size.height * 0.1772400);
    path_3.cubicTo(
        size.width * 0.1083030,
        size.height * 0.1690111,
        size.width * 0.09662389,
        size.height * 0.1644444,
        size.width * 0.08450244,
        size.height * 0.1644444);
    path_3.cubicTo(
        size.width * 0.07808667,
        size.height * 0.1644511,
        size.width * 0.07173556,
        size.height * 0.1657300,
        size.width * 0.06581456,
        size.height * 0.1682078);
    path_3.cubicTo(
        size.width * 0.05989356,
        size.height * 0.1706856,
        size.width * 0.05451967,
        size.height * 0.1743133,
        size.width * 0.05000200,
        size.height * 0.1788822);
    path_3.cubicTo(
        size.width * 0.03073322,
        size.height * 0.1982889,
        size.width * 0.03074144,
        size.height * 0.2286422,
        size.width * 0.05001844,
        size.height * 0.2479667);
    path_3.lineTo(size.width * 0.1100604, size.height * 0.3081811);
    path_3.cubicTo(
        size.width * 0.1114522,
        size.height * 0.3106367,
        size.width * 0.1141389,
        size.height * 0.3122222,
        size.width * 0.1172256,
        size.height * 0.3122222);
    path_3.cubicTo(
        size.width * 0.1184933,
        size.height * 0.3122100,
        size.width * 0.1197411,
        size.height * 0.3119000,
        size.width * 0.1208667,
        size.height * 0.3113167);
    path_3.cubicTo(
        size.width * 0.1219933,
        size.height * 0.3107333,
        size.width * 0.1229678,
        size.height * 0.3098922,
        size.width * 0.1237111,
        size.height * 0.3088633);
    path_3.lineTo(size.width * 0.1844333, size.height * 0.2479667);
    path_3.cubicTo(
        size.width * 0.2037100,
        size.height * 0.2286344,
        size.width * 0.2037100,
        size.height * 0.1982889,
        size.width * 0.1844167,
        size.height * 0.1788489);
    path_3.cubicTo(
        size.width * 0.1799011,
        size.height * 0.1742889,
        size.width * 0.1745322,
        size.height * 0.1706689,
        size.width * 0.1686167,
        size.height * 0.1681967);
    path_3.cubicTo(
        size.width * 0.1627011,
        size.height * 0.1657244,
        size.width * 0.1563578,
        size.height * 0.1644489,
        size.width * 0.1499489,
        size.height * 0.1644444);
    path_3.cubicTo(
        size.width * 0.1378278,
        size.height * 0.1644467,
        size.width * 0.1261489,
        size.height * 0.1690133,
        size.width * 0.1172256,
        size.height * 0.1772400);
    path_3.lineTo(size.width * 0.1172256, size.height * 0.1772400);
    path_3.close();
    path_3.moveTo(size.width * 0.1728378, size.height * 0.1904622);
    path_3.cubicTo(
        size.width * 0.1856367,
        size.height * 0.2033644,
        size.width * 0.1856456,
        size.height * 0.2235178,
        size.width * 0.1728544,
        size.height * 0.2363544);
    path_3.lineTo(size.width * 0.1172256, size.height * 0.2921422);
    path_3.lineTo(size.width * 0.06159767, size.height * 0.2363544);
    path_3.cubicTo(
        size.width * 0.04880644,
        size.height * 0.2235178,
        size.width * 0.04881467,
        size.height * 0.2033644,
        size.width * 0.06158133,
        size.height * 0.1904944);
    path_3.cubicTo(
        size.width * 0.06780500,
        size.height * 0.1842867,
        size.width * 0.07594489,
        size.height * 0.1808700,
        size.width * 0.08450244,
        size.height * 0.1808700);
    path_3.cubicTo(
        size.width * 0.09306000,
        size.height * 0.1808700,
        size.width * 0.1011671,
        size.height * 0.1842867,
        size.width * 0.1073417,
        size.height * 0.1904789);
    path_3.lineTo(size.width * 0.1114367, size.height * 0.1945844);
    path_3.cubicTo(
        size.width * 0.1121956,
        size.height * 0.1953478,
        size.width * 0.1130989,
        size.height * 0.1959533,
        size.width * 0.1140922,
        size.height * 0.1963667);
    path_3.cubicTo(
        size.width * 0.1150856,
        size.height * 0.1967800,
        size.width * 0.1161500,
        size.height * 0.1969922,
        size.width * 0.1172256,
        size.height * 0.1969922);
    path_3.cubicTo(
        size.width * 0.1183011,
        size.height * 0.1969922,
        size.width * 0.1193667,
        size.height * 0.1967800,
        size.width * 0.1203600,
        size.height * 0.1963667);
    path_3.cubicTo(
        size.width * 0.1213533,
        size.height * 0.1959533,
        size.width * 0.1222556,
        size.height * 0.1953478,
        size.width * 0.1230156,
        size.height * 0.1945844);
    path_3.lineTo(size.width * 0.1271100, size.height * 0.1904789);
    path_3.cubicTo(
        size.width * 0.1394922,
        size.height * 0.1780856,
        size.width * 0.1604722,
        size.height * 0.1781189,
        size.width * 0.1728378,
        size.height * 0.1904622);
    path_3.lineTo(size.width * 0.1728378, size.height * 0.1904622);
    path_3.close();

    final paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
