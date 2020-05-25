From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Mon, 25 May 2020 14:41:31 +0200
Message-ID: <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200525113106.GB4544-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-GB
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler-ssbZdu+FE1GzQB+pC5nmwQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Glauber <jglauber-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Robert Richter <rrichter-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 5/25/20 1:31 PM, Mark Brown wrote:
>>> Should I be submitting this patch with logic that only does
>>> half-duplex if the spi controller doesn't support it (if
>>> (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
>>> acceptable to simply make the driver half-duplex like this for all
>>> cases?
> 
>> Please make half duplex transfers depending on SPI_CONTROLLER_HALF_DUPLEX as
>> most drivers have a considerable overhead at the end of a transfer.
> 
>> Most of them wait for a transfer complete interrupt. Which might take longer
>> than the actual SPI transfer. Splitting one full duplex read-register transfer
>> (which is a write followed by a read) into two half duplex transfers would kill
>> performance on full duplex capable controllers.
> 
> This isn't something that every individual driver should be doing, such
> rewriting should happen in the core so that everything sees the benefit.

The core could merge several half duplex transfers (until there's as cs_change)
into a single full duplex transfer.

I think it's not easy to detect and reliable to split a full duplex transfer
into half duplex ones. How can you tell, if the controller is supposed to tx 0x0
or actually receive.

I think spi_write_then_read() can be extended to generate one full duplex
transfer instead on two half duplex ones it does a memcpy() anyways.

To get a feeling for the use cases, this is what I do in the regmap read
function of a (not yet mainlined) CAN SPI driver.

> static int
> mcp25xxfd_regmap_nocrc_read(void *context,
> 			    const void *reg, size_t reg_len,
> 			    void *val_buf, size_t val_len)
> {
> 	struct spi_device *spi = context;
> 	struct mcp25xxfd_priv *priv = spi_get_drvdata(spi);
> 	struct mcp25xxfd_map_buf_nocrc *buf_rx = priv->map_buf_nocrc_rx;
> 	struct mcp25xxfd_map_buf_nocrc *buf_tx = priv->map_buf_nocrc_tx;
> 	struct spi_transfer xfer[2] = { };
> 	struct spi_message msg;
> 	int err;
> 
> 	spi_message_init(&msg);
> 	spi_message_add_tail(&xfer[0], &msg);
> 
> 	if (priv->devtype_data.quirks & MCP25XXFD_QUIRK_HALF_DUPLEX) {
> 		xfer[0].tx_buf = reg;
> 		xfer[0].len = sizeof(buf_tx->cmd);
> 
> 		xfer[1].rx_buf = val_buf;
> 		xfer[1].len = val_len;
> 		spi_message_add_tail(&xfer[1], &msg);
> 	} else {
> 		xfer[0].tx_buf = buf_tx;
> 		xfer[0].rx_buf = buf_rx;
> 		xfer[0].len = sizeof(buf_tx->cmd) + val_len;
> 		memcpy(&buf_tx->cmd, reg, sizeof(buf_tx->cmd));
> 	};
> 
> 	err = spi_sync(spi, &msg);
> 	if (err)
> 		return err;
> 
> 	if (!(priv->devtype_data.quirks & MCP25XXFD_QUIRK_HALF_DUPLEX))
> 		memcpy(val_buf, buf_rx->data, val_len);
> 
> 	return 0;
> }

The tradeoff here is two transfers vs. the the memcpy(). As CAN frames are quite
small the memcpy() is usually faster. Even on the rpi, where the driver is
optimized for small transfers.

regards
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
