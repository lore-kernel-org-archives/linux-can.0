From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v4 0/6] Remodel FlexCAN register r/w APIs for big endian
Date: Fri, 24 Nov 2017 18:52:07 +0530
Message-ID: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:30528
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752058AbdKXNSf (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 24 Nov 2017 08:18:35 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>

This patch series remodels the FlexCAN register r/w APIs for big endian.
The endianness is checked based on optional big-endian property in
device tree. if this property is not present in device tree node then 
controller is assumed to be little endian. if this property is present then
controller is assumed to be big endian.

An exception to this rule is powerpc P1010RDB, which is always
big-endian, even if big-endian is not present in dts. This is
checked using p1010-flexcan compatible in dts.

Therefore, remove p1010-flexcan compatible from imx series dts,
as their flexcan core is little endian.

Finally this series adds support for NXP LS1021A SOC in flexcan,
which is arm based SOC having big-endian FlexCAN controller.

Pankaj Bansal (6):
  can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCAN
    controllers.
  can: flexcan: adding platform specific details for LS1021A
  Documentation : can : flexcan : Add big-endian property to device tree
  powerpc: dts: P1010: Add endianness property to flexcan node
  arm: dts: Remove p1010-flexcan compatible from imx series dts
  arm/dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC

 .../bindings/net/can/fsl-flexcan.txt         |   6 +
 arch/arm/boot/dts/imx25.dtsi                 |   4 +-
 arch/arm/boot/dts/imx28.dtsi                 |   4 +-
 arch/arm/boot/dts/imx35.dtsi                 |   4 +-
 arch/arm/boot/dts/imx53.dtsi                 |   4 +-
 arch/arm/boot/dts/ls1021a-qds.dts            |  16 ++
 arch/arm/boot/dts/ls1021a-twr.dts            |  16 ++
 arch/arm/boot/dts/ls1021a.dtsi               |  36 +++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi  |   2 +
 drivers/net/can/flexcan.c                    | 241 ++++++++++-------
 10 files changed, 223 insertions(+), 110 deletions(-)

-- 
2.7.4

