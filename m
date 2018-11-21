From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4 0/1] can: flexcan: add self wakeup support
Date: Wed, 21 Nov 2018 12:32:05 +0000
Message-ID: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch intends to add CAN self wakeup support. The CAN controller can
parse stop mode property from device tree to enable self wakeup feature.

ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V3:
	*add FLEXCAN_QUIRK_SETUP_STOP_MODE quirk.
	*rename function.
	*fix system can't be wakeuped during suspend.
V3->V4:
	*normalize the code following Aisheng Dong's comments.

Aisheng Dong (1):
  can: flexcan: add self wakeup support

 drivers/net/can/flexcan.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 154 insertions(+), 9 deletions(-)

--=20
2.17.1
