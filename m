From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Date: Sat, 27 Jun 2020 21:56:05 +0200
Message-ID: <20200627195605.GC30275@x1.vandijck-laurijssen.be>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:40866 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0T4M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 27 Jun 2020 15:56:12 -0400
Content-Disposition: inline
In-Reply-To: <20200626133243.GA8333@Mani-XPS-13-9360>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On vr, 26 jun 2020 19:02:43 +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
> > This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
> > 
> > Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Could you please split this patch into multiple ones? Having ~4k lines for a
> patch makes it difficult to review. I know that some parts are difficult to
> split (happened with my series as well) but anything below 1k should be fine.

IMHO, there is a huge difference between a complete new driver of 4k
lines and a change of 100 lines.
It's useless to add a non-functional driver, only to add functionality
later on.

You're right concerning real changes to a driver.

Just my opinion ...

From what I see, Marc did a good job, providing minimal functionality in
the first series. now, the driver can evolve (like adding listen-only :-) )

Kurt

> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/net/can/spi/Kconfig                   |    2 +
> >  drivers/net/can/spi/Makefile                  |    1 +
> >  drivers/net/can/spi/mcp25xxfd/Kconfig         |   17 +
> >  drivers/net/can/spi/mcp25xxfd/Makefile        |    8 +
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-core.c    | 2890 +++++++++++++++++
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c   |   89 +
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c  |  554 ++++
> >  drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h     |  828 +++++
> >  8 files changed, 4389 insertions(+)
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
> > 
