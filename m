From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 0/6] can: flexcan: fixes for stop mode
Date: Wed, 4 Dec 2019 11:36:03 +0000
Message-ID: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Hi Marc,

   I removed the patch (can: flexcan: try to exit stop mode during probe st=
age)
out of this patch set for now. This patch should further discuss with Sean =
and
I will prepare it according to final conclusion. Thanks.

Regards,
Joakim Zhang

Joakim Zhang (5):
  can: flexcan: Ack wakeup interrupt separately
  can: flexcan: add low power enter/exit acknowledgment helper
  can: flexcan: change the way of stop mode acknowledgment
  can: flexcan: propagate error value of flexcan_chip_stop()
  can: flexcan: add LPSR mode support

Sean Nyekjaer (1):
  can: flexcan: fix deadlock when using self wakeup

 drivers/net/can/flexcan.c | 131 +++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 52 deletions(-)

--=20
2.17.1
