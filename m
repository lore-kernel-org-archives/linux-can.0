From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PATCH v4 0/6] ARM: dts: sunxi: Add CAN node and can0_pins_a pinctrl settings
Date: Tue,  4 Apr 2017 20:36:26 +0200
Message-ID: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc: Patrick Menschel <menschel.p@posteo.de>
List-Id: linux-can.vger.kernel.org

The Allwinner A10/A20 SoCs have an on-board CAN (Controller Area Network)
controller. This patch adds the CAN core to the SoC's include files,
sun4i-a10.dtsi and sun7i-a20.dtsi.

On linux-can mailing list was a discussion about updating the device tree bindings
https://lkml.org/lkml/2015/9/17/220
but it did not progress past writing the documentation file.
Documentation/devicetree/bindings/net/can/sun4i_can.txt

The CAN controller can be enabled in a board specific dts file as
described in the documentation file or by using a device tree overlay.

I have tested the patch on a Banana Pi (A20 SoC) with mainline kernel 4.10.5.

History:
    v4: fixed style problems,
        changed device node position of ps20 and ps21 to fix ordering
        by rising physical address

    v3: added "allwinner,sun7i-a20-can" compatible to can0 device node contents,
        make separate patches for device nodes and pinctrl settings

    v2: changed can0_pins_a node contents to new generic binding method, 
	changed can0_pins_a node position by alphabetical order,
        changed can0 device node position by rising physical address order

    v1: initial

Patrick Menschel (6):
  ARM: dts: sun4i: fix device node ordering
  ARM: dts: sun4i: Add CAN node
  ARM: dts: sun4i: Add can0_pins_a pinctrl settings
  ARM: dts: sun7i: fix device node ordering
  ARM: dts: sun7i: Add CAN node
  ARM: dts: sun7i: Add can0_pins_a pinctrl settings

 arch/arm/boot/dts/sun4i-a10.dtsi | 38 ++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.7.4
