From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 20:39:03 +0800
Message-ID: <20120628123859.GA23422@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <4FEC487A.2050901@pengutronix.de>
 <20120628121817.GA5755@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120628121817.GA5755@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Hui Wang <jason77.wang@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

On Thu, Jun 28, 2012 at 08:18:18PM +0800, Dong Aisheng wrote:
> > > 	can0: can@80032000 {
> > > 		pinctrl-names = "default";
> > > 		pinctrl-0 = <&can0_pins_a>;
> > > 		phy-enable-gpios = <&gpio2 13 0>;
> > > 		status = "okay";
> > > 	};
> > > 
> > > 	can1: can@80034000 {
> > > 		pinctrl-names = "default";
> > > 		pinctrl-0 = <&can1_pins_a>;
> > > 		status = "okay";
> > > 	};
> > 
> > Will this work if can0 is down and can1 is up?
> > 
> > Can we abstract the transceiver power as a regulator? Or a clock? :P
> > 
> Hmm, it may not be a power.
> For mx28evk, it's a STBY pin.
> So it may hard to abstract it as a regulator or clock.
> 
Yes.  It also reminds an error in the dts above.  phy-standby-gpios
should be used instead.

-- 
Regards,
Shawn
