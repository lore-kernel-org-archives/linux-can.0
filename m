From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 0/4] can: flexcan: fixes for stop mode
Date: Wed, 27 Nov 2019 05:56:42 +0000
Message-ID: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Hi Sean,
	Could you help check the patch set? With your suggestions, I
have cooked a patch to exit stop mode during probe stage.

	IMHO, I think this patch is unneed, now in flexcan driver,
enter stop mode when suspend, and then exit stop mode when resume.
AFAIK, as long as flexcan_suspend has been called, flexcan_resume will
be called, unless the system hang during suspend/resume. If so, only
code reset can activate OS again. Could you please tell me how does CAN
stucked in stop mode at your side?

	If indeed need, Why not check it in flexcan_open? Once we find
CAN is stuckd in stop mode, users can down->up CAN interface to get out of
stop mode. I think this could be more reasonable.

Joakim Zhang

Joakim Zhang (3):
  can: flexcan: try to exit stop mode during probe stage
  can: flexcan: change the way of stop mode acknowledgment
  can: flexcan: add LPSR mode support

Sean Nyekjaer (1):
  can: flexcan: fix deadlock when using self wakeup

 drivers/net/can/flexcan.c | 132 +++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 52 deletions(-)

--=20
2.17.1
