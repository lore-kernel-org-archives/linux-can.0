Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5415A85A;
	Thu,  1 Oct 2026 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854631; cv=pass; b=BS5BxMiBGoAnSNUt0dPZ0CZ3sgOFITOTPaXgdAbvUlFelGtxf/6HyvL4fm3ve4Mwto6rXC1zmY3lhvdCjUgG4Tlc3RPivWbacLcDVVDe5HURB+Ch5gDl9h6931Tfvc2U88UktuhbRCCb8sxG61sbUhImYXnabfdwoGJmg85JO4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854631; c=relaxed/simple;
	bh=H9uUNmZ0k+KejkXXYoBm7GXYSYusYciCKzSZj3WV13Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht9kUjTit23Nz9W8QiR05EMet7Y6oGeh9dkf+h818oNNbcTPn1e7IU8ofOgc7BU9jQXu/l0nPg7HxyxBlSuWQb3wxNgsx2crg7M7FNhCa3sAkvCTFkIu/Zcn3i5c/56EfVwzfb5BPx6AE0QibazEOL7RosvnShZeZGOi7G7mluw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=d7eu9cQ+; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="d7eu9cQ+"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2D10C200153;
	Thu, 01 Oct 2026 13:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790854623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovV+5qXkzIZXND2Fy72/5JdlbthJkV0p9rmtLjQRdkY=;
	b=d7eu9cQ+qe62tfO9HgGQOuW8DzMy8C8OLULA2HW9PiWNjmHknCYqQqQp3moUVtR6HwMJUa
	5tKzSOA5L//burei0FkDnPjVxHZpfXL90fmaZUVmwIUeq+3WO5f+XRXU0PKr27XdD6NR4s
	BvrzfQTibnklZAHnAbqyPREfP5PJhRfWEFT1jBR9LnqctUP7/O63LbziN+utDGrNsw8Q27
	R34MEQ1iQ5tFlmJfgYb1lhROREUynkZAMXRxk324Q+BkAgsHHyFT6HAj/mUdMcSDAEXK32
	hx1bwNSOSZM47purqKWE4jrU7eLUbuOuOiZgfFCgkMbptfJLrr9OP2DPw9HUxg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790854623; a=rsa-sha256;
	cv=none;
	b=NDavMETnRGZNQzP2c8HQvSZSydZpBhR+S+lsymZYvZAyt+Ty0pL4c8ZhryXR33vhtPyQJ5
	fxVK7xH5aCldTZzvuaRphX0Di9gQdJFjGO40KiF5CgkgCYQsUF5almgHYGh/s81hTgje0Z
	vnrnNw4Bc6p16kqZmY+ScxGyju28v30vkxLxnPJ0ZCva+FRr1y0CVocX6zsLoBEeGoqKej
	dSHcuPc7x24NjzVQeJEaP9LjG/XngGKXM7IScOAU9r6+PRm72PFIwNtTW/se/Aql8n9Etg
	0zsOBlCNWMQj3y4bavJDpS46BSQmFt/JGkqMJV/cQv1gOHObGflclkUH9edbrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790854623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovV+5qXkzIZXND2Fy72/5JdlbthJkV0p9rmtLjQRdkY=;
	b=OgFvToJQcBllefpUCpPqn5AbQEHKgzj/VfFl7TLoNgba8lEErqIKN/+tPM2mxiJ/fwaQdU
	B8VydT5Wfb4jGjUJQdxuttrlU+KoVfB4JQZBJa/sOoIC/Jt/26tL97yJqW7oIQzhIboeFy
	zfq4Pthu43xcYKaEHuANc80yXR4+VEJIkZ3PDy4gHefj81spaSCqdAYtvFaMvyf/POaLw9
	nX75MTHWwBD5ktRYURh+YIep4GcttP9m84KSvdAnFK4j9DELvSnuhCzHcO8+yIFj/FF/nY
	S1lcjUWMt0OYbdwnZXWOBZJ6p1LsuMuGRFNEb0d9ok2B7UYpGlUXKkv4WyXFIQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xCF5z-003icc-0G;
	Thu, 01 Oct 2026 13:37:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xCF5y-00000004TBK-47NH;
	Thu, 01 Oct 2026 13:37:02 +0200
Date: Thu, 1 Oct 2026 13:37:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?SMO2bHpsLA==?= Alexander <alexander.hoelzl@gmx.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Markus Koeniger <markus.koeniger87@gmail.com>, robin@protonic.nl,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
Message-ID: <ar5F3nxH6pvuE_Up@pengutronix.de>
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
 <ar45DX0aPoWBvA_-@LEGNB0874>
 <20261001-bison-of-undeniable-art-5bcb84-mkl@pengutronix.de>
 <9da1ca76-4c89-4109-ba78-c08cfe69ea19@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da1ca76-4c89-4109-ba78-c08cfe69ea19@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi,

On Thu, Oct 01, 2026 at 01:18:27PM +0200, Hölzl, Alexander wrote:
> Hello,
> Am 01.10.2026 um 12:57 schrieb Marc Kleine-Budde:
> > On 01.10.2026 12:42:21, Markus Koeniger wrote:
> > > I really appreciate your solution to schedule the TX timer for a BAM
> > > transfer after receiving the looped-back frame.
> > 
> Glad that I could help.
>
> > > We use external CAN controllers in our system, which introduce some
> > > jitter into the transmit path. As a result, messages were sent from
> > > time to time too quickly and violated the 50 ms minimum interval. Your
> > > patch solves this problem.
> > > 
> > > Tested-by: Markus Koeniger markus.koeniger@liebherr.com
> > 
> > Thanks for testing, however I'm not sure if we can get this patch
> > upstream if sashiko complains about it.
> > 
> I wasn't planning on letting this patch stall. Next week I'll try to address
> sashiko comment's as well as the other patch I still have open.

Nice, thx.

I'm working right now on  j1939 selftests for core functionality. Hope
it will be ready this week. If not, next week i'll be in Prag on E-OSS
conference...

> Additionally while I'm at it I just wanted to ask, is it intended behavior
> that the kernel implementation strictly serializes all J1939 sessions. E.g
> when sending a segmented message directed to destination address A it is not
> possible to have a second session open targeting destination address B.
> According to the standard this is allowed and not
> being able to do so can result in very low performance in some use-cases.
> This especially true if one of the sessions is a BAM session transmitting a
> longer message, as there are 50ms pauses between each frame.

Is it not working with a separate socket? If I remember it correctly,
this behavior should be supported if two sockets send to separate
addresses. Withing one socket, frames should be serialized.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
