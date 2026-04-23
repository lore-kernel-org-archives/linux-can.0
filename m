Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBF3EF0DC
	for <linux-can@vger.kernel.org>; Thu, 23 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949672; cv=none; b=YT42FT7hl/JtuxDaLWm+QupcG3HmsjABJrGgraMuIFp79yM1kkeQhPNk+DOqHLOIgY4qFn8RDh+yBNCz/ww0KfoSWpTXu9DMh3gLVE8FagNb2qhCJDM+LVHnErq4nEzqgjDRCtEJ/5uklq9jEA2iuV0vt40j7Qr6aWXakVGIUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949672; c=relaxed/simple;
	bh=7qnASczfqXcNCjEC03JuMb3vgdFP5eKMFWZmST1Q/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv4xxNogymgQSuHp5bfXAGGzgOJP5pBq+rkAYTVXEXtuU/aWl9qkbJsBdsoc9md/kYhwZySNwocZnb/hQCx7ESoaNRqW3TJ7D6bPBVOuCgYdehUo2ve4NFoc7H5H6fqZQ06zNRB5HMRKcjcg3GQswXAH+ccITmT8hUTsHykPxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wFtmS-0004F3-2L; Thu, 23 Apr 2026 15:07:44 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wFtmR-006phd-0x;
	Thu, 23 Apr 2026 15:07:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wFtmR-0000000AWm5-0mQe;
	Thu, 23 Apr 2026 15:07:43 +0200
Date: Thu, 23 Apr 2026 15:07:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?SMO2bHpsLA==?= Alexander <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
Message-ID: <aeoZn2BIOzZyCWo_@pengutronix.de>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
 <aemW6JThLpOu5BNg@pengutronix.de>
 <3e17efb4-ae71-4b5c-af23-7b5de9c5e03c@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e17efb4-ae71-4b5c-af23-7b5de9c5e03c@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Thu, Apr 23, 2026 at 11:35:27AM +0200, Hölzl, Alexander wrote:
> 
> Hello Oleksij,
> thank you for your quick review!
> 
> Am 23.04.2026 um 05:50 schrieb Oleksij Rempel:
> > Hi Alexander,
> > 
> > On Tue, Apr 21, 2026 at 05:31:54PM +0200, Alexander Hölzl wrote:
> > > In J1939 segmented transport, a CTS message with data byte 2 set to zero is interpreted as a hold message.
> > > This instructs the transmitter of the segmented message to hold the connection open but to delay sending.
> > > According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after which an held open session is invalidated is
> > > 1050 ms, not 550 as implemented currently.
> > > The 550 ms are problematic if a device uses hold messages and assumes it can wait for more than 550 ms before it has
> > > to resend the hold message.
> > > 
> > > This patch changes the T4 timeout used in the implementation from 550 ms to 1050.
> > > 
> > > Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> > 
> > LGTM. Thank you!
> > 
> > Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > 
> > Sashico detected one more potential issue, not related to this patch:
> > https://sashiko.dev/#/patchset/20260421153152.87772-3-alexander.hoelzl%40gmx.net
> > 
> > If you have time, can you please verify it?
> I just tried it and to be honest it seems that holds are fundamentally
> broken currently. I don't think there is any way to restart normal
> communication as soon as a hold has been received.
> 
> When I send a hold with byte 3 set to FF and try to resume from sequence
> number 1 I get an abort with reason 08 which is "Duplicate sequence number"
> according to the spec:
> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
> (000.001166)  can0  18ECF931   [8]  11 00 FF FF FF 00 AB 00
> (000.101138)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
> (000.000685)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00
> 
> The same happens when setting byte 3 to 01:
> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
> (000.001077)  can0  18ECF931   [8]  11 00 01 FF FF 00 AB 00
> (000.100910)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
> (000.000657)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00
> 
> Setting it to 0 is disallowed as well and the transmission is cancelled
> immediatley with error 05 which is "Maximum retransmit request limit
> reached.":
> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
> (000.000941)  can0  18ECF931   [8]  11 00 00 FF FF 00 AB 00
> (000.000645)  can0  18EC31F9   [8]  FF 05 FF FF FF 00 AB 00
> 
> There is a check at the beggining of j1939_xtp_rx_cts_one for duplicate
> sequence numbers which targets byte 0, so the command type byte, and checks
> that it is not equal to the last command.
> 
> if (session->last_cmd == dat[0]) {
> 		err = J1939_XTP_ABORT_DUP_SEQ;
> 		goto out_session_cancel;
> 	}
> 
> This means it is impossible to handle two directly succeeding CTS which
> would be necessary to escape the hold....
> 
> The easiest way to fix this would probably be to move the check for a hold
> message all the way to the top of j1939_xtp_rx_cts_one and if a hold message
> has been received just set the rx-timeout timer and then bail?

From a quick lock, it sounds plausible. Will you send a patch?

Hm... we needs tests, preferably in kernel source to avoid regressions.

would it be possible to implement is on top of kunit tests?
https://lore.kernel.org/all/20260420152228.581421-1-o.rempel@pengutronix.de/

It looks like there is more user space friendly testing used:
https://lore.kernel.org/all/20260419144600.GA4091724@chcpu16/


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
