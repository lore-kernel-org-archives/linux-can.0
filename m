Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E43E1718;
	Fri, 14 Aug 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749009; cv=none; b=sxl7iELAZJCF3lTGfm3IV7whjcAqJvH2FBxOZSeHHuBO4yIYL6k+1oyvt6ew4Zf3Y4YXWT+A2iJlWQqvCD5tUd7gx3Mdflaw1Q1GZCAdzBzRdqijF9msa8eBseHU6ahOqoKAmnUVX2F5UA4bATysVhifSXJ1FFBL4vgn9sd1Vhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749009; c=relaxed/simple;
	bh=ZNbllbu/uvvHWBkqbdX41mxx8Z/L3Ys2dZK5L+MNaQg=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=HoA2pzAJkDIAgeXpXVAHTFdKJQ/XOtj0yB0h3iT8UbBF8ipyDldGi+SLHscWWag2q60HG6ptpdwFyXiKeZhypAku4DlXu2hM2o+DbNgSoRJW/U/SehvLn5sF2w9hM+YbhITo8s+YOLk31s1ercDiuhj6pajplrVQIeFf4OfQ+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=c5MyYi+N; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="c5MyYi+N"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id C312A3FB86;
	Sat, 15 Aug 2026 01:02:38 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id xJC9GaeWoVDK; Sat, 15 Aug 2026 01:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1786748556;
	bh=km3K6GyEBKdpJ/SSffDc/KIh6ea/9zdWGAXqMaPphnw=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=c5MyYi+Nq9NkkWVyvfMux2woqIVf46OdQ79v3hGvXIFicBDN92k7vqlqlePsU6g4b
	 Vp5hYIAWhD2FPf13REcf5yxW8agXC7zgIvk94vb2YX7I66l22p4rYCvbznK1zJjtV8
	 7wpPx7IfuzsM1Spx22XfHC2h5SvtNnmyqlAnlItidjPost5bC34yOGiWk3XAJ3b8lE
	 RDCDnfhktmE7aCXIJLf6pFbERFSgkmYHFRtzptSkeEh6ByItkIOWRd1RFgOcMJlcsF
	 KoQ7lfi0QAIQb3T+MorS7IrRkQFuUKToTAXrafhh3BX7xmvOeDhlsCDcegK6rcoNNO
	 JMNnUeBSlAWdQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id AECFC3FA30;
	Sat, 15 Aug 2026 01:02:36 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit info messages on Arbitration Lost or CAN Bus Error IRQs
Date: Sat, 15 Aug 2026 01:02:34 +0200
User-Agent: KMail/1.9.10
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 Vincent Mailhol <mailhol@kernel.org>,
 Avi Weiss <thnkslprpt@gmail.com>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel@pengutronix.de,
 Jiri Novak <jnovak@fel.cvut.cz>
References: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
In-Reply-To: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
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
Message-Id: <202608150102.34461.pisa@fel.cvut.cz>

Hello Marc,

On Thursday 06 of August 2026 16:07:29 Marc Kleine-Budde wrote:
> Since commit e74bae899529 ("can: ctucanfd: handle bus error interrupts")
> CAN bus error interrupts are properly handled.
>
> With activated CAN Bus Error reporting, Arbitration Lost (ALI) and Bus
> Error (BEI) interrupts are enabled. These can occur at a very high rate
> (~10kHz).
>
> To avoid flooding the system, don't emit a netdev_info() for these.
>
> Fixes: e74bae899529 ("can: ctucanfd: handle bus error interrupts")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c
> b/drivers/net/can/ctucanfd/ctucanfd_base.c index 07d4aa43c700..9aec18681fc5
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -884,8 +884,6 @@ static void ctucan_err_interrupt(struct net_device
> *ndev, u32 isr)
>
>  	/* Check for Arbitration Lost interrupt */
>  	if (FIELD_GET(REG_INT_STAT_ALI, isr)) {
> -		if (dologerr)
> -			netdev_info(ndev, "arbitration lost\n");
>  		priv->can.can_stats.arbitration_lost++;
>  		if (skb) {
>  			cf->can_id |= CAN_ERR_LOSTARB;
> @@ -895,7 +893,6 @@ static void ctucan_err_interrupt(struct net_device
> *ndev, u32 isr)
>
>  	/* Check for Bus Error interrupt */
>  	if (FIELD_GET(REG_INT_STAT_BEI, isr)) {
> -		netdev_info(ndev, "bus error\n");
>  		priv->can.can_stats.bus_error++;
>  		stats->rx_errors++;
>  		if (skb) {
>
> ---
> base-commit: cd0784790d921ff4f7438d3b7ccda86068c8b766
> change-id: 20260805-ctucanfd-silence-can-bus-error-messages-5c5bcd6860f8

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

In the fact, I am in doubts if ALI Arbitration lost interrupt
should be enabled even by CAN_CTRLMODE_BERR_REPORTING unconditionally.
There are lot of situations when error reporting is valuable
but overhead of arbitration lost could load system quite lot.
But on the other hand SocketCAN does not provide separate
reporting option to enable can_stats.arbitration_lost
updates so current code in ctucan_chip_start is proper option


	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
		int_ena |= REG_INT_STAT_ALI |
			   REG_INT_STAT_BEI;
	}

PS1: I have been on vacations without e-mail and I will be next
week too, so sorry for possible delays and these PSs to
wrap up quickly what seems on hold before my leave. 

PS2: Marc and others, please, can you confirm if my patch
"docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD"
https://lore.kernel.org/linux-can/d775feefa1c16d7ea7f42482483c81491f75ce6c.1785574572.git.pisa@cmp.felk.cvut.cz/
is on the right track or if I should repost it to somebody
other than Randy Dunlap and linux-doc to reach right
documentation maintainers.

PS3: Marc, please, have you received my question about problems
with CAN FD on iMX8plus CompuLab's IOT-DIN-IMX8PLUS.
Even manual specifies it as Std CAN only... Can it be
related to some SoC problems, even much lowered speeds
do not help so probably not transceiver HW, may be missing
information for TDC in DTS???

PS4: LPC and Open Source Summit Europe will be held in Prague.
Our submissions to OSSE have not been accepted, one
is on wait list still. Price is too high for my budget
when I bring open technology to others. I am not sure about LPC,
I consider to pay for Real-Time and Scheduling microconference
or something like that. I could presnet something about our mainline
and RT CAN latency testing or our other RT, RISC-V embedded
knowledge if there is interest and suggestion for miniconference, BoF,
so then I would be allowed. Anyway if you have interest to meet,
I will be in Prague and when not teaching, I will be happy to
reserve time. There would be real local enthusiast, free community
and access conference before these Linux Foundation ones

https://www.linuxdays.cz/2026/

I expect to show our HW ZOO there on the booth there as usual
so you can visit us at our university ground.

If there is interest in some community open and free access
meeting then I can negotiate lecture hall, computer rooms etc.
at our faculty when they are not used for teaching or other
events. For something relay interesting which fits in weekend
October 3-4, I would consider even abandon part pr whole of my
LinuxDays presence. No chance to meet during weekend after LPC
and next days, I have already taken these by Apache/NuttX conference
in Glasgow where we present our projects including Matlab Simulink
target for NuttX (and Linux).

Best wishes,

                Pavel

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
