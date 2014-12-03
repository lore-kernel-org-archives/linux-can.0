From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Wed, 3 Dec 2014 17:54:12 +0000
Message-ID: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0070.outbound.protection.outlook.com ([157.55.234.70]:29251
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751425AbaLCRyR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 3 Dec 2014 12:54:17 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Tested on sja1000 using
 cangen -Ii -g 100 can0
and
 candump -ta -e can0,0:0,#FFFFFFFF

Disconnected bus:
 (1417614605.207964)  can0  07D   [6]  49 6E A1 7A 2A 3D
 (1417614605.308206)  can0  07E   [8]  5F 18 AA 0F E5 82 CA 11
 (1417614605.408107)  can0  07F   [5]  3E 12 B0 68 1A
 (1417614605.514235)  can0  20000004   [8]  00 08 00 00 00 00 60 00   ERRORFRAME
	controller-problem{tx-error-warning}
	error-counter-tx-rx{{96}{0}}
 (1417614605.516653)  can0  20000004   [8]  00 20 00 00 00 00 80 00   ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{128}{0}}
 (1417614610.309791)  can0  080   [2]  78 36
 (1417614610.310363)  can0  081   [2]  1B F5
 (1417614610.311098)  can0  082   [4]  8A E5 F4 06
 (1417614610.312065)  can0  083   [8]  A6 3A FA 5C 93 4D 33 48
 (1417614610.313056)  can0  084   [8]  EF 08 EB 6E 36 04 13 30
 (1417614610.314028)  can0  085   [8]  F1 64 35 4B DD 06 2A 2D
 (1417614610.314974)  can0  086   [8]  57 D9 31 0D D3 1C 8A 6A
 (1417614610.315928)  can0  087   [8]  5D D7 55 45 1D 8B 2B 65
 (1417614610.316834)  can0  088   [7]  F5 E9 25 14 7C A3 D5
 (1417614610.316845)  can0  20000004   [8]  00 08 00 00 00 00 7F 00   ERRORFRAME
	controller-problem{tx-error-warning}
	error-counter-tx-rx{{127}{0}}
 (1417614610.317793)  can0  089   [8]  BB D4 C7 1A BA B5 85 5D
 (1417614610.318614)  can0  08A   [6]  1D BB 2C 62 32 EC
 (1417614610.319572)  can0  08B   [8]  10 ED 82 1B 4D E1 5F 5F
...
 (1417614610.340833)  can0  0A6   [8]  7F 29 E1 40 2D 18 AA 6C
 (1417614610.341760)  can0  0A7   [8]  8B F7 5E 54 C5 34 2A 3C
 (1417614610.342476)  can0  0A8   [4]  5A A4 C1 66
 (1417614610.342487)  can0  20000004   [8]  00 40 00 00 00 00 5F 00   ERRORFRAME
	controller-problem{back-to-error-active}
	error-counter-tx-rx{{95}{0}}
 (1417614610.343428)  can0  0A9   [8]  0A EB 35 5A F4 3C 26 27
 (1417614610.343912)  can0  0AA   [1]  AB
 (1417614610.344900)  can0  0AB   [8]  01 F3 40 46 11 8F 03 07

Shorted bus:
 (1417614733.580463)  can0  075   [1]  10
 (1417614733.680828)  can0  076   [5]  55 63 B4 58 1A
 (1417614733.781137)  can0  077   [8]  14 93 E7 5F 7E BF 67 6E
 (1417614733.881148)  can0  078   [7]  4D FF F5 4E B8 DE B4
 (1417614733.980491)  can0  20000004   [8]  00 08 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-warning}
	error-counter-tx-rx{{136}{0}}
 (1417614733.980502)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{136}{0}}
 (1417614733.983670)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
	bus-off
	error-counter-tx-rx{{127}{0}}
 (1417614734.032802)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (1417614734.080595)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{136}{0}}
 (1417614734.083760)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
	bus-off
	error-counter-tx-rx{{127}{0}}
 (1417614734.132798)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
...
 (1417614735.582083)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{136}{0}}
 (1417614735.585239)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
	bus-off
	error-counter-tx-rx{{127}{0}}
 (1417614735.634802)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (1417614735.682177)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{136}{0}}
 (1417614735.685333)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
	bus-off
	error-counter-tx-rx{{127}{0}}
 (1417614735.734799)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (1417614735.782533)  can0  08B   [0] 
 (1417614735.883121)  can0  08C   [8]  EE B8 26 71 94 E4 40 3A
 (1417614735.983085)  can0  08D   [6]  43 8C F9 74 88 2A
 (1417614736.083039)  can0  08E   [4]  75 C6 34 20

Tested on mscan using same method as on sja1000

Disconnected bus:
 (1417623622.972519)  can0  01C   [8]  45 B9 30 19 4A 87 AC C3
 (1417623623.072734)  can0  01D   [8]  41 8E B5 85 76 FA 0C 3D
 (1417623623.172831)  can0  01E   [8]  51 4E 25 33 38 02 D0 36
 (1417623623.283737)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-warning}
 (1417623623.287658)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-passive}
 (1417623626.712375)  can0  01F   [8]  27 E5 95 62 0C 49 55 8E
 (1417623626.713029)  can0  020   [3]  56 F7 9D
 (1417623626.714007)  can0  021   [8]  4D BC DA 25 12 E2 48 58
 (1417623626.714990)  can0  022   [8]  26 77 4A 83 55 38 70 90
 (1417623626.715841)  can0  023   [6]  30 EF 54 7C 21 A4
 (1417623626.716686)  can0  024   [6]  53 CA C8 58 14 C4
 (1417623626.717463)  can0  025   [5]  2E AB 3A 8F 2F
 (1417623626.718463)  can0  026   [8]  32 AE 74 9B 74 FF 83 66
 (1417623626.719429)  can0  027   [8]  13 B8 97 25 36 8E 38 EB
 (1417623626.719555)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-warning}
 (1417623626.720374)  can0  028   [8]  43 FC 80 D3 07 DC 5E 1F
 (1417623626.721319)  can0  029   [8]  0B 5C DE 9B 2F C1 F3 81
 (1417623626.722221)  can0  02A   [8]  5B 17 4C 5E 06 B9 90 D9
...
 (1417623627.077577)  can0  045   [8]  71 D4 3F 86 50 74 AA 40
 (1417623627.177184)  can0  046   [0] 
 (1417623627.277582)  can0  047   [4]  13 4F 3E 7E
 (1417623627.277683)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
	controller-problem{back-to-error-active}
 (1417623627.377999)  can0  048   [8]  44 7B 82 CA 7F 67 D2 7E
 (1417623627.478112)  can0  049   [8]  14 D2 8B 88 63 3E 70 F9
 (1417623627.578022)  can0  04A   [5]  21 DC EF 71 50

Shorted bus:
 (1417623654.357271)  can0  035   [1]  71
 (1417623654.457831)  can0  036   [8]  23 48 51 A1 0E 42 44 03
 (1417623654.557975)  can0  037   [8]  32 46 2E DA 04 01 E5 0A
 (1417623654.657396)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-warning}
 (1417623654.660594)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	bus-off
 (1417623654.709898)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (1417623654.757863)  can0  039   [2]  39 C4
 (1417623654.858415)  can0  03A   [8]  22 40 33 0D 07 CF B7 4D
 (1417623654.958519)  can0  03B   [8]  06 08 73 B7 7A CB EB 50

Tested on flexcan with berr-reporting on using
 cangen -Ii -g100 can0
 cangen -I7ff -g100 can1
and
 candump -ta -e can0,0:0,#FFFFFFFF | awk '$3!="7FF"'

Disconnected bus:
 (0000001478.632215)  can0  024   [8]  18 9E 39 5C 0F 06 E8 40
 (0000001478.731904)  can0  025   [2]  27 B2
 (0000001478.832383)  can0  026   [8]  47 99 75 37 3B E0 22 66
 (0000001478.932014)  can0  027   [1]  B3
 (0000001479.037349)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
 (0000001479.042476)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
 (0000001479.048217)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-warning}
 (0000001479.053361)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
 (0000001479.059702)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-passive}
 (0000001479.064803)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
...
 (0000001481.415537)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
 (0000001481.425991)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
	protocol-violation{{}{acknowledge-slot}}
	no-acknowledgement-on-tx
	bus-error
 (0000001481.425984)  can0  028   [4]  A8 9F 1F 0A
 (0000001481.431221)  can0  029   [8]  C3 53 9B 4D 83 55 18 4E
 (0000001481.436556)  can0  20000088   [8]  00 00 10 00 00 00 00 00   ERRORFRAME
	protocol-violation{{tx-recessive-bit-error}{}}
	bus-error
 (0000001481.436543)  can0  02A   [8]  A4 B5 BC 44 DB 29 4E 0E
 (0000001481.443227)  can0  02B   [3]  1F E0 87
 (0000001481.445067)  can0  02C   [8]  55 DC 74 60 F4 D1 08 08
...
 (0000001481.462031)  can0  036   [8]  B5 6E D5 0D A5 77 1F 45
 (0000001481.463901)  can0  037   [8]  11 E2 F9 5D 37 AF 9B 23
 (0000001481.465509)  can0  038   [6]  FF DE 3E 04 64 E1
 (0000001481.471866)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-warning}
 (0000001481.471847)  can0  039   [5]  FC E1 6B 6B D3
 (0000001481.472924)  can0  03A   [8]  65 C2 CC 4C EF 73 6C 7B
 (0000001481.474331)  can0  03B   [8]  09 83 50 14 0C 68 43 2C
...
 (0000001483.536735)  can0  055   [4]  62 3E ED 7E
 (0000001483.637095)  can0  056   [8]  BB B1 24 2A 95 10 02 23
 (0000001483.736733)  can0  057   [1]  AC
 (0000001483.837075)  can0  058   [5]  32 93 12 77 4A
 (0000001483.881385)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
	controller-problem{back-to-error-active}
 (0000001483.936853)  can0  059   [0] 
 (0000001484.037476)  can0  05A   [8]  34 3D 80 50 6C 4D E6 61
 (0000001484.137165)  can0  05B   [2]  7A 37

Shorted bus:
 (0000001507.328080)  can0  022   [8]  80 04 85 66 8F 49 79 00
 (0000001507.428192)  can0  023   [8]  FD BD 5C 07 E6 78 25 0C
 (0000001507.528157)  can0  024   [6]  CF D9 D9 3C DA 78
 (0000001507.632677)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
	protocol-violation{{tx-dominant-bit-error}{}}
	bus-error
 (0000001507.650815)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
	protocol-violation{{tx-dominant-bit-error}{}}
	bus-error
 (0000001507.704210)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (0000001507.754822)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
	controller-problem{tx-error-passive}
 (0000001507.760002)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
	protocol-violation{{tx-dominant-bit-error}{}}
	bus-error
 (0000001507.770560)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
	controller-problem{back-to-error-active}
 (0000001507.775722)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
	protocol-violation{{tx-dominant-bit-error}{}}
	bus-error
 (0000001507.823008)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
	restarted-after-bus-off
 (0000001507.879691)  can0  027   [5]  A8 DD C3 6F 1C
 (0000001507.928220)  can0  028   [1]  2C
 (0000001508.028763)  can0  029   [8]  CD AC 0E 37 56 9A 2F 49

Andri Yngvason (5):
  can: dev: Consolidate and unify state change handling.
  can: sja1000: Consolidate and unify state change handling.
  can: mscan: Consolidate and unify state change handling.
  can: flexcan: Consolidate and unify state change handling.
  can: move can_stats.bus_off++ from can_bus_off into can_change_state

 drivers/net/can/bfin_can.c                  |   1 +
 drivers/net/can/c_can/c_can.c               |   1 +
 drivers/net/can/cc770/cc770.c               |   1 +
 drivers/net/can/dev.c                       |  81 +++++++++++++++++++++-
 drivers/net/can/flexcan.c                   | 101 +++++-----------------------
 drivers/net/can/m_can/m_can.c               |   1 +
 drivers/net/can/mscan/mscan.c               |  48 ++++---------
 drivers/net/can/pch_can.c                   |   1 +
 drivers/net/can/rcar_can.c                  |   1 +
 drivers/net/can/sja1000/sja1000.c           |  51 +++++++-------
 drivers/net/can/softing/softing_main.c      |   1 +
 drivers/net/can/spi/mcp251x.c               |   1 +
 drivers/net/can/ti_hecc.c                   |   1 +
 drivers/net/can/usb/ems_usb.c               |   1 +
 drivers/net/can/usb/esd_usb2.c              |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb.c     |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |   1 +
 drivers/net/can/usb/usb_8dev.c              |   1 +
 include/linux/can/dev.h                     |   3 +
 include/uapi/linux/can/error.h              |   1 +
 20 files changed, 153 insertions(+), 146 deletions(-)

-- 
1.9.1

