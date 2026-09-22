Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312353ED0A;
	Tue, 22 Sep 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079645; cv=none; b=J953WKUPVOcKe4lBizBGPzpnWJeSpoRJxU3poE0g/4s9kFHySxjuQOrF15cdZirH/nj6ZjawrrLSbsAVIMjszag6svKaa2fcZKT0USLmRlzdwij/oHXAGU3sOZ8L+DED1gkJrk3O7l+ljBjEbnPFox0guOuIqos31uj7SXyetTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079645; c=relaxed/simple;
	bh=kRLHycinaMLdarpjWa+huFAtjSJzeqoDKcPD5Y/LEUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz6nIeXqWiKUKkahG2dKwAbBLHpXqZVP7d8rGh6c15N6nSRbn8qeqOYyUw/h7Zuq9Txx/41ulb3vvgEo/pIxjz0fMbKvhBltJDNhXBu9PMnKcVpXjiZ8nhxQ4iGbf+7wz8aHKfSYdo9c2K4OcvYFu1aIEZ5+EeoKyKoNEKKpRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfhINh5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfhINh5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ACB1F000FF;
	Tue, 22 Sep 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079644;
	bh=lnbAaFcbUuyEf5z4nx7NXc5Gs0Oi9a3ZSHa0+UvAExo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfhINh5w1gckN4yEnwM5Mk3fDKz6Shw2CCE3WQ2kmHTrMLlTDGWVBQZB52FpNmujd
	 GX00nojwf5pWnG7vSXbXC6K5+sfWdiDdkr3zJn+ED1RZbh3ZMrjYlQ08rov2TMKX7R
	 DC+AkqMGNGqizjTAyFbE3BhqWFM+LFiNaN3dEZGPVkQfInSuJp4BrU+lMU5B+8z5QI
	 W7dgzLECuC6+8jXRxvXjDGwVklZQ3HPj9CxsZso166bOsrQJul06Wr0M60f+jS76b4
	 vp931u0mcJpHIXtNe1LMxaJfmB7kk3DdAy16nTxXv8tUg8UW09Y946im9MtD4+lK4V
	 Rk4sMYxUv9q+Q==
Date: Tue, 22 Sep 2026 13:20:39 +0100
From: Simon Horman <horms@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, mkl@pengutronix.de,
	mailhol@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
	socketcan@hartkopp.net, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: j1939: return 0 instead of user value in
 j1939_sk_setsockopt_flag()
Message-ID: <20260922122039.GE13925@horms.kernel.org>
References: <20260919213632.3313825-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919213632.3313825-1-benquike@gmail.com>

On Sat, Sep 19, 2026 at 09:36:32PM +0000, Hui Peng wrote:
> In `j1939_sk_setsockopt_flag()`, after copying the integer option value
> `tmp` from userspace and updating `jsk->state`, the function returns
> `tmp` instead of `0`.
> 
> If a caller passes a negative integer (e.g., `-1`) to enable
> `SO_J1939_BROADCAST` or `SO_J1939_PROMISC`, `if (tmp)` sets `jsk->state
> |= flag` and then returns the negative value as an error code from
> `setsockopt()`. If a caller passes a positive non-zero integer (e.g.,
> `1`), `setsockopt()` violates POSIX by returning `1` instead of `0`.
> 
> Return `0` on success in `j1939_sk_setsockopt_flag()`.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

I agree that the problem described exists, and that your patch addresses        it. That the but was introduced in the cited commit. And that the corrected
behaviour matches that described in Documentation/networking/j1939.rst
for SO_J1939_ERRQUEUE and SO_J1939_PROMISC, the two users of
j1939_sk_setsockopt_flag().

   "The acceptable value size for this option is ``sizeof(int)``, and the
    value is only differentiated between `0` and non-zero."

Reviewed-by: Simon Horman <horms@kernel.org>
