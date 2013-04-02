From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: sja1000 private defines - was: Re: pull-request: can 2013-03-27
Date: Tue, 02 Apr 2013 09:24:02 +0200
Message-ID: <515A8792.3010108@pengutronix.de>
References: <1364393128-19701-1-git-send-email-mkl@pengutronix.de> <20130327.141045.999210087722896364.davem@davemloft.net> <515A7454.9050905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58052 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab3DBHYF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Apr 2013 03:24:05 -0400
In-Reply-To: <515A7454.9050905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On 04/02/2013 08:01 AM, Oliver Hartkopp wrote:
> On 27.03.2013 19:10, David Miller wrote:
> 
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Date: Wed, 27 Mar 2013 15:05:26 +0100
>>
>>> Hello David,
>>>
>>> here's a patch series for net for the v3.9 release cycle. Fengguang Wu found
>>> two problems with the sja1000 drivers:
>>>
>>> A macro in the SH architecture collides with one in the sja1000 driver. I
>>> created a minimal patch suited for stable, only changing this particular
>>> define. (Once net is merged back to net-next, I'll post a patch to uniformly
>>> use a SJA1000_ prefix for the sja100 private defines.) 
> 
> 
> Hello Marc,
> 
> i would suggest to replace REG_ with SJA_ for SJA1000 private defines.
> 
> 1. There's only one "SJA_EN" private(!) define in
>  
> 	linux/drivers/infiniband/hw/qib/qib_iba7322.c
> 
>    which we'll never clash with. There SJA_ is a short form of SPC_JTAG_ and
>    (even if it's not necessary) SJA_EN could be renamed to SJTAG_EN
> 
> 2. Replacing REG_ with SJA1000_REG_ will produce a linebreak hell in all
>    SJA1000 drivers (and the patch of course)
> 
> Naming SJA1000 private defines with SJA_ instead of REG_ (and rename your new
> SJA1000_REG_SR back to SJA_SR) looks the more handy change to me.

I have the patch that adds SJA1000_ to all defines ready. Feel free to
post a patch that adds a prefix to _all_[1] defines in sja1000.h.

[1] If we replace REG_ with SJA_, we still a have lot of defines without
a common prefix.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
