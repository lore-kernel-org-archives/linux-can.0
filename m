Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126305;
	b=XvOh215peJ+923WQio6b1EhPQFtuS7VnOWJ6VmzdXJ1eQSqzlgZxkurW4Cio4qH9azrb
	 0wWaXjwTaxJlGcbaV0t8dlAK0kveP35hgtG9BTRHJFm2YD3yJ0F2Vjnt5u/nVHNXigO9Z
	 HUkRko2XJ/yPCGnvyiKT0MwsDhcKCcpP2bOFZ6Qe+Aio+8AGWaexRPv8uuVZx8+Or+U5T
	 JYWLRG7oWv4hY+Av8o9d3SpoRI8YSV1JzpbqAE0BA4mHoABgbsOD+G5FBpVPDw+BXto4Q
	 kmwes3EFCJaswdzLpTWKW8Mxu02rj8a4uuK4eILKbVSHYwaDv8vMEk7NDOi1hqe38qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=RsUxm452QWuLWchyDZMBEVkx5cFOVZVaDaKx+qNRmfw=;
	b=eKp5fTQ87J0uQ2WZEjmSE2LgbHKkDJvt4zw6LX7L4zDP/Bwu+PGITXw2L05lBuUrEwdU
	 ixJ1hP/5Af3H2gI0hbBqTz0k4ZlDPRRx5PIJ9fxAOTFbNxO0S4hyhRPK5jHJDVCjt8snk
	 NDDkDWqxSEwZ3VTiMYt7ELBRgzrLpHTyUgX0/4KCkREHHjs9e9tyXqQqN6a7V5+svcJjx
	 t5N1e/11mzVT6EZAs8C0WgKEs7CJPNfOOQXBEFiUMqWcUr6ri2iatPUcHMHH+zUZuPTpT
	 1Yy2DKdcjEWAaINnycAUD7V/RkppW6tv7KFqG2ek0NV+vRkmGvgcXTm8nD5GmrGPhrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BNmzaXTe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C5606A31C
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 08:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BNmzaXTe
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E1B832006B6;
	Sun, 08 Nov 2026 09:25:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794126302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsUxm452QWuLWchyDZMBEVkx5cFOVZVaDaKx+qNRmfw=;
	b=BNmzaXTewaotz33PBVZx5oFOaCtistYdPdQ+3vvMBuSQ3iNJ6vBqk14wKmcoD3sCQ/Feyq
	nQn18iE4bPiQEhqASQOQAL70Ze7mohhaK5GGcTFlaCtqeeEb8Hl+D+pIIrGwSYQL9U1h9x
	QdREynHP35XeAuMNx/K/FN0v3R0toN/BIeE8ePae3wmoeBfhZWavtIoeKpvD0QY4v5E7jD
	PstFiQ/7hKOfs+0Xx5en4zfmIJMk8cheFGszTRkp6AvHk+0OevFeZ/9yQ5RGMaQ5oGXKLA
	tOZ+a5arpq/cM1BzyfrwNDKNkj5/uzQ29nlvVbU2b3WpGwsn8HiHBxHqnD5rMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794126302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsUxm452QWuLWchyDZMBEVkx5cFOVZVaDaKx+qNRmfw=;
	b=JQ7SSvqApWUeg9+mJxQ/gUtdc5nGlcBEhFF4lSRoCCXXLCQ8Pp9C6frpYqMP8aXe3r49po
	TkRsd3jXtkbdNVVpRujlpTBe/WORS14iRiB9gnyUL0RjSxEOtzYkEpgyTST8E6yO/lkY2g
	kWJChA+SNnZ2nYnWkndkGils2phd6JDtqyg+78Dt8oQPUxHdQNXOxFC3fhzKVCxwnICh6p
	BBWyryWfjHuXzDWcsjAFYMatC4+kdnAJDsXLzNSMrqi9s7LSJ4+/saDXXVPHe0JGIyzTPt
	x6wtt010ALm3OGAdBZYcv7tHX6BqjOlne49GVve2ERgPYuXPVPj4CXMjtqjLAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794126302; a=rsa-sha256;
	cv=none;
	b=JNYKYCCoZMly5jaw9ctH8Sng+aLuq5wbiVtkyqXUWRMKZNmD+X/6W8YWbphByOXsnEY3O4
	Fw1GJJE/tXb8IvWyc6lmzQnWTedCXGO7U7xM+a2JcR4459oZu8O2AQOTpEHGvWQLMtVoMM
	a29E7IN83iCIwIIglaXY7v/nNxutOd4X8HAWBo8o6OIFfPkpDXQaO+fyekcD9gxNrolxTi
	Pndki/JNDSezon2PYS4x+UqE4FIN3+ty3eDdQ36JKu9yTK/Our9kgYcpG2XRvScycFz9m6
	0NE8n0dG20UzwvVnJa+z57mrK3IjBvRfcOwodFJlqd9yKEzs9+woTwvSqS0CRw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xPyD0-003AJ4-2f;
	Sun, 08 Nov 2026 09:25:02 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xPyD0-00000006JVv-341U;
	Sun, 08 Nov 2026 09:25:02 +0100
Date: Sun, 8 Nov 2026 09:25:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Sashiko <sashiko-bot@kernel.org>, Zihan Xi <zihanx@nebusec.ai>
Subject: Re: [PATCH 3/3] can: enable memcg accounting for user triggered
 allocations
Message-ID: <avAx3l9-EFrSN8IN@pengutronix.de>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sat, Nov 07, 2026 at 02:06:46PM +0100, Oliver Hartkopp wrote:
> Unprivileged users can create CAN sockets and trigger allocations that
> stay in the kernel for the lifetime of the socket or of the related
> objects. E.g. each CAN_BCM RX_SETUP for a new CAN ID creates a bcm_op
> with optional frame arrays of up to 257 CAN FD frames and a CAN
> receiver, without requiring a CAN device (ifindex 0) and without a
> limit for the number of ops per socket.
> 
> None of these allocations are accounted to the memory cgroup of the
> process that triggers them. So a process can bypass the memory limit
> of its cgroup, e.g. of a container or a systemd service, and exhaust
> the memory of the whole system. The OOM killer can not attribute this
> kernel memory to the responsible process either, which has nearly no
> RSS, and terminates unrelated processes instead.
> 
> Enable memcg accounting for these allocations, as it has been done for
> other objects that can be created by unprivileged users. This does not
> introduce any new CAN specific limit and does not make assumptions
> about the number of sockets, filters or BCM operations an application
> needs. The CAN related kernel memory is just charged to the cgroup of
> the allocating process, so that the memory limits which are already
> configured for this cgroup apply to it as well. Without a configured
> limit the behaviour is unchanged.
> 
> A per socket limit for the number or the memory of the BCM operations,
> as suggested in the reports, does not bound the memory consumption, as
> a process can open many sockets and fork. Hard-coded limits can also
> break existing applications, e.g. one that monitors all 2048 SFF CAN
> IDs with individual RX operations, without a possibility to adjust
> them.
> 
> The following allocations are accounted:
> 
> - af_can: the CAN socket structures (e.g. struct isotp_sock contains
>   two DEFAULT_MAX_PDU_SIZE buffers), the CAN receivers of all CAN
>   protocols and the per-netns receive lists and statistics
> - bcm: the bcm_op structures and their frames/last_frames arrays
> - raw: the per-cpu uniq data and the CAN_RAW_FILTER filters
> - isotp: the TX buffer for PDUs > DEFAULT_MAX_PDU_SIZE
> - j1939: the SO_J1939_FILTER filters and the per device j1939_priv,
>   which is created by the first bind() to a CAN device
> 
> The CAN socket structures are allocated with GFP_KERNEL_ACCOUNT in
> sk_alloc() instead of creating dedicated slab caches with
> proto_register(), as the CAN protocols copy socket options directly
> from their socket structures to user space, which would require
> usercopy whitelists for these caches.
> 
> memdup_sockptr() does not support memcg accounting, so the filters are
> allocated and copied explicitly.
> 
> The isotp RX buffer and the j1939 RX sessions are allocated in softirq
> context and can not be attributed to a process. The j1939 TX sessions
> only exist for the duration of a transfer and the can-gw jobs require
> CAP_NET_ADMIN in the initial user namespace, so they are not changed.
> Temporary buffers that are freed before the syscall returns are not
> accounted either.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net
> Reported-by: Zihan Xi <zihanx@nebusec.ai>
> Closes: https://lore.kernel.org/linux-can/cover.1793089479.git.zihanx@nebusec.ai/
> Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/af_can.c       | 12 +++++++-----
>  net/can/bcm.c          | 10 +++++-----
>  net/can/isotp.c        |  2 +-
>  net/can/j1939/main.c   |  2 +-
>  net/can/j1939/socket.c | 11 ++++++++---

For the J1939 part:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
