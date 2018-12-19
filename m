From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/3] can: flexcan: add imx8qm support
Date: Wed, 19 Dec 2018 08:38:57 +0000
Message-ID: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This patch set intends to add Flexcan support for i.MX8QM platform which
defaultly supports CAN FD protocol. Although BRS enabled by system reset
when the driver sets CAN FD mode, now this patch serial does not support
BRS in the driver. And then I will send patch to enable BRS by changing the
register to set bit timing.

Dong Aisheng (3):
  can: rx-offload: add CANFD support based on offload
  can: flexcan: add CAN FD mode support
  can: flexcan: add imx8qm support

 drivers/net/can/flexcan.c      | 114 ++++++++++++++++++++++++++++++---
 drivers/net/can/rx-offload.c   |  16 +++--
 include/linux/can/rx-offload.h |   4 +-
 3 files changed, 117 insertions(+), 17 deletions(-)

--=20
2.17.1
