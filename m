From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 07/11] arm64: dts: renesas: cat875: Add ethernet support
Date: Thu, 17 Jan 2019 12:59:46 +0100
Message-ID: <20190117115945.bmlaoeoqvsmdqqot@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-8-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547663874-29411-8-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.>
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:50PM +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> This patch adds ethernet support to the sub board.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/cat875.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
> index a41d0d8..805ffa7 100644
> --- a/arch/arm64/boot/dts/renesas/cat875.dtsi
> +++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
> @@ -7,4 +7,34 @@
>  
>  / {
>  	model = "Silicon Linux sub board for CAT874 (CAT875)";
> +
> +	aliases {
> +		ethernet0 = &avb;
> +	};
> +};
> +
> +&avb {
> +	pinctrl-0 = <&avb_pins>;
> +	pinctrl-names = "default";
> +	renesas,no-ether-link;

Is the renesas,no-ether-link required?

My understanding is that "the property should only be used when a
board does not provide a proper AVB_LINK signal". And from my reading
of the schematic it looks like that signal may be provided on this board.

That said, I have an outstanding patch for this for E3/Ebisu which
I have not applied because I am unsure of its correctness.

[PATCH] arm64: dts: renesas: ebisu: Remove renesas, no-ether-link property
https://patchwork.kernel.org/patch/10692755/

Similar patches have been applied for other boards.
f.e:

[PATCH] arm64: dts: renesas: salvator-x: Remove renesas, no-ether-link property
https://git.kernel.org/torvalds/c/87c059e9c39d

> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +
> +	phy0: ethernet-phy@0 {
> +		rxc-skew-ps = <1500>;
> +		reg = <0>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pfc {
> +	avb_pins: avb {
> +		mux {
> +			groups = "avb_mii";
> +			function = "avb";
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
