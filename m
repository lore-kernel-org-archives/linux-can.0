Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891554;
	b=AyB6BPUSYu61lfyGnMBG6AfuHVcNHkvCMjZWxJcsTA9AowRAlEhGzGSn3HsCoM3T9hPi
	 ohbAExSRHAwbO+G5OqBBNMOz8eTUHhCFnvIRybQzB1af7X6tGv6EFqKseWTWFLE7pC3Qw
	 ElcuiomTtECgTOcbrjMF5OvgnJFbEFECXtdOWgw9LOoPxUOOExZh/fm4YOVEB4UDBBTU8
	 lhFq8HzvdWLCElMHIIHb6jPzOr+sBpaRYF+9yN8u/LMFtz57MfgbkW8Q+tnrZgFKbOW+T
	 9udeNTlkn1KH855rGkJCtYbfTnbvQsdOSes1eTzJ2xZMwaEkKS0bQ124ioGpwUPUvkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891554;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=WElitZFefKv0rgpm3AguagYp7WsTnrfiJcI5GKSEC6M=;
	b=Tsggalhj5viR3BSMvFhqMGSDiKQ7SNwvAAXmrs9Go2CGTzhTPK6Rhl2oyMxqvCCG9sqh
	 rGBR1I30YsW9KIw7J09V0zDC6/tNn0Rm3FoZGY7bSYf54uUoAhVfP1+KNlH7y2lJHlHVF
	 sNZAwZ/NoraoXZ7F16+gqRrTv00xnvqnFgTspTerYZXy8lhuOYVsbMH+P1xygeszuPSNQ
	 1BYr+HaHKwLhrrISw6d8da2lN8sF8R0g1sJN5JEHi+6mtEHI8LxNsMuhIR1e/wu0ex06g
	 1kHCpleaXvUDYvpbwEJ8fk5sKdZvC+jQw8QzfvwtHm/RfWnTocLAQOc0TT2OjMSigJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2A606D82B
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A2A606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A5FCAql097941;
	Fri, 6 Nov 2026 00:12:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A5FC9LE097937
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Nov 2026 00:12:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <32fe7f0c-4f2d-4a52-98cc-84c63bee9d3e@I-love.SAKURA.ne.jp>
Date: Fri, 6 Nov 2026 00:12:06 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
 in j1939_ecu_map_locked()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
 <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
 <sashiko-outbox-199025@kernel.org>
 <50c77aa2-acda-496a-b0f1-c48ffcf0665f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <50c77aa2-acda-496a-b0f1-c48ffcf0665f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

On 2026/11/05 23:42, Tetsuo Handa wrote:
> I tried "rmmod can_j1939" while the kernel is unable to make progress due to
> "kernel:unregister_netdevice: waiting for vcan0 to become free. Usage count = 11351".
> 
> The "rmmod can_j1939" operation is blocked at NETDEV_UNREGISTER event until
> the vcan0's refcount drops to 1. Since j1939_ecu and j1939_priv are holding
> a ref to the vcan0, module unload operation won't complete until all j1939_ecu
> and j1939_priv are released. Therefore, I suspect that "[High] can: j1939:
> use-after-free in j1939_ecu_timer_handler() on module exit" is a false-positive.
Well, this is not a false-positive when teardown of a network namespace is not involved.

