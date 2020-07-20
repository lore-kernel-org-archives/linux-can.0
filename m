From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/20] Add support for [H]SCIF/TMU/CMT/THS/SDHI/MSIOF/CAN[FD]/I2C/IIC/RWDT on R8A774E1
Date: Mon, 20 Jul 2020 12:12:00 +0100
Message-ID: <159524352070.8289.9628744508547399473.b4-ty@kernel.org>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Wim Van Sebroeck <wim@linux-watchdog.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>
List-Id: linux-can.vger.kernel.org

On Wed, 15 Jul 2020 12:08:50 +0100, Lad Prabhakar wrote:
> This patch series enables support for following on RZ/G2H SoC,
> * CPU OPP
> * THS
> * CMT/TMU
> * I2C/IIC
> * MSIOF
> * RWDT
> * SDHI
> * SCIF/HSCIF
> * CAN/CANFD
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a774e1 support
      commit: b4f7f5f5470588e45e5d004f1dc4887af20f18c0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
