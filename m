Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794390371;
	b=u4YqAMpysDZsQQiijRwuXOpkmltRewISx+iiXDU0fbzRRei33qRQ/b+XF8Ot9loUWRTz
	 a1Gv/NSk0xkZIE9PCo5rOnChMJnnQypDf/UPy5QE2VziJKDkvKMj1ZOuVhqwp6kC44yH0
	 JPq0Sn0POPgmy6ejOJX+H+taLwKNVt3QdnEbgteY06ShNUV3T5Ivs/MLpajFzJoAUcsus
	 4+m4eugG+rawQ1od6u9tuB2zljyHGRKihk4I7bGnBcx83Ea3mylb8GQYSfIUJfhxQSTeK
	 SJY8owP/MKfNuRY+TIVkN1ENDzKyrrIlnol6RCOzJpdIqVXI1kdtlI2J8CnmVCAO1tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390371;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ovWDfobRHt7DIfXyNOdO0ei6ZdZhlje9tD9m5zNzr2U=;
	b=1V340JNlkml9WRQkn+XVv1cX6n5YtGv8Nn+uziOX+Uz9YENKNnO9g6MfPZRK+/bT7RjB
	 VkN7tMLAElqlu6XV2dA0Vp1EqeAAHfw3iQfkRywfYcOjug16WwVq/X8EU++blRxM67kbh
	 jSgEpt7G1uXrQrRtCZoCBOei+rJJvqtyhn2jXjLf8KowywNpEch3ZQNaOiPu8vvW53T6R
	 OI5C007din6AZryMkwHHe8bzd91sRdaxgzUtQnbz9ha1WbIGwE8zUDxhiloX1IaMyctDH
	 IK78BZ9ko2uXzQxSB82LkQ3Xd1mg7EcYHM3VbHAu9/RR94QVBiQ2rbNfYXbNmfEixFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="kKJnrW/V";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="mvlj/0hl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C70606A327
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 09:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C70606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=kKJnrW/V;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mvlj/0hl
ARC-Seal: i=1; a=rsa-sha256; t=1794390361; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D4vvq6kSJ6th1F1ezZ3jLZKS7TBz3GaTmHQQ1eCTQlrJJeJyDCDZL1n8RpjPhnHU5k
    FFFXxilDd8+GjTqZsm1TUSGtrZa1Na20PRuZChxF85rSueBiEtZ1HjKUL6MaIkkDkGu6
    BPjHKXGPopiO6HtzHOLX0nGWwogBJw9tZPnTqlp/QtFLzN6nSVSFEWr2h5WrTIgZWT9R
    2Z1GB+A1Iqm0SXgycGB8DanLy0cHe53cOM8gH6o4r8ipezAF1Lk4kPW7+zjasvkrFz69
    9br4vvZV+p9UkIHT0NeTVZJ1LJOxlDXNBd3whb4PHKAQzsdLW7T0xMxkAtu7OIHlQZNy
    AYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794390361;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ovWDfobRHt7DIfXyNOdO0ei6ZdZhlje9tD9m5zNzr2U=;
    b=Br/pvKMAS5l3RQWmdJgGbw26Y+JZPNcxqMgJwN+ig5IWD3P5UZkCvdtuH3HQ7os0Uf
    pN6QDg9GaPDTMhKT7E0XfX3+EIP1VJPqSOJMoRv0AWbmPGXn0OShBNl5ELJvtWmOvLc1
    6ApnAKpsIJ27bsdSpS1BNC3uaIQI9ZDnhOBwyF3e1c9lN52I9Wpwu51I2FtK9GS/otsa
    pSmNOTojyXENpGzN/VT2ny7GTVq+w4v9iT01V0snK4mH87q3ZB31Zoq6g6Dffk1GLizC
    78CLZzpxXDnR9rBusTZuk5+wsBkM8qKYAi1S4gvuhMhn210Wi8N2znlTqdU2oSiH0ECh
    VYYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794390361;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ovWDfobRHt7DIfXyNOdO0ei6ZdZhlje9tD9m5zNzr2U=;
    b=kKJnrW/VjO2WEAkIDQqvjQlCk/srr1X4oOJjNkQ4nctuDJveHA2ii5+9EDpUjOUDB+
    DVRn7t4aJwQleed7lpFymteieUM3qsP+QXaoObYbCWnkfDRhsK0vI9Fpehvw8uLHdn47
    KspCAc0bokPokBAiauWijyUdv4F0R3CDLEXMayfpQpcK3j7SDtNZFFFCJcbF+94hueun
    lZGYtIlNkk8XkEvgOEXMh5EG+ISUTbHs+Bg+eZdkZu+dUi6C5m6lv7PnOH4H7qCTNw7M
    P1CaFaYg6ORdRtVx70+I0suNJy6dC74O5/CvGQkUsakM8tClrybhTGcLwK3wKlT17p5q
    UlyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794390361;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ovWDfobRHt7DIfXyNOdO0ei6ZdZhlje9tD9m5zNzr2U=;
    b=mvlj/0hlltzFDzA30ogOcbvHhG4N6o7E9sTKPDGhhgmWEoVZdhIokQ843fcUuSX1J6
    foCi73Fm3FmPdAtcajDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AB9k14U0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 10:46:01 +0100 (CET)
Message-ID: <ce4a83ba-1eb6-4c39-9634-173b10df1035@hartkopp.net>
Date: Wed, 11 Nov 2026 10:45:56 +0100
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
Subject: Re: [PATCH v3 0/3] can: bcm: avoid RTNL stalls and enable memcg
 accounting
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

I found a solution for Sashikos permanent remarks about the lock_sock() 
under rtnl_lock() in the raw/bcn/isotp notifiers: An own sock-related 
mutex. It is pretty mechanical to change the locks after all the 
previous work to get away from lock_sock().

I'm starting some more stress testing before sending the v4 - but this 
v3 patch set becomes obsolete with it. Please do not apply.

Best regards,
Oliver

On 09.11.26 22:03, Oliver Hartkopp wrote:
> This series addresses issues that allow unprivileged users to affect
> the whole system through CAN sockets.
> 
> Patch 1 copies the CAN frames in bcm_sendmsg() outside of lock_sock(),
> so that a stalled copy from user space can not block bcm_notify(),
> which takes lock_sock() under RTNL.
> 
> Patch 2 keeps the procfs entry of a CAN_BCM socket until bcm_release(),
> as remove_proc_entry() in bcm_notify() waits for stalled procfs readers
> while holding RTNL.
> 
> Patch 3 enables memcg accounting for the allocations that unprivileged
> users can trigger in the CAN subsystem. As there is no specific commit
> to point to, it has no Fixes: tag and is not marked for stable, like
> most of the memcg accounting patches in the networking subsystem. If
> you prefer this patch for net-next, please let me know.
> 
> CAN_J1939 has similar issues with lock_sock() under RTNL, which will
> be addressed separately once the currently discussed j1939 patches
> have been merged.
> 
> ---
> Changes in v3:
> - patch 2: read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN
>    and shortened the bcm_notify() comment (Sashiko review)
> - Link to v2: https://patch.msgid.link/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net
> 
> Changes in v2:
> - patch 1: fixed the description of the stack buffer and described the
>    remaining generic SOL_SOCKET paths (Sashiko review)
> - patch 2: read and write bo->ifindex with READ_ONCE()/WRITE_ONCE() for
>    the lockless access in bcm_proc_show() (Sashiko review)
> - patch 3: keep the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
>    for the filters and describe the local j1939 ECUs (Sashiko review)
> - Link to v1: https://patch.msgid.link/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net
> 
> ---
> Oliver Hartkopp (3):
>        can: bcm: copy the CAN frames outside of lock_sock()
>        can: bcm: do not remove the procfs entry in bcm_notify()
>        can: enable memcg accounting for user triggered allocations
> 
>   net/can/af_can.c       | 12 ++++---
>   net/can/bcm.c          | 98 ++++++++++++++++++++++++++++++++++++--------------
>   net/can/isotp.c        |  2 +-
>   net/can/j1939/main.c   |  2 +-
>   net/can/j1939/socket.c | 12 +++++--
>   net/can/raw.c          | 14 +++++---
>   6 files changed, 100 insertions(+), 40 deletions(-)
> ---
> base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
> change-id: 20261107-can-bcmlock-memcg-2d8ae7361838
> 
> Best regards,
> --
> Oliver Hartkopp <socketcan@hartkopp.net>
> 
> 

