From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Subject: [PATCH 0/2] D_CAN RX buffer size improvements
Date: Fri, 8 Feb 2019 13:31:00 +0000
Message-ID: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Patrick Zysset <Patrick.Zysset@netmodule.com>
List-Id: linux-can.vger.kernel.org

Re-sending entire patchset due to missed cover letter, sorry.

This patchset introduces support for 64 D_CAN message objects with an optio=
n of
unequal split between RX/TX.

The rationale behind this is that there are lots of frame loss on higher bu=
s
speeds. Below are test results from my custom Sitara AM3352 based board:

  Sender: timeout 15m cangen can0 -g 0 -i x
  Target: candump can0,0~0,#FFFFFFFF -td -c -d -e

  * Without patches:
    - 15 minute RX test, 500kbps
    - 16 RX / 16 TX message objects
    - 77 received frames lost out of 4649415

  * With patches applied:
    - 15 hours RX test, 500kbps
    - 56 RX / 8 TX message objects
    - 41 received frames lost out of 279303376

Please note, I do not have ability to test pure C_CAN, so it is left untest=
ed.

---

Andrejs Cainikovs (2):
  can: c_can: support 64 message objects for D_CAN
  can: c_can: configurable amount of D_CAN RX objects

 drivers/net/can/c_can/Kconfig | 20 ++++++++++
 drivers/net/can/c_can/c_can.c | 93 +++++++++++++++++++++++++++------------=
----
 drivers/net/can/c_can/c_can.h | 20 +++++++---
 3 files changed, 94 insertions(+), 39 deletions(-)

---
2.11.0
