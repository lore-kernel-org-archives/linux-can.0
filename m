From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 08/11] clk: renesas: r8a774c0: Add missing CANFD clock
Date: Thu, 17 Jan 2019 14:11:57 +0100
Message-ID: <20190117131156.eq7zh3y5e6koueos@verge.net.au>
References: <1547667945-5588-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547667945-5588-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 07:45:45PM +0000, Fabrizio Castro wrote:
> This patch adds the missing CANFD clock to the r8a774c0 specific
> clock driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> 
> ---
> The relevant documentation should appear in the next version
> of the HW User's manual
> 
> v1->v2:
> * appended R8A774C0_CLK_CANFD as per Geert's comment


Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
