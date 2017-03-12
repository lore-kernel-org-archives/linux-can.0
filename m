From: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: sunxi: Add CAN node and can0_pins_a pinctrl setting
Date: Sun, 12 Mar 2017 14:28:09 +0100
Message-ID: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
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

I have tested the patch on a Banana Pi (A20 SoC) with mainline kernel 4.9.13.

Patrick Menschel (2):
  ARM: dts: sun4i: Add CAN node and can0_pins_a pinctrl settings
  ARM: dts: sun7i: Add CAN node and can0_pins_a pinctrl settings

 arch/arm/boot/dts/sun4i-a10.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
