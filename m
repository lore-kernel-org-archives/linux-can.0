From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/20] dt-bindings: spi: renesas,sh-msiof: Add r8a774e1
 support
Date: Mon, 20 Jul 2020 20:51:40 -0600
Message-ID: <20200721025140.GA3436698@bogus>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200717115915.GD4316@sirena.org.uk>
 <CA+V-a8sxtan=8NCpEryT9NzOqkPRyQBa-ozYNHvi8goaOJQ24w@mail.gmail.com>
 <20200717122209.GF4316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-il1-f194.google.com ([209.85.166.194]:44828 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCvp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jul 2020 22:51:45 -0400
Content-Disposition: inline
In-Reply-To: <20200717122209.GF4316@sirena.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux I2C <linux-i2c@vger.k>

On Fri, Jul 17, 2020 at 01:22:09PM +0100, Mark Brown wrote:
> On Fri, Jul 17, 2020 at 01:15:13PM +0100, Lad, Prabhakar wrote:
> > On Fri, Jul 17, 2020 at 12:59 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > > On Wed, Jul 15, 2020 at 12:09:04PM +0100, Lad Prabhakar wrote:
> > > > Document RZ/G2H (R8A774E1) SoC bindings.
> 
> > > Please in future could you split things like this up into per subsystem
> > > serieses?  That's a more normal approach and avoids the huge threads and
> > > CC lists.
> 
> > Sorry for doing this, In future I shall keep that in mind. (Wanted to
> > get in most patches for RZ/G2H in V5.9 window)
> 
> If anything sending things as a big series touching lots of subsystems
> can slow things down as people figure out dependencies and who's going
> to actually apply things.

I'd be fine with one patch adding all the compatibles for a new SoC 
where there are no other changes and take that via the soc or DT tree, 
but the Renesas folks need to figure out any cross tree dependencies 
with other Renesas changes. That's a bit harder right now with schema 
conversions though.

Rob
