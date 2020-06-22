From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Mon, 22 Jun 2020 15:26:08 +0200
Message-ID: <20200622132608.GD3077@x1.vandijck-laurijssen.be>
References: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
 <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
 <20200618123055.GA17496@x1.vandijck-laurijssen.be>
 <c8267280-e7a9-8171-d714-fa392ccb5537@pengutronix.de>
 <20200622102559.GA3077@x1.vandijck-laurijssen.be>
 <c5fc46c1-abaf-cf67-abb6-0077bafdff3a@pengutronix.de>
 <20200622123031.GB3077@x1.vandijck-laurijssen.be>
 <20200622124347.GC3077@x1.vandijck-laurijssen.be>
 <0ae54858-0eb5-b3b8-c793-00a8b99c8aa5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ae54858-0eb5-b3b8-c793-00a8b99c8aa5@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On ma, 22 jun 2020 14:54:15 +0200, Marc Kleine-Budde wrote:
> On 6/22/20 2:43 PM, Kurt Van Dijck wrote:
> > I get RX-0: FIFO overflows in listen-only mode (back-to-back burst of
> > the single other node).
> 
> Single other node? Who's ACKing the CAN frames?

hence the back-to-back burst.

> 
> > The SPI peripheral does not use DMA :-(.
> 
> The SPI messages are quite small, so DMA wont help either. Getting rid of the
> IRQ and polling for completion is the way to go.
> 
> > Do you have, by accident, some freescale SPI fixes lying around?
> 
> nope
> 
> > It's not the biggest problem on my side, but is proves the system not
> > being guarded against load.
> 
> Do you have freq scaling activated?

Not yet.

The device tree needs upgrading ... grrr

> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
