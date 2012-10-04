From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] can: sja1000: Make sja1000_of_platform selectable and
 compilable on SPARC
Date: Thu, 04 Oct 2012 15:43:02 +0200
Message-ID: <506D9266.6010707@gaisler.com>
References: <1349183599-28734-1-git-send-email-andreas@gaisler.com> <506D85D7.8090801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:59573 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933077Ab2JDNnj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 09:43:39 -0400
In-Reply-To: <506D85D7.8090801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 10/04/2012 02:49 PM, Marc Kleine-Budde wrote:
> On 10/02/2012 03:13 PM, Andreas Larsson wrote:
>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>
> On sparc32 (and others) this fails to compile with:
>
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja1000_ofp_read_reg':
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:64:2: error: implicit declaration of function 'in_8' [-Werror=implicit-function-declaration]
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja1000_ofp_write_reg':
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:70:2: error: implicit declaration of function 'out_8' [-Werror=implicit-function-declaration]

Oh, right, sorry about that. Thank's for the input. I was testing on top 
of a local patch providing that for sparc. I'll send a new patch 
changing the I/O functions to ioread8 and iowrite8.

Cheers,
Andreas
