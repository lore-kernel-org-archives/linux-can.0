From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 13:07:54 +0100
Message-ID: <20171115120754.GC3011@hc>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bfa971bb-1217-ed86-d1d8-e353ecc506aa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-can <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On Wed, Nov 15, 2017 at 11:54:20AM +0100, Marc Kleine-Budde wrote:
> On 11/14/2017 01:02 PM, Mark Brown wrote:
> > On Mon, Nov 13, 2017 at 01:17:42PM -0800, Tim Harvey wrote:
> > 
> >> When a register is read from the mcp251x driver the
> >> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
> >> len=3, a tx_buf, and an rx_buf which I believe is supposed to shift
> >> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
> >> byte shifted in would be the response.
> > 
> > No, that will simultaneously transmit and recieve three bytes.
> 
> That's what the driver supposed to do.
> 
> > If you want to transmit two bytes and then recieve one byte you need
> > two xfers, one with a len of 2 and a tx_buf, the other with a len of
> > 1 and a rx_buf.
> To read a register (mcp251x_read_reg()) the mcp251x does a 3 byte full
> duplex transfer. The first byte send is the command (read register) the
> second byte the register number the third byte is a dummy. The first 2
> bytes received are ignored the 3rd byte is the register contents.

To support this full duplex transfer the Cavium SPI controller needs
to know the receive lenght before setting up the transaction.

spi_transfer only includes the total length, so I don't see how this
should work.

--Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
