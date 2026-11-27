Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795768374;
	b=1IT4csVBaqsRVXVmhmAD8AcLSzu7WsCPORUnMUfbc/X+oWTc08WbQpFIXoN0E6OYYbMv
	 rOxBuUirfDzIOLKB95WOSdwpymn9TibDUAK5LDbCGq8REXoBz4gb9nA9y2Z5z5tAXJ02p
	 yaTEETmUlfWh5HPpNCTQBVFD2QMk0u9zrP19E3beAO7GnNI3wIqk60sQ7SK07XBatrvwd
	 BRKC11breQ0gqfX6hZnM86mOy/7hMY6O023pHNAltPKBJug476Sda9ywXZyS8U1C9XhZc
	 7dXazy5umU0a3GrSWnVvjF09U8x6OlRi2z4/PmGpjhhh5q60WRUaWc4MMezUQRFo5Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rmzOA9gWp6kEq5dWs0JLUzT5zs05IlV5IEVPf0q6Ka0=;
	b=wE/igAEbxDyprREb+gx6nkwAKSRWovXow4oWdzq5m5F53czaw0pD0514Yj5y68K3IWhA
	 nrdZZ8xeB0SggQJT8ilvYcGCDm0VEjX7daMd/NbGZIEeRZxzcuSmRqVOemnVYB59nLPDx
	 YarbiE5pr+sfyX2nvLnzxUdF3XqnpcmGDtOKEe0h1sckagqxERByoU7maVcrQ77fSYjjM
	 QjQqGVohT/vLBdmRIDQ6hOPLMazdnn8UZMmMrTytVODfYVfeCQkkU4p9h9yTCd/xxuLIK
	 IHI8NOyjUz+o8W4uKRDXZ4nM9MnX991XPsewj9G9LeG/goX5H5d5r4nSisypAgRxzCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CrRS4a+E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987D606A330
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 08:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4987D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CrRS4a+E
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CB9172007F9;
	Fri, 27 Nov 2026 09:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795768370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmzOA9gWp6kEq5dWs0JLUzT5zs05IlV5IEVPf0q6Ka0=;
	b=CrRS4a+E+mMJIVyZoyV5yUHMfqSrPEv22RePlW96A8mcNNS63POV1X+oX0BS8zHDhZVa8a
	Z8exvXdQdZxHF03aDuyY9SJcJ0hOG/RaLgxn+z2/jAfZE/saBAzgUBKO1iZwJ+d8fZteku
	KhFgEEwLw7OGwl6m26yGxcIImsBTUoQKFrC+I6r6sqdccxuBJr7bxW4QEZj7o6TAe+rA1s
	pqhFtG2KPYuTbS3lGeT896E/pzGiBDNnb03A4wrpa/5VHvlWyEpmc/CO9M9BIdD3cdSuAB
	gcdK4WDu10RoGfAsew/Yc7adEc4Kg0Y03xuiWfLgicHjTo/uew2dX/birK8HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795768370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmzOA9gWp6kEq5dWs0JLUzT5zs05IlV5IEVPf0q6Ka0=;
	b=PLSQIQP12hY1vXcjz6P2xTA9fv7ITgLZWAX2KnkAhoMJ1ankZ20J6tff6bPNCf+21RdDLz
	oJajBEeBqlKFLFJyZnAjqvTe42Be4/E7wAR60KMri3TTU5m5zvLT0cYQ+dUtaDfLPf/aer
	5nIDH5xFFVBSqV6d0uhmcRVtXxB1gDxM7ZdAnWeVS4mW5+AA0l1cEJJ8Ed7heLLFlicpFI
	0KyANjvvgTEKgGhIaEaIMKWAN3w0AfAGFP7y0IohX+RX62YePrs2Y+RuUYhvH7WFiILo21
	wFXKybqKc6Cd6DfLyj5BkvUGeWP7kYXIWC4+VAZJhGKEAqwPcP/R6m+JKqNg2A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795768370; a=rsa-sha256;
	cv=none;
	b=GbJRd/RLFKv+AkEKpr8lTe66rNyklEoqG5gruwJ+W90dSru29q89rhR/4gW6srSsfgX13p
	4m/RGIVO7xxcwHyzPBsB8/R020cT43mV+Y1xS4BYW3V5jaGBRHCWrY04Hl+T+h6j1GshyQ
	8PdmcAC2fLkw3KzGnBIXDWRUcWIq2U3rndNGTQAdiwKNrNp8NSGQgMeMWT70n3k2Ysnfv+
	bltr+L/DSKtYctqqzb2lcO+0KM2fB0DStzRpKMlHpoxe27NyfdXfqT5KFJuGl1lYhxDkV0
	w33OYdfKn8NPbIj0NkI0S7KE8dRR7GvWfrCkGUJy3Yb+vTtBHQ7Ra/eKIYsyng==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id A287D1BF4EE; Fri, 27 Nov 2026 09:32:50 +0100 (CET)
Date: Fri, 27 Nov 2026 09:32:50 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v15 0/3] can: j1939: make module more robust
Message-ID: <awlAMlRxN4mly85w@pengutronix.de>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
 <db630610-dba5-4f5b-bd61-09d333132e34@I-love.SAKURA.ne.jp>
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
In-Reply-To: <db630610-dba5-4f5b-bd61-09d333132e34@I-love.SAKURA.ne.jp>

Hi Tetsuo,

Thank you for your work!

On Fri, Nov 20, 2026 at 08:35:22PM +0900, Tetsuo Handa wrote:
> Hello, j1939 maintainers.
>
> On 2026/11/18 0:56, Tetsuo Handa wrote:
> > This series is intended to address the following problems.
>
> Both sashiko-bot@kernel.org and netdev-bot+sashiko@kernel.org are almost
> pleased with this v15 patchset.
>
>   https://sashiko.dev/#/patchset/98c16a74-5ea7-476e-ab36-c98fb77b6be4%40I-love.SAKURA.ne.jp
>   https://netdev-ai.bots.linux.dev/sashiko/#/patchset/98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp
>
> Although netdev-bot+sashiko suggested appending below diff to [PATCH v15 3/3],
> it is not worth reposting as v16 without waiting for your response.
>
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 28f6fa6029ec..f33f40a4c23d 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -69,7 +69,7 @@ struct j1939_priv {
>  	netdevice_tracker dev_tracker;
>
>  	/* list of 256 ecu ptrs, that cache the claimed addresses.
> -	 * also protected by the above lock
> +	 * also protected by the "rwlock_t lock" above
>  	 */
>  	struct j1939_addr_ent {
>  		struct j1939_ecu *ecu;
>
> Regarding the deadlock problem in transport.c , I need some trial-and-error
> for making a workable patch. Therefore, I want to avoid needlessly re-posting
> the whole patchset.

Agreed. A separate patch for the j1939_session_cancel() deadlock is the
right way. You can keep working on it, but please do not post it until
I have answered on this series.

> Will you apply at least [PATCH v15 1/3] and [PATCH v15 2/3] now?
> (If you don't mind lack of above diff, [PATCH v15 3/3] together please.)

Sorry for the slow answer. The patches are not ready to be applied yet.
The bots found no real bug in v15. They only found the old
j1939_session_cancel() deadlock and one small comment issue in 3/3,
which your diff already fixes. So for v15 nothing is left from the bots.
What is left is my own review: I am going through the patches in detail
now, and I need a little time for it. Please do not send a new version
of this series until I have answered.

About the delay: my mailbox is full of Sashiko reviews and new versions
of other patch sets, from many developers. I do not have the capacity to
follow all of it, and I miss things. If you think I am stuck on your
series, please ping me on the list, with a subject like "ping for
Oleksij". Then the other maintainers can see it too, in case I am not
available.

Some general background on why the bar is high. As you have seen with
this series and with your earlier patches, Sashiko and netdev Sashiko
review CAN patches twice. The first time is when the author posts them.
When a patch has no open findings, Marc collects it and sends it to the
net or net-next tree in a pull request. That pull request goes through
all the checks again, and also through NIPA. If one patch gets a valid
finding there, the whole pull request is sent back, and Marc has to send
it again without that patch. We ask for your understanding: a patch can
only go in when every finding is either fixed or answered on the list,
for example by showing that it is pre-existing.

Also, the number of patches has grown a lot, mostly because of advanced
tooling. This tooling helps to find bugs, but it does not yet help as
much to fix them or to write good patches. Most reviewers now look at a
patch only after it passes the checks. With this many patches, they
could not do anything else.

In general, small patches and small series that each fix only one
problem work best at the moment. They are easier to review, and they can
be applied one by one. v15 1/3 is not like that yet. It fixes three
problems in one patch.

Regards,
Oleksij
