From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
Date: Tue, 14 Jan 2020 13:21:02 +0100
Message-ID: <58d0a872-9f9e-ab64-b9e4-d6548b05142b@xs4all.nl>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 1/10/20 5:17 PM, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/atmel-isi.txt b/Documentation/devicetree/bindings/media/atmel-isi.txt
> index 332513a151cc..8924c7545b63 100644
> --- a/Documentation/devicetree/bindings/media/atmel-isi.txt
> +++ b/Documentation/devicetree/bindings/media/atmel-isi.txt
> @@ -2,7 +2,7 @@ Atmel Image Sensor Interface (ISI)
>  ----------------------------------
>  
>  Required properties for ISI:
> -- compatible: must be "atmel,at91sam9g45-isi".
> +- compatible: must be "atmel,at91sam9g45-isi" or "microchip,sam9x60-isi".
>  - reg: physical base address and length of the registers set for the device.
>  - interrupts: should contain IRQ line for the ISI.
>  - clocks: list of clock specifiers, corresponding to entries in the clock-names
> 

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans
