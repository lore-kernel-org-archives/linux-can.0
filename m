From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 15:24:25 +0100
Message-ID: <20171115142425.GB6331@hc>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
 <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
 <1feffea6-00de-6e73-309a-bd9619c19666@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:49984
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756208AbdKOOYl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 15 Nov 2017 09:24:41 -0500
Content-Disposition: inline
In-Reply-To: <1feffea6-00de-6e73-309a-bd9619c19666@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>, linux-spi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>

On Wed, Nov 15, 2017 at 02:31:45PM +0100, Marc Kleine-Budde wrote:
> On 11/15/2017 01:40 PM, Marc Kleine-Budde wrote:
> > mcp251x_spi_trans() is called with len=3,
> > priv->spi_tx_buf and priv->spi_rx_buf point to previously allocared memory
> > 
> > priv->spi_tx_buf has been filled before calling mcp251x_spi_trans().
> 
> > #define OCTEON_SPI_MAX_BYTES 9
> 
> > static int octeon_spi_do_transfer(struct octeon_spi *p,
> > 				  struct spi_message *msg,
> > 				  struct spi_transfer *xfer,
> > 				  bool last_xfer)
> > {
> > 	struct spi_device *spi = msg->spi;
> > 	union cvmx_mpi_cfg mpi_cfg;
> > 	union cvmx_mpi_tx mpi_tx;
> > 	unsigned int clkdiv;
> > 	int mode;
> > 	bool cpha, cpol;
> > 	const u8 *tx_buf;
> > 	u8 *rx_buf;
> > 	int len;
> > 	int i;
> > 
> > 	mode = spi->mode;
> > 	cpha = mode & SPI_CPHA;
> > 	cpol = mode & SPI_CPOL;
> > 
> > 	clkdiv = p->sys_freq / (2 * xfer->speed_hz);
> > 
> > 	mpi_cfg.u64 = 0;
> > 
> > 	mpi_cfg.s.clkdiv = clkdiv;
> > 	mpi_cfg.s.cshi = (mode & SPI_CS_HIGH) ? 1 : 0;
> > 	mpi_cfg.s.lsbfirst = (mode & SPI_LSB_FIRST) ? 1 : 0;
> > 	mpi_cfg.s.wireor = (mode & SPI_3WIRE) ? 1 : 0;
> > 	mpi_cfg.s.idlelo = cpha != cpol;
> > 	mpi_cfg.s.cslate = cpha ? 1 : 0;
> > 	mpi_cfg.s.enable = 1;
> > 
> > 	if (spi->chip_select < 4)
> > 		p->cs_enax |= 1ull << (12 + spi->chip_select);
> > 	mpi_cfg.u64 |= p->cs_enax;
> > 
> > 	if (mpi_cfg.u64 != p->last_cfg) {
> > 		p->last_cfg = mpi_cfg.u64;
> > 		writeq(mpi_cfg.u64, p->register_base + OCTEON_SPI_CFG(p));
> > 	}
> > 	tx_buf = xfer->tx_buf;
> > 	rx_buf = xfer->rx_buf;
> > 	len = xfer->len;
> > 	while (len > OCTEON_SPI_MAX_BYTES) {
> > 		for (i = 0; i < OCTEON_SPI_MAX_BYTES; i++) {
> > 			u8 d;
> > 			if (tx_buf)
> > 				d = *tx_buf++;
> > 			else
> > 				d = 0;
> > 			writeq(d, p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> > 		}
> > 		mpi_tx.u64 = 0;
> > 		mpi_tx.s.csid = spi->chip_select;
> > 		mpi_tx.s.leavecs = 1;
> > 		mpi_tx.s.txnum = tx_buf ? OCTEON_SPI_MAX_BYTES : 0;
> 
> This looks fishy, OCTEON_SPI_MAX_BYTES is 9....

Because there are 9 registers in MPI_DAT(0..8).

> > 		mpi_tx.s.totnum = OCTEON_SPI_MAX_BYTES;
> > 		writeq(mpi_tx.u64, p->register_base + OCTEON_SPI_TX(p));
> > 
> > 		octeon_spi_wait_ready(p);
> > 		if (rx_buf)
> > 			for (i = 0; i < OCTEON_SPI_MAX_BYTES; i++) {
> > 				u64 v = readq(p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> > 				*rx_buf++ = (u8)v;
> > 			}
> > 		len -= OCTEON_SPI_MAX_BYTES;
> > 	}
> > 
> > 	for (i = 0; i < len; i++) {
> > 		u8 d;
> > 		if (tx_buf)
> > 			d = *tx_buf++;
> > 		else
> > 			d = 0;
> > 		writeq(d, p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> > 	}
> > 
> > 	mpi_tx.u64 = 0;
> > 	mpi_tx.s.csid = spi->chip_select;
> > 	if (last_xfer)
> > 		mpi_tx.s.leavecs = xfer->cs_change;
> > 	else
> > 		mpi_tx.s.leavecs = !xfer->cs_change;
> > 	mpi_tx.s.txnum = tx_buf ? len : 0;
> > 	mpi_tx.s.totnum = len;
> > 	writeq(mpi_tx.u64, p->register_base + OCTEON_SPI_TX(p));
> > 
> > 	octeon_spi_wait_ready(p);
> > 	if (rx_buf)
> > 		for (i = 0; i < len; i++) {
> > 			u64 v = readq(p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> > 			*rx_buf++ = (u8)v;
> > 		}
> 
> Personally I'd fold this into the while loop, as there's quite some code
> duplication. Of course your have to improve the "if (last_xfer)" a bit.

I've not written that code, just split it for shared arm64 & mips usage
and avoided re-writing it completely on purpose :) If it turns out that
we need to change this code I might consider making changes like this.

Adding David who might know more about this driver.

--Jan
