Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780731;
	b=S93TstXuwTMfkMfDOM35lJpk9UlfObtUeh/Pwz8ytG+2eqf9iva9M3fjLUsnjRqSL9DO
	 H5go5oPjv2e7he3141kJu59kkZebnK9OwNTOSUENExxqFZ/pARgBeZTku9c+iENuj074k
	 Qkb12i5oBsDPUDKESLMCEp2w8nw7ozvrAMv5OjpjKE3lgLlSedQOhV8CIWg8OHZD708ih
	 ngrJuRS4x7Q380Qadh5+VZxD4xeB34a1ChEEZtcTPh2XHHlVcAeAyz7m3noC2w7A41a9U
	 nLMjJFx1EFraut3VHn0ckaguRbteNTOJIkVV/WIWE4bScvv0Odg36WsJ3XAIO7KxhVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780731;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UQQOlPc1FtE9f588BBPhLMGb3qMOxVEpChgmo8GGpNg=;
	b=MEL7PLz3yd9MN+YaGr79t9HaigZCY/vh8DxdCx6qU6EiOICryaEhVBxlby+ulz8JbMso
	 GpsEG7XlOyF+iWuz7mcpLAsufSBDGzDnqEYWfsvC8H9phxLxdQ5EMeHu2ajkd0FJWQ6lW
	 O7hPcTJZWw2/tyEWH8Ynfq4NgmfbKYvSjJZqUpK8+BC5J9za2ggJlWG32BbGW/4y6c2qq
	 6mWiOUcHISbHwVRGzzyTQRYCXXgqnzGHz4Bcnc68CloavoW/rIQc0S/R2KS7NXnjq3Yaj
	 Hp8EdSe7+Zpi8h5y7CQEw+jOMtXZwhGdiHyM74DIFy2I5NTmcC3qDrPFADLXIJ31ysw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NQx+a7Vr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEA606A31C;
	Fri, 27 Nov 2026 11:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NQx+a7Vr
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 59BB420002E;
	Fri, 27 Nov 2026 12:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795780728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQQOlPc1FtE9f588BBPhLMGb3qMOxVEpChgmo8GGpNg=;
	b=NQx+a7VrSQMZ6zxkNJCwPUUEfrHACu1zSNQZoPWnA8iu1RBSyErT/ZpwOnNPkyloZxefmK
	7bQoxkmaslJ56DJGU56yUwPHxSzbFvOgxClfKz/JCsag7+ED5jl78DcUEbSPESYXOu2gCj
	eUgqDQHJ9/v1Lj1Z+6yyqHjt7XE/B9/4HD86/YZcU+/PK5J8XpoFj8MnwvV8WHINqrohBl
	3K4iADJVpCQNWMY4FW+5GL5Y95s930nSaDqSsy2QjPEkvbpvGSCwcqjhf4ZMV+sA295TV0
	Wbjxc6CYy7Hbqs+rwXVlk/lKSSK6wZcnwwZ1Hi2eSYQyXTIkoUMtEsR9hsOO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795780728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQQOlPc1FtE9f588BBPhLMGb3qMOxVEpChgmo8GGpNg=;
	b=ggmzWeDJ1qPG9udCZVE8HX2YczCsUwv7iA0cHokjt54p+oWQ1DTzU/3LBk0Y1yt2nmug8K
	GEXmxsexOq0O+5Qo16zqlDoEBgav7KihKx3uS0gWjzfx7clnk3QissxstvafpDG1Jx80oK
	U+qFNKNeEHaYJHjEvFpVhSbFwSGHF4n68PHvx5ZdHj5+6ZoaRQrzOa9av9dykNTK5Uvf03
	WBkbcslCUNF+HyGcu7uoHoLJJTNOmc9MskYzY4T9PJLtOBSe1AiqqmESUlW29VlLe4ZbsU
	fcbfTFmuJb1YRW9lS0WCeErgdAYEPRM4tkvtLfQsIh0OspVZy+WE3t1R/SJs2A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795780728; a=rsa-sha256;
	cv=none;
	b=YLCNb6UM86Asg+YqY3toInqcHbXNGq34Yj9Ih81UCGHJ1vnQUOw72+vxtizitMCQq47gsS
	9ozfGaVHqzXZkWZ4avuubLeOE+spjDnrtoOBu9sfa8fL6W+M9GwEQnhXGRV+1mj6G4O4Mj
	Vk9TWc4hmBx/gCXjJBrpopNU+tGBUVS1/a6o/Ov7HRJb0Wp4HYpy6KBCpAD8IpGvWbR2mj
	NIiWHLqlWIzvSC/r+IXAIQ5am6AKzE5XwQ7zjffyrRrami6cSNbYN7svHU6zAw5lfuZmi2
	/vOrMGoPyGVCYhi49OFtaFAdzrhpnKHlSpknVM4OC6nds6kTv6aNtB6jb6954A==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 3E04D1BF4EE; Fri, 27 Nov 2026 12:58:48 +0100 (CET)
Date: Fri, 27 Nov 2026 12:58:48 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Felix Hoffmann <f3lix.dev@gmx.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH can v2] can: j1939: avoid address-claim timer deadlock
Message-ID: <awlweHXHEtTutiTz@pengutronix.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
 <20260803101503.21023-1-f3lix.dev@gmx.de>
 <awlYpT9xeUW6CCzQ@pengutronix.de>
 <fe95ba74-e195-477b-9ad5-c53d48446ae5@I-love.SAKURA.ne.jp>
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
In-Reply-To: <fe95ba74-e195-477b-9ad5-c53d48446ae5@I-love.SAKURA.ne.jp>

On Fri, Nov 27, 2026 at 08:46:54PM +0900, Tetsuo Handa wrote:
> On 2026/11/27 19:17, Oleksij Rempel wrote:
> > On Mon, Aug 03, 2026 at 12:15:03PM +0200, Felix Hoffmann wrote:
> >> Name the 1 ms retry interval J1939_ECU_TIMER_RETRY_DELAY_MS instead of
> >> using a literal in the callback. Track consecutive failures per ECU, reset
> >> the counter when its timer starts, and emit a warning guarded by
> >> net_ratelimit() on the fifth retry. Five is a pragmatic threshold for
> >> detecting unusual delay; it is not specified by J1939.
> >>
> >> The timer uses HRTIMER_MODE_REL_SOFT, so its callback runs from
> >> HRTIMER_SOFTIRQ with bottom halves already disabled. write_trylock() does
> >> not change bottom-half state and must therefore pair with write_unlock() on
> >> success. The write_lock_bh()/write_unlock_bh() pair is unnecessary in this
> >> context.
> >>
> >> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> >> Cc: stable@vger.kernel.org
> >> Assisted-by: Codex:GPT5.6-Sol
> >> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
> >
> > Hi Marc,
> >
> > this patch seems to have slipped through. As far as I can see, it still
> > applies to net/main, and the bot findings on it are pre-existing
> > issues. Could you please take it, if you see no problem with it?
> >
> > Tetsuo, if I read it right, your v15 3/3 fixes the same lockup. If
> > Marc takes this patch, 3/3 would not be needed in your next version.
>
> It seems that netdev-bot+sashiko@kernel.org failed to review the v2 patch.
> In the v1 patch, netdev-bot+sashiko@kernel.org had a concern about likeliness of
> write_trylock(&priv->lock) failure
> ( https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731134255.1002902-1-f3lix.dev@gmx.de ).
> Asking for opinion from netdev-bot+sashiko@kernel.org by re-posting the v2 patch
> after applying my "[PATCH v15 1/3]" and  "[PATCH v15 2/3]" would be preferable.

Thank you, I missed that. If I read the v1 review right, the concern
about the retry still applies to v2.

So let's keep your 3/3 for this lockup. Marc, please do not take this
patch for now.

Regards,
Oleksij
