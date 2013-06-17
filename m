From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 21:34:42 +0200
Message-ID: <51BF64D2.5000805@grandegger.com>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com> <51BEA863.1040704@hostmobility.com> <51BEB849.3020409@pengutronix.de> <51BF132B.3020705@hostmobility.com> <51BF193B.1030307@pengutronix.de> <51BF5A38.3080001@hostmobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60818 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab3FQTeo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 15:34:44 -0400
In-Reply-To: <51BF5A38.3080001@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Rickard Gustafsson <rickard.gustafsson@hostmobility.com>, Tord Andersson <tord.andersson@endian.se>

On 06/17/2013 08:49 PM, Mirza Krak wrote:
> Thank you Marc for your patch. We  applied it but it did not solve our
> problem.
> 
> Wolfgang suggested defining a lock common for all devices:
> 
>  static DEFINE_SPINLOCK(snor_bus_lock);
> 
> Which I applied and now it seems to work perfectly. Thank you for your
> help.
> 
> Should I blame the hardware driver? :)

Even if there is a separate set of registers for each device, they can
obviously not be accessed concurrently. Well, you can say it's a
hardware feature, but a stupid and inefficient one.

Wolfgang.
