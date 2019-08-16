From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH REPOST 0/2] can: flexcan: fix PM and wakeup issue
Date: Fri, 16 Aug 2019 08:20:38 +0000
Message-ID: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch set intends to fix Flecan PM and wakeup issue.

Joakim Zhang (2):
  can: flexcan: fix deadlock when using self wakeup
  can: flexcan: add LPSR mode support for i.MX7D

 drivers/net/can/flexcan.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--=20
2.17.1
