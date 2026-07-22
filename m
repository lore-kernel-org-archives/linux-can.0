Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEE43B4AE;
	Wed, 22 Jul 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754309; cv=none; b=ZtWnSO+8SMiwevrzuOYdicA8m4memPzOM79aCwJU+TpsVTg80on/W28mRZrz2GQvYG2yx0hRmNtAuywAnM0+RYbwJJBNl1xFBzo5ryMrmm57zR9K1ni0UCa4WyHdKJ+ZrkODsSUaWRoc4bgedYr6N0VPSOPkjv2o/Z42LNSHy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754309; c=relaxed/simple;
	bh=t2NDm5qTTWl4t1o6vGvsiMt/Y+iDHK1r73A3FgoK4V8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Mdn9Ii5jdmbeQ3pVNXD+/ZOW5L978DVQzimAw6TK0SOgJ/gEDTRN0+JSzeKaCG5he+gjNixhxvr45GZeG38X45B9sr7YRCM0vG9lTpNn8pOu8/5xWzQKbu6ieobVShKVP5YqbZ3zI3WTGDMwZxNoaeImgaodXvBisKiCQV6WpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=ZPjcXEg+; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="ZPjcXEg+"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id E7B0B2533E;
	Wed, 22 Jul 2026 22:56:23 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id DbAU8b72-TSJ; Wed, 22 Jul 2026 22:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1784753782;
	bh=HmoTGW/YiXWWnqjLZJKior+cEUl9VrnIA8+F4/s77LM=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=ZPjcXEg+D+wyJXFZA0RKwOZp+Vl4XT1oYPsU2jaa0hHdrPbFyhN0jvWnY7ZPjWQ/D
	 8yRsxwosbj48hzmyrx6yDNtz5rqowcT3Kke/A5KT8TDpt7tbDfyjhQ+ZJiXZR+wXZq
	 1IVrTS7QldEHLKUA7TOfdU6a158odr8F629Nk57H/JzvQBvFr7bc0A2re6GRB5JiS4
	 E55XGTSXUt5O3usYe3WoKa4oXupXDC9W5n0R3i1Tp+qC4yI+onb9UBvVVqxyvyL0P3
	 BNHAvLO9N3aFNxh9V2xGPoiRdqwoah3VEW/UvlEq75pIQSYO2kfwTb4xzu0A7qx/2g
	 UyogAaxvRMTyw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id A6FE82533D;
	Wed, 22 Jul 2026 22:56:21 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Subject: Re: [PATCH net] can: ctucanfd: use self-test mode for PRESUME_ACK
Date: Wed, 22 Jul 2026 22:56:20 +0200
User-Agent: KMail/1.9.10
Cc: linux-can@vger.kernel.org,
 Ondrej Ille <ondrej.ille@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Martin Jerabek <martin.jerabek01@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiri Novak <jnovak@fel.cvut.cz>,
 Michal Lenc <michallenc7@gmail.com>
References: <20260722192726.230729-1-thnkslprpt@gmail.com>
In-Reply-To: <20260722192726.230729-1-thnkslprpt@gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607222256.20923.pisa@fel.cvut.cz>

Hello Avi,

that is good catch.

On Wednesday 22 of July 2026 21:27:26 Avi Weiss wrote:
> Use self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
> frames can complete without receiving an ACK.
>
> ACK forbidden mode prevents the controller from acknowledging
> received frames and does not implement the presume-ack behavior.
>
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source
> IP core - bus independent part.") Signed-off-by: Avi Weiss
> <thnkslprpt@gmail.com>
> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c
> b/drivers/net/can/ctucanfd/ctucanfd_base.c index 0ea1ff28dfce..8e0a606f2c84
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -340,8 +340,8 @@ static void ctucan_set_mode(struct ctucan_priv *priv,
> const struct can_ctrlmode (mode_reg & ~REG_MODE_FDE);
>
>  	mode_reg = (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
> -			(mode_reg | REG_MODE_ACF) :
> -			(mode_reg & ~REG_MODE_ACF);
> +			(mode_reg | REG_MODE_STM) :
> +			(mode_reg & ~REG_MODE_STM);
>
>  	mode_reg = (mode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
>  			(mode_reg | REG_MODE_NISOFD) :

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

It is interesting how long it got unnoticed form original version
of the the code probably written by Martin Jerabek in 2018 year.

When Michal Lenc worked on CTU CAN FD driver for RTEMS based on
my LinCAN from 2000, he has corrected this problem year ago

https://gitlab.fel.cvut.cz/otrees/rtems/rtems-canfd/-/commit/e0bd5db71683375e0962dd90314c7697db3f34f2
 
https://gitlab.rtems.org/rtems/rtos/rtems/-/blob/main/bsps/shared/dev/can/ctucanfd/ctucanfd.c?ref_type=heads#L554

The RTEMS CTU CAN FD driver and framework uses multiple priority queues
on Tx side which prevents head of line blocking caused low priority
message and its continuously unsuccessful arbitrations due to
higher/middle priority message send by other node. There is our
article for International CAN Conference

Scheduling of CAN frame transmission when multiple FIFOs with assigned 
priorities are used in RTOS 

https://www.can-cia.org/fileadmin/cia/documents/proceedings/2024_lenc_pisa.pdf

https://canbus.pages.fel.cvut.cz/files/scheduling_of_can_message_transmission_michal_lenc.pdf

It is based on control registers redesign comming from my plan
and project to advance original controller design intended only
for Skoda Auto testing into full featured CAN FD controller in 2017
and I have idea how to implement QoS classes for SolcketCAN
with HW that provides designed features. By the way, we have tested
and implemented CAN QoS classification for Oliver Hartkopp even
may years before that. But there had not been any controller
supporting that well and no support for multiple queues
in Linux SocketCAN. I have not checked recently, but I think
no other CAN controller uses multi-queue in Linux kernel yet.

There is very nice solution possible with CTU CAN FD, I have
it on my long term plan so it will be solved once in spare
time in frame of some thesis I mentor or by somebody else
or the priority can be increased by some funded project. 

But I suggest to look at our article and discuss such project
with me because I have though about it from the day one
of CTU CAN FD. The control principles of the most of
other controllers are hardly usable for this except some
most recent NXP controllers which seems to provide option
to change Tx message object local priority without stopping
Tx, I have not checked that myself yer, but Michal Lenc
has spotted this. 

If you want to use CTU CAN FD in listen only mode
CAN_CTRLMODE_LISTENONLY, then there is flaw in the
CTU CAN FD RTL design earlier than 2.5.2.

It can be solved in the most of earlier versions
by enabling of REG_MODE_ACF and REG_MODE_ROM together
with REG_MODE_BMM. Again there should be added
check for version and wokaround in the kernel
driver.

The CTU CAN FD kernel code needs to be updated
to support other number of Tx buffers than four.
It would stuck on eight in the current version.
Again I have it on my longer term list but priority
is even more lowered these days as the RTL project
is not coordinated with CTU these days and 
GitLab workflow has been removed.

There is significant work done on HW timestamping
for Rx which needs some polishing for Linux mainline
still and the additional bits proposed by me marking Tx
frames and originating Tx buffer when Tx is requested
to be looped into Rx FIFO allows implement even precise
Tx timestamping and exact echo order between link,
Tx and Rx frames. So there is lot of potential based
on my original plans.

But as you know I have lot of fun with RTEMS and NuttX
these days. I have tested LwIP from Armaan Chowfin GSoC
on TMS570LS3137 this evening with success. So may be our
contribution to RTEMS CAN and or LwIP can help another
target to be used in serious mission same as we helped
with our small contributions to Artemis II in the past.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
