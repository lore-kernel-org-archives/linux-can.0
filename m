From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional
 gpio
Date: Fri, 6 Dec 2019 14:49:41 +0100
Message-ID: <f9b0e2ad-1d62-2c5a-fdce-c03205c2a9f7@geanix.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204175112.7308-1-dmurphy@ti.com>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-can.vger.kernel.org



On 04/12/2019 18.51, Dan Murphy wrote:
> The wake-up of the device can be configured as an optional
> feature of the device.  Move the wake-up gpio from a requried
> property to an optional property.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Rob Herring <robh@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index 27e1b4cebfbd..7cf5ef7acba4 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -10,7 +10,6 @@ Required properties:
>   	- #size-cells: 0
>   	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
>   			     operate at should be less than or equal to 18 MHz.
> -	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>   	- interrupt-parent: the phandle to the interrupt controller which provides
>                       the interrupt.
>   	- interrupts: interrupt specification for data-ready.
> @@ -23,6 +22,7 @@ Optional properties:
>   		       reset.
>   	- device-state-gpios: Input GPIO that indicates if the device is in
>   			      a sleep state or if the device is active.
> +	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
>   
>   Example:
>   tcan4x5x: tcan4x5x@0 {
> 
