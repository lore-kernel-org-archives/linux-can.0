Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3F3C10A7;
	Mon, 21 Sep 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003803; cv=none; b=fgGtFlzwFhDjDKVVdZRuertiCzJIz58ngs5nO69j2w2RSbGffGSZC0Nmd2KJ1jU+BPa/hHrd68VUNsheAeD3uDVlgXSqyn/uZJ+aHysoUgD9QcCLbrBdRShT1Uu4sUTcUQi1ig++hmp+Mbhoezp6u95NfB/XGyrdIUjCHSuzlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003803; c=relaxed/simple;
	bh=Pg5VEff5i1rvVDDO/MxihnPCp0qQadifV5FfV5mvDMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0GT51lQD/AvbpDsx2u6q1+11YUrQDp1S201tnb9F9Vu9Xxxg3sIEHtX0WsqM1622Pzpx95/778x73nqWXPwYmvBANb9TSivy8p09EPnS/2EzQN6otk+zTyug/S+E/MafYwJszIa8fQj8MSQj3FOjIwI3Caa6knuZanMiL56KsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp7rPuxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp7rPuxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4443B1F000FF;
	Mon, 21 Sep 2026 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003802;
	bh=SkAgRXfkGQEnSKiYblRspGKrygagzeP125FONgyB4a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jp7rPuxM0EZXEf8o5CS2+uOsRggFUFyZVNeeg+XtMpSdLetPdx/hragVEyOXPuTpM
	 gMlssG+VYTZJLeZZSZG2IrPpTxMtJrsO7D2arNHcp3/Yj5DOk7BpmLvqEVTCDcyP8G
	 Cgvpg4ALRDqLDbwRNSWS+RCIqzHOudgx7EftyXPCIx6vb1S2MOZwsjXSwa8+/7rEXr
	 e24GvQjHdpt/6xUQGpqMAwZkugvuUGWR32l/Kgl1FLO5t7YVN30AzMkscBy+ZgLcrF
	 4YCPH+LDQ4vricwCXE9TlPIgeJPu1SAl3n1fRJ+Wbo3CIFs50tTFTU//5JSgQGopgv
	 kK6J3dZd4QQWA==
Date: Mon, 21 Sep 2026 17:16:39 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: linux-kernel@vger.kernel.org, robin@protonic.nl, mkl@pengutronix.de, 
	edumazet@google.com, kuba@kernel.org, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, davem@davemloft.net, o.rempel@pengutronix.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, socketcan@hartkopp.net
Subject: Re: [PATCH] can: j1939: fix transport session leak and socket
 bind/connect validation
Message-ID: <arFKVEcb4lJKBG6G@quoll>
References: <20260919223427.3881575-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919223427.3881575-1-benquike@gmail.com>


On Sat, 19 Sep 2026 22:34:27 +0000, Hui Peng wrote:
> Fix two issues in net/can/j1939/:
> 
> 1. In j1939_tp_rxtimer() and session teardown
>    (net/can/j1939/transport.c), ensure active transport sessions and
>    skbs are properly cancelled and released on error or timeout.
> 2. In net/can/j1939/socket.c, validate socket state and address fields
>    consistently across bind/connect/sendmsg.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



