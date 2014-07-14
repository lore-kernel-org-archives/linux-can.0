From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] can: flexcan: add vf61x support for flexcan
Date: Mon, 14 Jul 2014 09:06:33 +0200
Message-ID: <cecd42e333cdf65ad512f719125f9180@agner.ch>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
 <53BFD401.8030101@pengutronix.de>
 <dac76ccd134f41b86f00352d10cfae4b@agner.ch> <20140714060344.GB2197@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.102]:60884 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbaGNHGe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Jul 2014 03:06:34 -0400
In-Reply-To: <20140714060344.GB2197@dragon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

Am 2014-07-14 08:04, schrieb Shawn Guo:
> On Fri, Jul 11, 2014 at 03:58:37PM +0200, Stefan Agner wrote:
>> >> @@ -362,7 +374,7 @@
>> >>
>> >>  			esdhc1: esdhc@400b2000 {
>> >>  				compatible = "fsl,imx53-esdhc";
>> >> -				reg = <0x400b2000 0x4000>;
>> >> +				reg = <0x400b2000 0x1000>;
>> >
>> > What's that doing here? :)
>>
>> That's an error I just stumbled upon.
> 
> I do not see why it's an error.  From Table 2-1. System Memory Map in
> i.MX53 RM, the size of ESDHC1 is 16K.
> 
> Shawn

Hi Shawn,

In the Vybrid RM memory map, 0x400B4000 is allocated to USB. 0x400B3000
is empty, whereas for other peripherals (e.g. FlexCAN) which use
multiple 0x1000 blocks, they are all explicitly stated. That is why I
assumed 0x1000 is correct.

But then, the memory map within the SDHC peripheral has some registers
also located in 0x400B3000. Hence I think 0x2000 is correct. Will send
an updated and separated patch.

--
Stefan
