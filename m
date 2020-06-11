From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Thu, 11 Jun 2020 22:30:22 +0200
Message-ID: <ed3f66c0-28e5-9bfc-729b-457d564638f9@pengutronix.de>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com
Cc: kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 6/11/20 6:26 PM, Marc Kleine-Budde wrote:
> I initially started looking at Martin's driver and it was not using several
> modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> was not working on the driver any more. Then I decided to rewrite the driver,
> that is the one I'm hoping to mainline soon.

Seems the driver still suffers from the same problems the last time I looked at it:

I'm on a raspi4 with a mcp2518fd connected to spi0 cs0 and cs1.

Running a canfdtest -vg can0; canfdtest -v can1. It  runs into this problem on a
unloaded system and scaling_governor=performance  within minutes:

> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: Something is wrong - we got a TEF interrupt but we were not able to detect a finished fifo
> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: Something is wrong - we got a TEF interrupt but we were not able to detect a finished fifo
> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: tefif: fifo 6 not pending - tef data: id: 00000078 flags: 00000c08, ts: 0addbed3 - this may be a problem with spi signal quality- try reducing spi-clock speed if this can get reproduced
> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: tefif: fifo 7 not pending - tef data: id: 00000078 flags: 00000e08, ts: 0addc2e5 - this may be a problem with spi signal quality- try reducing spi-clock speed if this can get reproduced
> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: tefif: fifo 1 not pending - tef data: id: 00000078 flags: 00000208, ts: 0addc701 - this may be a problem with spi signal quality- try reducing spi-clock speed if this can get reproduced
> Jun 11 21:27:08 rpi4 kernel: mcp25xxfd spi0.0 can1: tefif: fifo 2 not pending - tef data: id: 00000078 flags: 00000408, ts: 0addcb1b - this may be a problem with spi signal quality- try reducing spi-clock speed if this can get reproduced

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
