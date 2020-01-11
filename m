From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 06/17] dt-bindings: at91-sama5d2_adc: add
 microchip,sam9x60-adc
Date: Sat, 11 Jan 2020 10:16:38 +0000
Message-ID: <20200111101638.7920f26c@archlinux>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
        <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-media-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-ca
List-Id: linux-can.vger.kernel.org

On Fri, 10 Jan 2020 18:17:58 +0200
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add microchip,sam9x60-adc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm assuming this lot of binding changes will all go via Rob.
Let me know if you are expecting it to go via the various
individual trees.

Thanks,

Jonathan


> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 4a3c1d496e1a..07c59f301b31 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -1,7 +1,7 @@
>  * AT91 SAMA5D2 Analog to Digital Converter (ADC)
>  
>  Required properties:
> -  - compatible: Should be "atmel,sama5d2-adc".
> +  - compatible: Should be "atmel,sama5d2-adc" or "microchip,sam9x60-adc".
>    - reg: Should contain ADC registers location and length.
>    - interrupts: Should contain the IRQ line for the ADC.
>    - clocks: phandle to device clock.
