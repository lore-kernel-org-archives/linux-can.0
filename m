From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/2] can: flexcan: add PE clock source select support
Date: Thu, 13 Dec 2018 07:07:53 +0000
Message-ID: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

The patch set intends to add support for PE clock source select. The
FlexCAN controller can parse "fsl,clk-source" property from device tree
to select clock source.

Dong Aisheng (2):
  Documentation: can: flexcan: add PE clock source property to device
    tree
  can: flexcan: add support for PE clock source select

 .../bindings/net/can/fsl-flexcan.txt           |  8 ++++++++
 drivers/net/can/flexcan.c                      | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

--=20
2.17.1
