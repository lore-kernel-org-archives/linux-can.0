Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794376393;
	b=YZE6++W02befxIsO/wSeaxeYzhLeceFiGSAffkA32Vh8z0KwH/mbjOxXttGF6sgfAxiu
	 TgiROPxuPuwU59JL5iPW2uy4MlQGnVGg15THUEoFhnSCKp4Xv7FETbF46ltrk4O4MCtFj
	 wjaJG8fHYqq8Si8tJG3yyPHHAY1Vh8GbpFRCZo6yT6d/BfVZ+5jLOLvLLI5+fuWVBlUrz
	 SWqsmTz6q9OrGMXSKvTrVAO8f2PGJr05AU95qHbJwKPZwD0c7XinehD6oW93P+56+sviI
	 qq+lcJML0dvOJb5o6irkwUfDcyxPQZ4eyOaZ3CBXsMVHNGJ750UcIo2uCEYdJUZaKXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=li7BCG6ejq/8Rt0GJ74/8s2kndGFg8iIv0Lf2Gro7kg=;
	b=tq73IM7d2UKCk3mYJiSQ8ya1uFv7v75fxOkRjiJ/a8Aezey8CpKFlvOZKBQG4T/0U6yP
	 F2TzqHqGe0R4AJWO/P9GcXY5JNlXCRgrnrcgKpLhWK7gCgY3BUn56nzkSGmYAGmsXEt4V
	 kYe8DLVvFsyiee1YHFe+IQs1ZydnHF3/dzQgOExlmpH+gJ0kuEUy6xLL5fPdOPn0+6/li
	 2JhtiPN28WAuRx5NDVuv5NpNGWsG43mbcBFQxfEklT7uS/i1K018tGUf01MA5vs6IycXx
	 pyysSdOgzm7vr3rFyFcFY0YuHkA2lXhZUR8QrP2/2BfdwJAnj2TD3Arqeeymggqt4AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PZqfRFP1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B16606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 05:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PZqfRFP1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1F13D2017D7;
	Wed, 11 Nov 2026 06:53:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794376389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li7BCG6ejq/8Rt0GJ74/8s2kndGFg8iIv0Lf2Gro7kg=;
	b=PZqfRFP1Tdvne2qZ7vS4zn2aM9eEv0BfKWxplIWhNxBrE3VB753aU8zu8rjnRM/O693m+M
	fe2/G92SXZtf+jHPNWqQ7uVzfvVAcoy5ckNJtQd6aoeXonCfkilPQHn5o3d8ARyQbhR1M+
	bD5kBd48aYnTLrnrEsjIjL7uLjIWkG4cIBcOm6tSJy/91Dt1Uvne6zdmHFHNahCJdp9avB
	4Jd+S3ZjgvPoFfWQ4G4xyDLhl59eFJ4z1z3jfbO71wGVOGfO/R6a3PVgtbWmKCa93SR1PT
	2TSTcgIdSuBbsguKVMFMQenduCjx8hoLPuTSPPeQdWycJeEpbHpl6xEHq5X9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794376389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li7BCG6ejq/8Rt0GJ74/8s2kndGFg8iIv0Lf2Gro7kg=;
	b=PUbkT1sy4uctXZlphuYXailUoyAnJexZLGrQcyTgSzg9zjEK86q+U296O+hhtflSTRorej
	Me8z83EEhl2NnB0rgeu3LWqGV0m/7WJtEgrffUtxF9CXwDHjnEdqzr63uKpD4gPAFqfK2i
	Me88sNPnCFcDDWR5e8Cr8LrzkxTFh7wNS8tIbtBZixNBV52y5gyl8yO/6CA2AvNACPcz3M
	pW40GBP2NKafOdYdTHrwKjfCURhFDxgyM1+K2v5DuWQXG4C/hMktlAtm6GE+mCVAV+/bP5
	FjZhbTw8+hAnHKtM9p/0xRlxOwV2b3JCfJFBA6m0J3SVtdsPUhOBSnzii77TxQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794376389; a=rsa-sha256;
	cv=none;
	b=ZEhOHktZ6WExCWwhppf6I8AmOy7I1SRQ/nmwm10rJ2TZW7IZO7CfSDYumOPMmj11heaQa5
	o13TD+pHi2xp5llkdKyDNTMumHEizufCNBMw0+P4R4YrzpbU50izVUzynQ0IMm8HTbEuhd
	s/NAQPQaFEj51BCnkd9NccqvJQA+IvBIS4UcsHyjwYouWYWqHTNs0Uigtq8LIZnomGCRuj
	bLezlgh0YYyfKbLCLjvc5T8DZqI/eQziI9musKME0yvPKiYrbigVzBBgYzaxmqkW9ylF/q
	hgoVG0JRWuHtQYLdekmB8yBFuVT3ICF/ZFvh6fOOdeLIT+W92pdkyfRhb2cglw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xR1Gf-003bR0-09;
	Wed, 11 Nov 2026 06:53:09 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xR1Ge-0000000FPR9-3wTJ;
	Wed, 11 Nov 2026 06:53:08 +0100
Date: Wed, 11 Nov 2026 06:53:08 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-can@vger.kernel.org, robin@protonic.nl, kernel@pengutronix.de,
	socketcan@hartkopp.net, mkl@pengutronix.de, bst@pengutronix.de,
	lkp@intel.com, maxime.jayat@mobile-devices.fr, ecathinds@gmail.com,
	vega@nebusec.ai
Subject: Re: [PATCH net v8 1/2] can: j1939: account for timer references
 across rearm
Message-ID: <avQCxNIDeBaTsX2c@pengutronix.de>
References: <20261109131624.276943-1-zihanx@nebusec.ai>
 <20261109131624.276943-2-zihanx@nebusec.ai>
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
In-Reply-To: <20261109131624.276943-2-zihanx@nebusec.ai>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Zihan,

Thank you for your work.

To avoid duplicate work, please take a look at this series:
https://lore.kernel.org/all/a1dd9760-7815-400a-a39c-a1a03cf8262e@I-love.SAKURA.ne.jp/

and sync it with Tetsuo.

On Mon, Nov 09, 2026 at 01:16:23PM +0000, Zihan Xi wrote:
> Rearming a session timer updates the existing hrtimer rather than
> creating another callback. Taking a session reference for every start
> can therefore leave references behind when the timer is rearmed.
> 
> Track one session reference across each timer's queued and running
> lifetime. Apply the same accounting to the RX timer and synchronize
> rearming and cancellation with terminal state changes. Arm the simple-TX
> echo timeout only after a successful send, and keep terminal session
> transitions from leaving stale timer references or changing the result.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/11143
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  net/can/j1939/j1939-priv.h |  11 +
>  net/can/j1939/transport.c  | 510 +++++++++++++++++++++++++++++++------
>  2 files changed, 438 insertions(+), 83 deletions(-)
> 
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index cf26352d1d8c..123622c82a98 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -10,6 +10,7 @@
>  #define _J1939_PRIV_H_
>  
>  #include <linux/can/j1939.h>
> +#include <linux/spinlock.h>
>  #include <net/sock.h>
>  
>  /* Timeout to receive the abort signal over loop back. In case CAN
> @@ -290,6 +291,16 @@ struct j1939_session {
>  		unsigned int dpo;
>  	} pkt;
>  	struct hrtimer txtimer, rxtimer;
> +	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
> +	spinlock_t txtimer_lock; /* Protects TX timer lifetime state. */
> +	/* One reference pins the complete queued/running timer lifetime. */
> +	bool txtimer_shutdown;
> +	bool txtimer_ref;
> +	spinlock_t rxtimer_lock; /* Protects RX timer lifetime state. */
> +	unsigned int rxtimer_cancelers;
> +	/* One reference pins the complete queued/running timer lifetime. */
> +	bool rxtimer_shutdown;
> +	bool rxtimer_ref;

If you add new variables, pleas use __guarded_by()
https://docs.kernel.org/dev-tools/context-analysis.html

Thank you!

Best Regards
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
