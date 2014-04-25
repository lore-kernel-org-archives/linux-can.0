From: Thor Thayer <tthayer@altera.com>
Subject: Re: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
Date: Fri, 25 Apr 2014 16:31:58 -0500
Message-ID: <1398461518.3587.11.camel@dinh-ubuntu>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398457446.26387.0.camel@linux-builds1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: ZY - pavel <pavel@denx.de>, linux-can@vger.kernel.org, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, socketcan@hartkopp.net, tthayer.linux@gmail.com, Steffen Trumtrar <s.trumtrar@pengutronix.de>, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

On Fri, 2014-04-25 at 15:24 -0500, Dinh Nguyen wrote:
> On Fri, 2014-04-25 at 21:53 +0200, ZY - pavel wrote:
> > Hi!
> > 
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > 
> > > I have had similar patch here, except that it only listed 2 interrupts
> > > for each d_can controller.
> > > 
> > > Otherwise it looks identical.
> > > 
> > > Reviewed-by: Pavel Machek <pavel@denx.de>
> > 
> > Actually, does it work for you? Here it produces warnings during boot
> > 
> > c_can_platform ffc00000.d_can: invalid resource
> > c_can_platform ffc00000.d_can: control memory is not used for raminit
> > c_can_platform ffc00000.d_can: c_can_platform device registered
> > (regs=9085c000, irq=163)

Hi! Yes, these warnings are being addressed in a patch I submitted that
is currently being reviewed.
(http://article.gmane.org/gmane.linux.can/5620/match=tthayer)

> > ...
> > can: controller area network core (rev 20120528 abi 9)
> > NET: Registered protocol family 29
> > can: raw protocol (rev 20120528)
> > can: broadcast manager protocol (rev 20120528 t)
> > can: netlink gateway (rev 20130117) max_hops=1
> > 
> > . Then can0 is correctly registered, and seems to even receive
> > packets, but only when enter is pressed on serial console... which is
> > kind of weird. I suspected irq problems, but same symptomps with
> > "irqpoll" -- it leads to generate 2000 irqs/second, but still waits
> > for enter.
> > 
> > [Aha, and we have just two interrupts listed, but I don't think that
> > explains all the problems. Unfortunately, that particular target uses
> > human for remote power switch...].
> > 
> > Any ideas?
> 
> CC'ing Thor Thayer. He's done the CAN testing on the SOCFPGA platform.
> 
> Dinh

To get this working well, I had to install a few of the patches that
Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access for
D_CAN) on 9/9/2013.

I have the patches on our rocketboard branch
(rocketboards.org/gitweb/?p=linux-socfpga-git;a=summary)

I planned to upstream these changes but there have been some major
changes to CAN recently that may require some refactoring.

Thor

> > 
> > Thanks,
> > 									Pavel
> 
> 
