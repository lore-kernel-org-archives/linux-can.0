From: "Max S." <max@schneidersoft.net>
Subject: Thanks! Re: pull-request: can-next 2014-05-19
Date: Sat, 31 May 2014 15:38:49 +0000
Message-ID: <1401550729.32359.16.camel@blackbox>
References: <5379B6CE.60004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:41018 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaEaPqR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 31 May 2014 11:46:17 -0400
In-Reply-To: <5379B6CE.60004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

Hello all.
Thanks allot for all the help on getting this driver this far.

I've got two tethered units I'm be willing to give away. So if any of
the people who helped me with this project are interested, send me an
address to ship to. If you are interested, please make sure you have a
use for the device :)

Again thanks to all the people involved. Especially Marc, Oliver, and
Wolfgang.

Regards,
Maximilian Schneider.

On Mon, 2014-05-19 at 09:46 +0200, Marc Kleine-Budde wrote:
> Hello David,
> 
> this is a pull request of 13 patches for net-next/master.
> 
> A patch by Dan Carpenter fixes a coccinelle warning in the mcp251x
> driver. Jean Delvare contributes three patches to tightening the
> Kconfig dependencies for some drivers. Then come three patches by Pavel
> Machek that improve the c_can driver support on the socfpga platform.
> Sergei Shtylyov's patch brings support for the CAN hardware found on
> Renesas R-Car CAN controllers. Four patches by Oliver Hartkopp, the
> first cleans up the guard macros in the CAN headers the other three
> improve the EFF frame filtering. Maximilian Schneider's patch adds
> support for the GS_USB CAN devices.
> 
> Marc
> 


