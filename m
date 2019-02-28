From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/2] can: flexcan: add CANFD BRS and ISO FD support
Date: Thu, 28 Feb 2019 06:57:11 +0000
Message-ID: <20190228065506.3488-1-qiangqing.zhang@nxp.com>
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

This patch set intends to enable CANFD bitrate switch and ISO FD mode
support.

You may need to firstly review the patch set([PATCH 0/3] can: flexcan:
add imx8qm support).

I noticed that you have been reviewing my patches recetnly, please feel
free to let me know if you want me to rebase the patch about CANFD and
that may easy your patch review.

Thanks a lot.

Joakim Zhang.

Dong Aisheng (1):
  can: flexcan: add CANFD BRS support and improve bittiming setting

Joakim Zhang (1):
  can: flexcan: add ISO CAN FD feature support

 drivers/net/can/flexcan.c | 116 ++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 22 deletions(-)

--=20
2.17.1
