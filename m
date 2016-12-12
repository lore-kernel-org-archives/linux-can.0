From: "Grim, Dennis" <Dennis.Grim@teejet.com>
Subject: RE: ti hecc rx frames out of order
Date: Mon, 12 Dec 2016 17:17:10 +0000
Message-ID: <1579A5A5423CC14B827884B535F8E95134949B2C@SSCOXCHG2.spray.com>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
 <08de827f-0d1b-4523-0ed9-f0979345de87@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134942564@SSCOXCHG2.spray.com>
 <0b6dc834-db5b-a8e3-1461-f97c7c79ad44@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949AB3@SSCOXCHG2.spray.com>
 <83813a5e-b146-2763-1fb3-31d64fcebf4c@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ms.spray.com ([207.247.13.3]:61210 "EHLO mail.spray.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933715AbcLLRRM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 12 Dec 2016 12:17:12 -0500
In-Reply-To: <83813a5e-b146-2763-1fb3-31d64fcebf4c@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> > I will gladly try your idea.  However, it appears to address an issue related to
> SMP systems.  The TI AM3517 is single core.  Would you expect your idea to have
> any impact for single core?
> 
> No.
> 
> > Also, the TI AM3517 HECC device driver uses NAPI.
> 
> Ugh!
> 
> @Marc: When this is a NAPI driver - what could be the problem then?
> 
> Is NAPI probably the root cause of the o-o-o issue here?
> 
> Regards,
> Oliver

I should add that the hardware that I'm using for test also has two memory-mapped SJA1000 controllers.  I'm using the Linux mainlined SJA1000 platform device driver.  That driver does not use NAPI.

The same test that generates o-o-o errors on the TI HECC runs for days without o-o-o errors.

This leads me to believe that the issue that I'm seeing is in NAPI or possibly the TI HECC driver.

Dennis

