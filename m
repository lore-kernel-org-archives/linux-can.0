From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 0/1] can: flexcan: Add CAN self wakeup support
Date: Mon, 12 Nov 2018 01:53:00 +0000
Message-ID: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN controlle=
r
can parse stop mode property from device tree to enable self wakeup feature=
.

There is a issue in V2 is that the system can be wakeuped only when system
is totally suspend, V3 has fixed this issue.

ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V3:
	*add FLEXCAN_QUIRK_SETUP_STOP_MODE quirk.
	*rename function.
	*fix system can't be wakeuped during suspend.

Dong Aisheng (1):
  can: flexcan: Add self wakeup support

 drivers/net/can/flexcan.c | 175 +++++++++++++++++++++++++++++++++++---
 1 file changed, 163 insertions(+), 12 deletions(-)

--=20
2.17.1
