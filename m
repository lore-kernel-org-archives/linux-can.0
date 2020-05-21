From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Thu, 21 May 2020 13:19:16 -0700
Message-ID: <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de> <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de> <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7b85e098-b9a9-dd14-203f-100cdf2e703e-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, =?UTF-8?B?VGltbyBTY2hsw7zDn2xlcg==?= <schluessler-ssbZdu+FE1GzQB+pC5nmwQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Glauber <jglauber-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Robert Richter <rrichter-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On Wed, Feb 26, 2020 at 2:19 AM Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> On 2/26/20 8:37 AM, Marc Kleine-Budde wrote:
> >> Your right... there is the mcp251x_hw_rx_frame() call that also uses
> >> spi_rx_buf after a synchronous transfer (I didn't see any others).
> >> I'll look at this again.
> >
> > Have you hardware to test your changes? I think the SPI framework would
> > return an -EINVAL in that case....though the return value is sometimes
> > not checked by the driver :/
>
> See https://elixir.bootlin.com/linux/v5.5.6/source/drivers/spi/spi.c#L3413
>
> If you have really have HW with SPI_CONTROLLER_HALF_DUPLEX (a.k.a
> SPI_MASTER_HALF_DUPLEX) restrictions, you need to convert _every_
> mcp251x_spi_trans() call in the driver, as _always_ both rx_buf _and_
> tx_buf are used.
>

Marc,

Sorry for the long delay... I'm finally getting back to this issue.

I'm told by Marvell/Cavium that the OcteonTX SPI hardware does not
support full duplex although I don't see this in any of their errata
or reference manuals. Perhaps someone familiar with the CN81xx/CN80xx
OcteonTX hardware from Marvell/Cavium can weigh in here as I'm not
clear if this limitation is in all hardware that uses the
spi-cavium-thunderx.c driver (I've added Jan to the list who authored
the driver)

As you point out setting SPI_CONTROLLER_HALF_DUPLEX will cause
spi_{sync,async,async_locked} calls to fail with -EINVAL if they have
both a tx and rx buf, so this should be done to help catch these
issues:
diff --git a/drivers/spi/spi-cavium-thunderx.c
b/drivers/spi/spi-cavium-thunderx.c
index fd6b9ca..76fdb94 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -64,6 +65,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
                p->sys_freq = SYS_FREQ_DEFAULT;
        dev_info(dev, "Set system clock to %u\n", p->sys_freq);

+       master->flags = SPI_MASTER_HALF_DUPLEX;
        master->num_chipselect = 4;
        master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
                            SPI_LSB_FIRST | SPI_3WIRE;

Now, with regards to the mcp251x.c driver you were correct that I was
missing dealing with the full-duplex call from mcp251x_hw_rx_frame()
which indeed was causing data corruption on recieve.

So the following patch to mcp251x.c properly converts mcp251x to half-duplex:

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 5009ff2..016c1e5 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -290,23 +290,23 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
        priv->spi_tx_buf[0] = INSTRUCTION_READ;
        priv->spi_tx_buf[1] = reg;

-       mcp251x_spi_trans(spi, 3);
-       val = priv->spi_rx_buf[2];
+       spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);

        return val;
 }

 static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 {
+       u8 val[2] = {0};
        struct mcp251x_priv *priv = spi_get_drvdata(spi);

        priv->spi_tx_buf[0] = INSTRUCTION_READ;
        priv->spi_tx_buf[1] = reg;

-       mcp251x_spi_trans(spi, 4);
+       spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);

-       *v1 = priv->spi_rx_buf[2];
-       *v2 = priv->spi_rx_buf[3];
+       *v1 = val[0];
+       *v2 = val[1];
 }

 static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
@@ -409,8 +409,9 @@ static void mcp251x_hw_rx_frame(struct spi_device
*spi, u8 *buf,
                        buf[i] = mcp251x_read_reg(spi, RXBCTRL(buf_idx) + i);
        } else {
                priv->spi_tx_buf[RXBCTRL_OFF] = INSTRUCTION_READ_RXB(buf_idx);
-               mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
-               memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
+               spi_write_then_read(spi, priv->spi_tx_buf, 1, priv->spi_rx_buf,
+                                   SPI_TRANSFER_BUF_LEN);
+               memcpy(buf + 1, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN - 1);
        }
 }

I do have hardware to test with and without this patch my CN80xx board
with an MCP25625 fails device probing (mcp251x spi0.1: MCP251x didn't
enter in conf mode after reset) because read values are corrupt. With
this patch my the MCP25625 works fine on the CN80xx detecting,
sending, and receiving frames.

Should I be submitting this patch with logic that only does
half-duplex if the spi controller doesn't support it (if
(spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
acceptable to simply make the driver half-duplex like this for all
cases?

Best Regards,

Tim
