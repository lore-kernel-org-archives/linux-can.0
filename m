From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Date: Fri, 15 Feb 2019 00:21:22 +0100
Message-ID: <20190214232122.GS10129@piout.net>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
 <20190214230756.GR10129@piout.net>
 <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, Ludovic.Desroches@microchip.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-can.vger.kernel.org

On 14/02/2019 17:14:05-0600, Gustavo A. R. Silva wrote:
> >>> Also, the gcc documentation says that -Wimplicit-fallthrough=3
> >>> recognizes /* fallthrough */ as a proper fall through comment (and I
> >>> tested with gcc 8.2).
> >>>
> >>
> >> Yeah. But that's not the relevant change in this case.  Notice that the
> >> comment was moved to the very bottom of the previous case.
> >>
> > 
> > Yes and it doesn't matter for gcc, I tested with gcc 8.2.
> > 
> 
> Yeah. But, again, you are missing the relevant part of the patch.
> 

Right, I misread the patch and though you were moving the comment after
the case statement.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
