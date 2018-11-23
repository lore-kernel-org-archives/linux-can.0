From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V6 0/2] can: flexcan: add can self wakeup support
Date: Fri, 23 Nov 2018 08:35:25 +0000
Message-ID: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN controlle=
r
can parse "fsl,stop-mode" property from device tree to enable self wakeup f=
eature.

Aisheng Dong (2):
  Documentation: can: flexcan: add stop mode property to device tree
  can: flexcan: add self wakeup support

 .../bindings/net/can/fsl-flexcan.txt          |   8 +
 drivers/net/can/flexcan.c                     | 172 +++++++++++++++++-
 2 files changed, 171 insertions(+), 9 deletions(-)

--=20
2.17.1
