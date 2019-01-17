From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 06/11] arm64: dts: renesas: r8a774c0-cat874: Add uSD
 support
Date: Thu, 17 Jan 2019 12:11:47 +0100
Message-ID: <20190117111147.vb3lkdmgx24zusjx@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-7-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547663874-29411-7-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.>
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:49PM +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> This patch adds uSD card support.

Can I confirm that SDHI0 is wired up to a uSD slot?

I ask because if that is the case then this patch looks good to me.
But if it is wired up to a full-size SD slot then I believe
a wp-gpio (write protect) should be described.

> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 50 +++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> index c545ce5..477a56b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> @@ -7,6 +7,7 @@
>  
>  /dts-v1/;
>  #include "r8a774c0.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Silicon Linux RZ/G2E 96board platform (CAT874)";
> @@ -26,6 +27,29 @@
>  		/* first 128MB is reserved for secure area. */
>  		reg = <0x0 0x48000000 0x0 0x78000000>;
>  	};
> +
> +	vcc_sdhi0: regulator-vcc-sdhi0 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "SDHI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vccq_sdhi0: regulator-vccq-sdhi0 {
> +		compatible = "regulator-gpio";
> +
> +		regulator-name = "SDHI0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1
> +			  1800000 0>;
> +	};
>  };
>  
>  &extal_clk {
> @@ -37,6 +61,18 @@
>  		groups = "scif2_data_a";
>  		function = "scif2";
>  	};
> +
> +	sdhi0_pins: sd0 {
> +		groups = "sdhi0_data4", "sdhi0_ctrl";
> +		function = "sdhi0";
> +		power-source = <3300>;
> +	};
> +
> +	sdhi0_pins_uhs: sd0_uhs {
> +		groups = "sdhi0_data4", "sdhi0_ctrl";
> +		function = "sdhi0";
> +		power-source = <1800>;
> +	};
>  };
>  
>  &scif2 {
> @@ -45,3 +81,17 @@
>  
>  	status = "okay";
>  };
> +
> +&sdhi0 {
> +	pinctrl-0 = <&sdhi0_pins>;
> +	pinctrl-1 = <&sdhi0_pins_uhs>;
> +	pinctrl-names = "default", "state_uhs";
> +
> +	vmmc-supply = <&vcc_sdhi0>;
> +	vqmmc-supply = <&vccq_sdhi0>;
> +	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 
