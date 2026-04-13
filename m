Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEA42AA6
	for <linux-can@vger.kernel.org>; Mon, 13 Apr 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085274; cv=none; b=f0/cLqAZcWgSV4qMzVvO7GJcjOr+rB9WsI28kJkaoK7AQ+LSy6JUKFqVuS/Hv7Yfnmk+l6rsdGRQJcYzD0DrORO6ZizTUoV4+v1EOPjRFRnc4dK5incDZca+ma2g7/w114wDA+kZD+6cSuY9/LIoll2GP06Ii6RUg4wFnDRY+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085274; c=relaxed/simple;
	bh=WTu8R5uqquFwZnkuD79ZlLjUlaBtCXkLmGDzTZI4n14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNiMTMY9VI3shzJsGJfw0cTyIwmjWa0JcS6yfWYqiZ79V3SgxYVMMpGw+j0srmqlAxnLsp5MAKnhg65lBzdiDulM1HOdMQ1OHqdkmDw2xjIphAXLffMetyYUWoSK1YYuvJB8wXANgSmo288ycPqX2WSxsvB51eU10+8QFn1W/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wCGub-0004Q5-Mk; Mon, 13 Apr 2026 15:01:09 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wCGub-005Aru-1e;
	Mon, 13 Apr 2026 15:01:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wCGub-00000007Ulu-1iwl;
	Mon, 13 Apr 2026 15:01:09 +0200
Date: Mon, 13 Apr 2026 15:01:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: [PATCH] can: j1939: Use hrtimer_cancel in
 j1939_cancel_active_session
Message-ID: <adzpFf63Q4_MY0hm@pengutronix.de>
References: <20260413084548.69294-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413084548.69294-1-phx0fer@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Dudu,

On Mon, Apr 13, 2026 at 04:45:48PM +0800, Dudu Lu wrote:
> j1939_cancel_active_session() uses hrtimer_try_to_cancel() for both
> txtimer and rxtimer. When hrtimer_try_to_cancel() returns -1, it means
> the timer callback is currently executing. In this case, the function
> neither cancels the timer nor drops the session reference via
> j1939_session_put(). The session is then deactivated while the timer
> callback may still be running, leading to a potential use-after-free if
> the callback accesses the session after it has been cleaned up.
> 
> Replace hrtimer_try_to_cancel() with hrtimer_cancel() which will wait
> for an in-progress callback to complete before returning, ensuring the
> timer is fully stopped before the session is deactivated.
> 
> Note: This changes the function to potentially sleep (hrtimer_cancel
> waits for the callback). The function is called with
> active_session_list_lock held (a spinlock), so an alternative approach
> would be to handle the -1 return from hrtimer_try_to_cancel() without
> blocking. However, if the lock can be converted or the cancel moved
> outside the lock, hrtimer_cancel() is the cleaner fix.

Is it real or academical issue? Are there some bug report or exploit?

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
