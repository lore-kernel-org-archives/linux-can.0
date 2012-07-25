From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 3/4] arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on
 AM335x-EVM
Date: Wed, 25 Jul 2012 06:36:10 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA02FA1@DBDE01.ent.ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
 <1343197417-27481-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54720 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272Ab2GYGgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 02:36:41 -0400
In-Reply-To: <1343197417-27481-4-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

+Tony

On Wed, Jul 25, 2012 at 11:53:36, AnilKumar, Chimata wrote:
> Add D_CAN1 pinctrl node to am3358_pinmux master node to export
> D_CAN functionality on AM335x EVM according to pinctrl-single
> driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index e4e1ccb..7f0fd6c 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -46,3 +46,16 @@
>  	regulator-boot-on;
>  	regulator-always-on;
>  };
> +
> +&am3358_pinmux {
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&d_can1_pins>;
> +
> +	d_can1_pins: pinmux_d_can_pins {
> +		pinctrl-single,pins = <
> +			0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
> +			0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
> +		>;
> +	};
> +};
> -- 
> 1.7.9.5
> 
> 

