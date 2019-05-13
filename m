From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 0/2] arm64: dts: fsl: add flexcan nodes in layerscape SOCs
Date: Mon, 13 May 2019 06:02:45 +0000
Message-ID: <20190513112612.11036-1-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>, Varun Sethi <V.Sethi@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

NXP Layerscape SOCs LX2160A and LS1028A both contain flexcan node capable
of FD mode.

Cc: Varun Sethi <V.Sethi@nxp.com>

Dependencies:
 - https://www.spinics.net/lists/linux-can/msg01562.html

Pankaj Bansal (2):
  arm64: dts: fsl: lx2160a: add flexcan node
  arm64: dts: fsl: ls1028a: add flexcan node

 .../boot/dts/freescale/fsl-ls1028a-qds.dts    | 10 ++++++++-
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 18 ++++++++++++++-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 22 ++++++++++++++++++-
 .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 10 ++++++++-
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 18 ++++++++++++++-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 20 ++++++++++++++++-
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.17.1
