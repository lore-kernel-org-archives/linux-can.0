Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1052E282B
	for <linux-can@vger.kernel.org>; Thu, 23 Apr 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916213; cv=none; b=IXYcA0A3+SKeFStQUu0vriIeiizgf1ol8P/AWVhggoWgSk0KxJTecfvzqa6uzUHekZdwlQC68uAB0FQO0myLIkeE0X0YXRZtD3MyQMgtiSSBYCqXrGbyyQhpjAoImAuyW3htiSugyWN7X5oahfEYa9wDuH8oMBo7pt13GLw2Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916213; c=relaxed/simple;
	bh=ZdL+/jN/ovOG7UfEMywWY7Pd2rVoztzv4iswm0WEv7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb2VkoCTgfkxdJCnG9eKotAzuDbxNKfrS2NTZcDeDrCyG3yuwfN6RzIvdyXTYStzVSsOu+62I+R98v0FAk9eq+HzwPM4NqLs26b7H7crtv1qhVszOCx3/GyJ5gmnU3tn4tIAmT6udSOnxYgKV99km9+0HnJ2Oe7fIGekFZ8SH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-0005Fc-Sv; Thu, 23 Apr 2026 05:50:00 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-006laS-1E;
	Thu, 23 Apr 2026 05:50:00 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-0000000AQQ6-18j7;
	Thu, 23 Apr 2026 05:50:00 +0200
Date: Thu, 23 Apr 2026 05:50:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
Message-ID: <aemW6JThLpOu5BNg@pengutronix.de>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Alexander,

On Tue, Apr 21, 2026 at 05:31:54PM +0200, Alexander Hölzl wrote:
> In J1939 segmented transport, a CTS message with data byte 2 set to zero is interpreted as a hold message.
> This instructs the transmitter of the segmented message to hold the connection open but to delay sending.
> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after which an held open session is invalidated is
> 1050 ms, not 550 as implemented currently.
> The 550 ms are problematic if a device uses hold messages and assumes it can wait for more than 550 ms before it has
> to resend the hold message.
> 
> This patch changes the T4 timeout used in the implementation from 550 ms to 1050.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

LGTM. Thank you!

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>


Sashico detected one more potential issue, not related to this patch:
https://sashiko.dev/#/patchset/20260421153152.87772-3-alexander.hoelzl%40gmx.net

If you have time, can you please verify it?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
