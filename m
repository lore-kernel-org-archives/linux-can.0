From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 20:53:43 +0200
Message-ID: <1378925552-sup-4997@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de> <1378923967-sup-6565@pruts.nl> <5230B897.7020807@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:47201 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab3IKSxv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Sep 2013 14:53:51 -0400
In-reply-to: <5230B897.7020807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

* On 2013-09-11 20:38:15 +0200, Marc Kleine-Budde wrote:
 
> >> Does the command line tool candump show proper frames?
> > 
> > I'll have to look into that tomorrow, at this time I only have access to
> > the capture file I made earlier.
> 
> What kind of CAN hardware are you using? Maybe it's not compatible with
> the existing driver.

I'm using the CANUSB device from can232.com:

http://www.can232.com/?page_id=16

-- 
:wq
^X^Cy^K^X^C^C^C^C
