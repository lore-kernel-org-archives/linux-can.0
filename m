From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
Date: Wed, 26 Sep 2018 12:40:23 -0500
Message-ID: <519a93e7-5177-8144-129a-7a4cbb1a108d@ti.com>
References: <20180910201241.24092-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910201241.24092-1-dmurphy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

bump

On 09/10/2018 03:12 PM, Dan Murphy wrote:
> DT binding documentation for TI TCAN4x5x driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> new file mode 100644
> index 000000000000..3eea2f2bb8a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -0,0 +1,33 @@
> +Texas Instruments TCAN4x5x CAN Controller
> +================================================
> +
> +This file provides device node information for the TCAN4x5x interface contains.
> +
> +Required properties:
> +	- compatible: "ti,tcan4x5x"
> +	- reg: 0
> +	- #address-cells : 1
> +	- #size-cells : 0
> +	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
> +			     operate at should be less than or equal to 18 MHz.
> +	- data-ready-gpios: Interrupt GPIO for data and error reporting. 
> +	- wake-up-gpios: Wake up GPIO to wake up the TCAN device
> +
> +Optional properties:
> +	- clocks: Processor clock phandles (see clock bindings for details)
> +		  If no clock is defined then the default 40MHz freq is set.
> +	- reset-gpios: Hardwired output GPIO. If not defined then software
> +		       reset.
> +
> +Example:
> +tcan4x5x: tcan4x5x@0 {
> +		compatible = "ti,tcan4x5x";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&tclkin_ck>;
> +		spi-max-frequency = <10000000>;
> +		data-ready-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +		wake-up-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
> +	};
> 


-- 
------------------
Dan Murphy
