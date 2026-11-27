Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774633;
	b=iXXY5mr32WcOT/zKBJgyUuUMiRnSs82FAm+icQxVwRZZflh8oWYpE7Dw71ddRpJyvyiZ
	 PnaxkQ3CUfDqoJ1oL7PyTJWEnzRKmP6eYIzcDBJf8HpF+LkuE9FedPvPOjBLXtP1jR76r
	 19CmILBURuR+OiPFoQR3vv9lLhfN+uY5RnvNdPxdPK8RDkyR50un2j0Wq6uglE+0DTg+n
	 q57j74sCtohSq2zbc+Urr0bUeaTvmTIfN+67Z9JkyVM4as0d6lmLJFqxxUB+CYEMxuvee
	 3SbNYqlXnHMgjjeKT6RT/Ue+UzFl3aM6lb2nB/0RkLc2EnOoHt9YH2Sj/DXk/cOI6mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774633;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3je5ddJviowAbh/sbfjbagu55lq/fJaJCY7wYe/xJEA=;
	b=AbpinW37Ft30fl9QZGmqhTIVO28VJLLV2a3mh5kr0dgmkOlG+fBMuMwYmsaCzLai8dYi
	 sRhUmMwjo/dC+b82ZQlEqUUwa/NFEOBKWV1hJWfWh+Ce2bnomaaVJZzi0tMzLiWGL6KG5
	 xXuwnby4ZzdZ/XmY3HNoV1UGAhPAqp1m+iM/p4VVurZn5gpYcung1gqwsQxpi+oO/IMH+
	 GIQOTDIgToajqKPZRJ3ARmxU2N7RN9Pr3jF0iyjYLDij0xzkwoMdOJN/5l4gwkhE/k4Mf
	 xyro5xaA3ZvegaPXXKl3aiPbDEmxHLycjO4rF2hqqtw0udEEbscf+A3SJNymNWgUpeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=B5KOkurt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036D606A323;
	Fri, 27 Nov 2026 10:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3036D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=B5KOkurt
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0D049201923;
	Fri, 27 Nov 2026 11:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795774630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3je5ddJviowAbh/sbfjbagu55lq/fJaJCY7wYe/xJEA=;
	b=B5KOkurt4Lc7VUOt/mqYURseiDM9DDsKqNHkpy9Y+1bYNcCliTDNzfitkuJQcpaQ1EYMM7
	H1X9FvAaoDvlyNvU4u1PkqYWAxQi7PVjhh8kDpgh30GGh3DTH12iolgDA6lKdvZw8PYvAI
	H4r6APpe7tki09URf/K5yGoX+5t0mCJ4j5CR/N0jyuDJg7wyrVMKQrGlDWKfGanbea9KAU
	TNng8QnJrekCkxOH798h7HHEB9ZlFZ94eM0YIwYuTxgGW0ADuF3/2xiK3/fgKjEXCYbnzW
	Tif2J2txrGexi2JXUX8i8Jq2veQiIpaM/wP6y4pYN4ciR4IWPbh6xXlN0CmvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795774630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3je5ddJviowAbh/sbfjbagu55lq/fJaJCY7wYe/xJEA=;
	b=gG5T+WZd0FoHnSlop387J27bOoM12DTlRsqGWpx8/lWuZmOvnEbeicL9gUcQFxBFhKE6/w
	ljK8TDzelZ3AD6D4S6yhyFcFYbg/acD2gAImuFNdEKY4lAgRv3cN1TDGO2Bh4OKjlO7XBt
	xpwRwpZ66VPG0huffNdjgvGdmb7N2DC7wzZvj2jxSPBtqWvUNCY2S5cSxHurY7LaSyB0Nb
	k5emqZdfznTnTqXzipnIwuuGPFz1D6J2Om/9WDQWrTNEmn5nkekLq63BhELz28Hp/Jonh4
	tVrClaodMVM5a1TUpYV38iHE691YD2ZePXjLz7nVxbaJgYlFuyV+9/cVv8xguQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795774630; a=rsa-sha256;
	cv=none;
	b=M226J1WgGTEim8UYJ1vkG619p1dWArYtbZBGA+H/qZl3nW9U7s6vA4kGTuoyYh+vPsPA5M
	7pqSRQT86ju1ITMnVjG1H+svISHcRC51DXdY0a/cEhOBx1X10nJ/1/1+1W78FD68Q6/nd6
	y8PgDNkCm1eTQdjtN8V6YxYHcXGv8s8GEd7fXJTfuEsLY6xZHYgH5j74LviXKiJkXJRFqq
	2fS6A1DPy/1uKmZr208JvcCpi+uduWQM4rO3LV96kFI9UuBd0Gfy44CEyMx55IwXQK9O8B
	yb4Hf/8QhhjvvX/AO/fphco/M/lKws5hobkxzfPG1ynAD98yJP7jI2gLwB8law==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id E33701BF7BF; Fri, 27 Nov 2026 11:17:09 +0100 (CET)
Date: Fri, 27 Nov 2026 11:17:09 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Felix Hoffmann <f3lix.dev@gmx.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH can v2] can: j1939: avoid address-claim timer deadlock
Message-ID: <awlYpT9xeUW6CCzQ@pengutronix.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
 <20260803101503.21023-1-f3lix.dev@gmx.de>
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
In-Reply-To: <20260803101503.21023-1-f3lix.dev@gmx.de>

On Mon, Aug 03, 2026 at 12:15:03PM +0200, Felix Hoffmann wrote:
> Name the 1 ms retry interval J1939_ECU_TIMER_RETRY_DELAY_MS instead of
> using a literal in the callback. Track consecutive failures per ECU, reset
> the counter when its timer starts, and emit a warning guarded by
> net_ratelimit() on the fifth retry. Five is a pragmatic threshold for
> detecting unusual delay; it is not specified by J1939.
>
> The timer uses HRTIMER_MODE_REL_SOFT, so its callback runs from
> HRTIMER_SOFTIRQ with bottom halves already disabled. write_trylock() does
> not change bottom-half state and must therefore pair with write_unlock() on
> success. The write_lock_bh()/write_unlock_bh() pair is unnecessary in this
> context.
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT5.6-Sol
> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>

Hi Marc,

this patch seems to have slipped through. As far as I can see, it still
applies to net/main, and the bot findings on it are pre-existing
issues. Could you please take it, if you see no problem with it?

Tetsuo, if I read it right, your v15 3/3 fixes the same lockup. If
Marc takes this patch, 3/3 would not be needed in your next version.

Regards,
Oleksij
