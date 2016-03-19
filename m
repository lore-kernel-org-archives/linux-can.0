From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
Date: Sat, 19 Mar 2016 13:33:41 +0100
Message-ID: <56ED4725.8080209@pengutronix.de>
References: <55F3E7A0.9020309@posteo.de> <55F3ECAC.7040508@pengutronix.de>
 <56ED45C9.7080803@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39452 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980AbcCSMfu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Mar 2016 08:35:50 -0400
In-Reply-To: <56ED45C9.7080803@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>

On 03/19/2016 01:27 PM, Patrick Menschel wrote:
> you mentioned that you have a running Bpi with mainline kernel.
> 
> My question would be if you're also running mainline u-boot with device
> tree bindings.

I'm running a u-boot, not sure which version.

> I'm now running mainline kernel from stable branch
> compiled with sunxi_defconfig thus CAN driver is built-in and mainline
> u-boot according to
> 
> http://linux-sunxi.org/Mainline_Kernel_Howto
> http://linux-sunxi.org/Mainline_U-boot
> .
> 
> I've added can0 entries manually to
> 
> arch/arm/boot/dts/sun7i-a20.dtsi
> arch/arm/boot/dts/sun7i-a20-bananapi.dts
> 
> since they are missing in the stable branch.
> 
> Compiling to dtb and back to dts now resolves to
> 
> 		can@01c2bc00 {
> 			compatible = "allwinner,sun4i-a10-can";
> 			reg = <0x1c2bc00 0x400>;
> 			interrupts = <0x0 0x1a 0x4>;
> 			clocks = <0x31 0x4>;
> 			status = "okay";
> 			pinctrl-names = "default";
> 			pinctrl-0 = <0x32>;
> 		};
> 
> That does look plausible from my perspective.
> 
> Unfortunately I'm still missing /dev/can0 and have no clue why.

CAN devices are network devices and will not show up in "/dev". Have a
look at:

    ifconfig -a

> If your Bpi works with legacy u-boot, I would try that next.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
