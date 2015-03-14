From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: according net pull-request - was Re: [PATCH v4 1/3] can: kvaser_usb:
 Fix tx queue start/stop race conditions
Date: Sat, 14 Mar 2015 15:02:12 +0100
Message-ID: <55043F64.9050504@hartkopp.net>
References: <20150226152011.GA6075@linux> <20150314130249.GA20796@linux> <55043A7E.7040001@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:61003 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbCNOC1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Mar 2015 10:02:27 -0400
In-Reply-To: <55043A7E.7040001@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, netdev@vger.kernel.org

Hi Marc,

On 03/14/2015 02:41 PM, Marc Kleine-Budde wrote:
> Applied to can. This will go into David's net tree and finally into
> net-next. Then I'll apply patches 2+3. Nag me, if I forget about them ;)

Stephane sent an oot-driver to me for the new CAN FD USB adapter driver.
I splitted up this driver into three patches for a review from Stephane.

I would suggest to wait until Tuesday so that we can add these three patches.

I tested the patches and they work as expected. But Stephane should take a
final look at them.

Would it make sense to post the splitted patches on linux-can right now?

Regards,
Oliver

