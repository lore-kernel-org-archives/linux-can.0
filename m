From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree
 bindings
Date: Sun, 26 Nov 2017 16:28:09 -0600
Message-ID: <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <20171124183509.12810-2-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171124183509.12810-2-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Fri, Nov 24, 2017 at 06:35:08PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Add device-tree bindings for Microcip CanFD Controller mcp2517fd

s/Microcip/Microchip/

> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  .../bindings/net/can/microchip,mcp2517fd.txt       | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
> new file mode 100644
> index 000000000000..96cbf0c96895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
> @@ -0,0 +1,47 @@
> +* Microchip MCP2517 stand-alone CAN controller device tree bindings
> +
> +Required properties:
> + - compatible: Should be one of the following:
> +   - "microchip,mcp2517fd" for MCP2517fd.
> + - reg: SPI chip select.
> + - clocks: The clock feeding the CAN controller.
> + - interrupt-parent: The parent interrupt controller.
> + - interrupts: Should contain IRQ line for the CAN controller.
> +
> +Optional properties:
> + - vdd-supply: Regulator that powers the CAN controller.
> + - xceiver-supply: Regulator that powers the CAN transceiver.
> + - microchip,clock_out_div = <0|1|2|4|10>: Clock output pin divider

s/_/-/

And on the rest. Don't use underscores...

> +					   0 = Start of Frame output
> +					   default: 10
> + - microchip,clock_div = <1|2>: internal clock divider - default 1
> + - microchip,gpio_opendrain: gpio (int0,1) in open drain mode
> +			     instead of default push/pull
> + - microchip,int_opendrain: int pin in open drain mode
> +			    instead of default push/pull

IIRC, we have a standard property for this.

> + - microchip,txcan_opendrain: txcan pin in open drain mode
> +			      instead of default push/pull
> + - microchip,gpio0_mode : gpio mode functionality
> +			  0 = input
> +			  1 = TX interrupt output - default
> +			  2 = output default low
> +			  3 = output default high
> +			  4 = (tx) transceiver standby
> + - microchip,gpio1_mode : gpio mode functionality
> +			  0 = input - default
> +			  1 = RX interrupt output - default
> +			  2 = output default low
> +			  3 = output default high
> +
> +Example:
> +	can0: can@1 {
> +		compatible = "microchip,mcp2515";
> +		reg = <1>;
> +		clocks = <&clk24m>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <13 0x8>;
> +		vdd-supply = <&reg5v0>;
> +		xceiver-supply = <&reg5v0>;
> +		microchip,gpio0_mode = <4>;
> +		microchip,gpio0_mode = <1>;
> +	};
> -- 
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
