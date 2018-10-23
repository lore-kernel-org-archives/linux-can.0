From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 0/2] can: flexcan: Add CAN self wakeup support
Date: Tue, 23 Oct 2018 05:17:02 +0000
Message-ID: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN
controller can parse stop-mode property from device tree to enable self
wakeup feature.

Dong Aisheng (2):
  can: flexcan: Add self wakeup support
  Documentation: can: flexcan: Add stop-mode property to device tree

 .../bindings/net/can/fsl-flexcan.txt          |   8 +
 drivers/net/can/flexcan.c                     | 141 ++++++++++++++++--
 2 files changed, 140 insertions(+), 9 deletions(-)

--=20
2.17.1
