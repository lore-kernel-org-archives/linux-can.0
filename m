Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3F3C1991
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773061; cv=pass; b=JmgUml7w5UmuWC8zgc+rqjMcrbgMsVEcFwL+lDvC0PmzI2lDgcVLXLVHqxkAn0LKDnCXG/hB9UfOrnVP+L8uoh6gKqoj7anSo4reDRJKBzrpRbKJfJcdYzYro+Yb1uoixguxzxLm5LTxLHnRc7ytZK6e7hIPxHuVXn/Xh5jTZyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773061; c=relaxed/simple;
	bh=rM0Xs92mMbgG2mokifGwck6lF2tL6AF3RH8p/73yz+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DD8cDB6ybIbYlWaUhrQ42+1X/xRqRYXgLj9NBqNPAb7Ujci7/btJBIPxTpu02DfYTNKoCJ7/scMAm/PW999GxmT5ZodsCOKEF7oatbThW9gk2Cy/ftTgze7Ap/RDoMvTCvPYRm8VwcGYk9nmyKxIbS1gTWmh7D8aXCxBu1HyJpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TQc8OEN7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZzJBTUap; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TQc8OEN7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZzJBTUap"
ARC-Seal: i=1; a=rsa-sha256; t=1787772859; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eKCXVmSfxxGL6NkV0FNthmMTZU38jMoceZkXa7nrn9KMhMz/Siv/aVcnS9UGw6XnEj
    nlh1FdI6q4r+4sM7Ri+R1YRmt1DcLGiNHYtl8H3J/zMAuWY1nE0nUkJKnQE6qt19PfJa
    jGZaoG/dvNi1l4Id+UwCt2QyTKVUlHuBZB/KxxQPy/pcrdmEVBJfJtaRSf6y2yoFdEzN
    ZCzKGoYrSxU9WI8CE0i4o0cQH2RKtzQD29Ezfy0E/zTxrvR4UyZhmUdZ6wNA2UzIKhCy
    yQ41mMGE1MCxu9fiZMzhjOCwoBHtsgCOE+S6VvyVSRFt1A5ifaACia+wXicA8TdbDnqE
    dFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787772859;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eSAr9nugo+JENP+20BsbkVNkLnI+d28H8lYZqqopOts=;
    b=gSCjD4p6naCPqh+M3O6WCiu3CS647TVHQbmU6X2TLVFrL3Z65D7e23YcgQ9UzUKp7M
    uFSVjAvzorKJ6Cf2EKL32PALjTqMBxt5NuMJBP9W7snM/xwGtJPo6MYiQN7mKtqID4l6
    1wzfZQoCTWMmzJD8gq8wcbA8osrWRWBrhQvxBV/63rMZM9Rn+mflDj6zDu3l/s82uGjC
    m6IWOm+lu0i302oZBtHDt8XFGaFSvJsbMY4T2jYp4WEvDuAgX49Fw9u4z/0fGcxcj5Yy
    p767v8fomgVCxJv2OJq3AeF+2WDKN4TtowXNjscdg3K/vOGG/K0jBqxMZMwMS0gEiFPA
    oaHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787772859;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eSAr9nugo+JENP+20BsbkVNkLnI+d28H8lYZqqopOts=;
    b=TQc8OEN7Z83yeKn0UDrdpImboN7gcIh5DKAo7qh7ZpnW+rvr6Gg05yqOkgRL5sGqyM
    uWUyEy9FH1A9u+X6JQ6Or93KsUEWy91NR9Mf2oWX/tMEMPyPkU41sOtLORPT5HWBEPQm
    TiKv45DXNN9grT71B43OHdKyIxNoLjlHfQBBGIY3dvV3WZ4SDd1wDS+8vugxTX7BEYZB
    xpMfrk1XsMDi5lQyl1SGx9LXdWyix6JwsXPH3RJrzC+RVbI/AoztwXr0mUWTNnIuiE6m
    H7GjNDwdOFJDIn4qE7obfQ6wXbGVVc8KP9qW2vbBYPgCB5eluF7fPu0HwuCqTfYPLKG4
    mI4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787772859;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eSAr9nugo+JENP+20BsbkVNkLnI+d28H8lYZqqopOts=;
    b=ZzJBTUap+6L5+ACq03oiujXzVu0SECz5sAYI4EpmvfnpNSi1NvtEOekIlYcxX1KKXL
    S4lRjW7itLAlqIGfpMBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727QJYJwGp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 21:34:19 +0200 (CEST)
Message-ID: <574090ae-dbe8-4b06-bb6e-7e0cdadeace9@hartkopp.net>
Date: Wed, 26 Aug 2026 21:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260819160822.8256-1-socketcan@hartkopp.net>
 <c3fc21b4-db28-4323-b182-eeeb646e64da@hartkopp.net>
 <20260826-loutish-cinnamon-macaw-e340a9-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260826-loutish-cinnamon-macaw-e340a9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 26.08.26 13:43, Marc Kleine-Budde wrote:
> On 25.08.2026 16:55:39, Oliver Hartkopp wrote:

> 
> "net" or "net-next"?
> 
>> [can-next v2] can: proc: remove pointers from CAN specific proc output
>> https://lore.kernel.org/linux-can/20260815103400.117175-1-socketcan@hartkopp.net/
> 
what's your plan with your other %ps and pointer hiding changes?

Are you going for 7.3 or -next ?

Best regards,
Oliver
