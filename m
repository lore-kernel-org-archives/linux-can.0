From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
Date: Fri, 12 Jul 2019 08:02:35 +0000
Message-ID: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Hi Marc,

This patch set intends to add support for NXP Flexcan CAN FD, it has
been validated on three NXP platform(i.MX8QM/QXP, S32V234, LX2160AR1).
After discussed with another two Fexcan owner, we sorted out this
version.

I hope you can pick up the patch set as it can fully meet requirement of
above three platform. And after that, we can start to do upstream about
CAN FD.

Thanks a lot!

BRs,
Joakim Zhang

Joakim Zhang (8):
  can: flexcan: allocate skb in flexcan_mailbox_read
  can: flexcan: use struct canfd_frame for CAN classic frame
  can: flexcan: add CAN FD mode support
  can: flexcan: add CANFD BRS support
  can: flexcan: add ISO CAN FD feature support
  can: flexcan: add Transceiver Delay Compensation suopport
  can: flexcan: add imx8qm support
  can: flexcan: add lx2160ar1 support

 drivers/net/can/flexcan.c      | 340 ++++++++++++++++++++++++++++-----
 drivers/net/can/rx-offload.c   |  33 +---
 include/linux/can/rx-offload.h |   5 +-
 3 files changed, 305 insertions(+), 73 deletions(-)

--=20
2.17.1
