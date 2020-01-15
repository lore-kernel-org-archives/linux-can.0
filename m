From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Date: Wed, 15 Jan 2020 09:43:00 +0100
Message-ID: <20200115084300.GU3137@piout.net>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
 <20200114095538.GJ3137@piout.net>
 <20200115080053.GC325@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200115080053.GC325@dell>
Sender: linux-media-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 15/01/2020 08:00:53+0000, Lee Jones wrote:
> On Tue, 14 Jan 2020, Alexandre Belloni wrote:
> 
> > On 10/01/2020 18:18:02+0200, Claudiu Beznea wrote:
> > > Add microchip,sam9x60-smc to DT bindings documentation.
> > > 
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > Applied, thanks.
> 
> Remind me why you are applying this patch please?
> 

Because the last patch of the series has a soft dependency on this
patch. I can remove it from the at91 and let you apply it if you think
this is necessary.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
