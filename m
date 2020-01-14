From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 13/17] dt-bindings: atmel-usart: remove wildcard
Date: Mon, 13 Jan 2020 18:24:15 -0600
Message-ID: <20200114002415.GA18336@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, alexandre.belloni@bootlin.com, vigneshr@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, pmeerw@pmeerw.net, miquel.raynal@bootlin.com, lee.jones@linaro.org, linux-rtc@vger.kernel.org, lars@metafoo.de, richard@nod.at, ludovic.desroches@microchip.com, wg@grandegger.com, linux-media@vger.kernel.org, devicetree@vger.kernel.org, tudor.ambarus@microchip.com, radu_nicolae.pirea@upb.ro, linux-can@vger.kernel.org, mkl@pengutronix.de, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it, richard.genoud@gmail.com, linux-spi@vger.kernel.org, vkoul@kernel.org, knaack.h@gmx.de, dmaengine@vger.kernel.org, eugen.hristev@microchip.com, jic23@kernel.org
List-Id: linux-can.vger.kernel.org

On Fri, Jan 10, 2020 at 06:18:05PM +0200, Claudiu Beznea wrote:
> Remove chip whildcard and introduce the list of compatibles instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 699fd3c9ace8..09013c49f6cc 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -1,10 +1,11 @@
>  * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>  
>  Required properties for USART:
> -- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
> -  The compatible <chip> indicated will be the first SoC to support an
> -  additional mode or an USART new feature.
> -  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> +- compatible: Should be one of the following:
> +	- "atmel,at91rm9200-usart"
> +	- "atmel,at91sam9260-usart"
> +	- "atmel,at91rm9200-dbgu"
> +	- "atmel,at91sam9260-dbgu"

Should be:

"atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
"atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"

>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
> -- 
> 2.7.4
> 
