From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 0/5] can: flexcan: add CAN FD support on i.MX8QM
Date: Wed, 6 Mar 2019 10:00:50 +0000
Message-ID: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Hi Marc,

This patch set integrates two patch sets which have been sent before.
[PATCH 0/3] can: flexcan: add imx8qm support
[PATCH 0/2] can: flexcan: add CANFD BRS and ISO FD support

I rebase it that will easy your patch review.

Thanks a lot.

Joakim Zhang.

Dong Aisheng (4):
  can: rx-offload: add CANFD support based on offload
  can: flexcan: add CAN FD mode support
  can: flexcan: add CANFD BRS support and improve bittiming setting
  can: flexcan: add imx8qm support

Joakim Zhang (1):
  can: flexcan: add ISO CAN FD feature support

 drivers/net/can/flexcan.c      | 226 ++++++++++++++++++++++++++++-----
 drivers/net/can/rx-offload.c   |  16 ++-
 include/linux/can/rx-offload.h |   4 +-
 3 files changed, 210 insertions(+), 36 deletions(-)

--=20
2.17.1
