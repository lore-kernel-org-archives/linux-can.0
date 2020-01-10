From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 13/16] dt-bindings: atmel-usart: add microchip,<chip>-usart
Date: Fri, 10 Jan 2020 15:31:30 +0100
Message-ID: <20200110143130.GF1027187@piout.net>
References: <1578488123-26127-1-git-send-email-claudiu.beznea@microchip.com>
 <1578488123-26127-14-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1578488123-26127-14-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, vigneshr@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, pmeerw@pmeerw.net, miquel.raynal@bootlin.com, lee.jones@linaro.org, linux-rtc@vger.kernel.org, lars@metafoo.de, richard@nod.at, ludovic.desroches@microchip.com, wg@grandegger.com, linux-media@vger.kernel.org, devicetree@vger.kernel.org, tudor.ambarus@microchip.com, radu_nicolae.pirea@upb.ro, linux-can@vger.kernel.org, robh+dt@kernel.org, mkl@pengutronix.de, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it, richard.genoud@gmail.com, netdev@vger.kernel.org, nicolas.ferre@microchip.com, linux-spi@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, knaack.h@gmx.de, dmaengine@vger.kernel.org, eugen.hristev@microchip.com, jic23@kernel.org
List-Id: linux-can.vger.kernel.org

On 08/01/2020 14:55:20+0200, Claudiu Beznea wrote:
> Add microchip,<chip>-usart to DT bindings documentation. This is for
> microchip,sam9x60-usart.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 699fd3c9ace8..e5c7331abe09 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -1,10 +1,12 @@
>  * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>  
>  Required properties for USART:
> -- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
> +- compatible: Should be "atmel,<chip>-usart", "microchip,<chip>-usart" or
> +  "atmel,<chip>-dbgu".
>    The compatible <chip> indicated will be the first SoC to support an
>    additional mode or an USART new feature.
> -  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> +  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart",
> +  "microchip,<chip>-usart".

The wildcard here should be eliminated because all the combinations are
not allowed. This would also make it clearer that this change is to
introduce a new IP instead of renamed atmel to microchip.

>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
