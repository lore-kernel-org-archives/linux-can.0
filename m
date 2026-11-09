Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211784;
	b=ewxFCL7MYmvJQMZGtj2475oq6ANhZPeQcjZyDk+6kJZCw6FE2bFtjawAz0jk0xQogVHk
	 9afMfHkNGnV4on3GsFn1NSR5ikl2rxTtEY5phX2GwMA1ffapjztiqgN4Hmcc6belz5LMX
	 ixDFHchQpBwwVfw/0UlP0Djm+zWdl2q0TgdzWUZiyVBa/5cp7c3F4v0GLzUqEIkEoER1M
	 lLmzDmAIXxQ09H9IsBy9n1RbrsdL/BooUYRn3vsp1i4n7fZxp9kMWqIROcbwBzws7h45l
	 o/YEjNvYRSalhpI4C51CZdTw5zLgUUXsPZWS/tw2nA9ViDCJaibNnSkPgWz8c3WveGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211784;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+nvwKWOPtP8ye5cgfRg3inbN2Oo/Em0pSOSTBLb9Kyo=;
	b=sQLUkRZ1ZJBoKVgnG8LNpkV1rjHJjFwjjBA7JaRSc0MweXJYwCihVKvlhvOZA0bUpH3Y
	 fRrTziwtXshiIIOMkl1j7EZe5QYh1m8fQJbG0dljyb7fFojJ9ERqWDlpw53TuGTmRqwzB
	 k3ygyf6OFxjsizpChPlvvH3vWOGgvzWpBr35nUVc79HjpTUp5f7V659xnABsStb7nTctj
	 DdoQUJMTdnT2sqBI3+CI1DlJzfpMcFiZ9OltVv3DkQzYpgXjWBp2G8MgPTomkjPb4cTk6
	 uvaPsErId+V7rVLuAi+QZT8NNQj4dIaMa0V8KVXwMaT6Ypf+l+ZgIe27kh3x3RCBS1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UeCIsoHz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7YeOGNP+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F5606A331
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 08:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94F5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UeCIsoHz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=7YeOGNP+
ARC-Seal: i=1; a=rsa-sha256; t=1794211774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lMhgTqivd7aAn3cq4Ubh/oF+Xp00TbP/aufveqH7VUprZbMiJ2W+naO6WbOH7xGL1Y
    nQbfszl6zghvobuhpoPpuWK9yiO6vYsxbOaB3V8v/osHXMmMrUUghdUkF8PaW8aI99Uw
    kUZeuof/RWUSpBmUz812DuwQ+lFxsmr0xKpwnyJH+YDH8QyhYgsl6wXIDSebL69sm9ST
    4vOxlVj8WhWqEPcIoc7LA5nsX+0eab04R5bEInZAafZ3rnTrYwTx/hvfkuB4mKQRWGbo
    7ZmQyM7Bfca3GpIcuoDAZhMKi7xs8wqD4nbU/TD6ZDfikfnrWvUxdlIhvHMpod7Zkwnv
    DBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794211774;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+nvwKWOPtP8ye5cgfRg3inbN2Oo/Em0pSOSTBLb9Kyo=;
    b=L7pWC/7p2lkQDb6ExZ32C6Wcu2Gf9rEmhmyYR0bomyOHON40gqlwQrb4CKEjzWH/1F
    HmotBFTRPBmlQt5uIvgWca/T25epnWLig27Usf/7yei9kJsnDhsn2BInSrzIkhL4bAcs
    nS+uUEDoAtoLgcXEO91ofp9LOoowY35vktHWC54s5bu43nVb73Nr3ZY8tTHijXSrvQpj
    jot+nK9BbgNqyf+BGuz4UbchofNhGCucIASc7NQHijf/vdNBJNNgYvD4kmKG10lAHFE5
    Bk0LigkNcsbX4IM/vcKpAtMPexnNssKQCzC/hgGAMLRVUIRKcK9oS8atCpo3idyCWt4a
    BSnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794211774;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+nvwKWOPtP8ye5cgfRg3inbN2Oo/Em0pSOSTBLb9Kyo=;
    b=UeCIsoHzKqSDGamFIGXNBSW2q8/PoS+AluLHjNF/C9r9pQob5tw2G4GREt2DxzXHx8
    VAuHOkMaPvd+QF6c19drbbDMPw4yd0ked+y/bH+jTKBdt3txoHxy97DnkRUG5NomBH9q
    dcns23Cgx1I/a/mb4WsoMAk0kRLwjqtp6LN9mnh1vIeDbOh2kH5jAeK/mgG2oSMdAbzz
    rs2Ybz5O5gTPB1tBSgqKakNL3RIOBSQfOVE0gjSp432pHzOsOnLogYTiZjHJZFBXj1ay
    Df+ATHE1MWCKMzklbGmohWtvL10sSz7pyrEFNA4OuTr4w+Xpl8yqtBgw0TwWaXBOrxpz
    FXaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794211774;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+nvwKWOPtP8ye5cgfRg3inbN2Oo/Em0pSOSTBLb9Kyo=;
    b=7YeOGNP+uXwgMFSa/wXYMqpR72e5Jocun6EUS3r1UR5dhkffxffwEi4xEY14NolkN/
    sxWCX+ShGqjRqVns9IDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A989Yqo6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 09:09:34 +0100 (CET)
Message-ID: <3a3cec52-dd1b-46e9-8279-c59766566eae@hartkopp.net>
Date: Mon, 9 Nov 2026 09:09:33 +0100
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
Subject: Re: [PATCH 3/3] can: enable memcg accounting for user triggered
 allocations
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
 <179419070981.488853.12589743168030293362@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179419070981.488853.12589743168030293362@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.11.26 03:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch says it accounts the j1939 objects that unprivileged
>    users trigger and that live as long as the socket or a related object.
> - [Low] The patch replaces memdup_sockptr() in raw_setsockopt()
>    (CAN_RAW_FILTER) and j1939_sk_setsockopt() (SO_J1939_FILTER) with an…
> 
> --
> 
> can: enable memcg accounting for user triggered allocations
> 
> This commit adds memcg accounting to CAN allocations that unprivileged
> users can trigger and that live for the lifetime of a socket or related
> object. It covers socket structures, receivers, bcm_op frame arrays, raw
> and j1939 filters, the isotp TX buffer and j1939_priv. memdup_sockptr()
> is replaced with an explicit kmalloc() plus copy_from_sockptr() for the
> filter copies.
> 
> Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> 
> [ ... ]
> 
>> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
>> index d9384cf0e356f..77adb817b36c8 100644
>> --- a/net/can/j1939/main.c
>> +++ b/net/can/j1939/main.c
>> @@ -128,7 +128,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
>>   {
>>   	struct j1939_priv *priv;
>>   
>> -	priv = kzalloc_obj(*priv);
>> +	priv = kzalloc_obj(*priv, GFP_KERNEL_ACCOUNT);
>>   	if (!priv)
>>   		return NULL;
>>   
> 
> [Severity: Low]
> The commit message names j1939_priv as the j1939 object that bind()
> creates. Is the local ECU, created on the same bind() path, meant to stay
> unaccounted?

The local j1939 ECUs created by bind() are not accounted, as they are
allocated with BH disabled and their number is limited by the number
of bound j1939 sockets, which are accounted.

Added this comment to v2 commit message:

https://lore.kernel.org/linux-can/20261108-can-bcmlock-memcg-v2-3-19fafdfc9d12@hartkopp.net/

No code change here.
> 
> j1939_sk_bind()
>    j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa)
>      write_lock_bh(&priv->lock);
>      j1939_ecu_create_locked(priv, name)
>        ecu = kzalloc_obj(*ecu, gfp_any());
> 
> gfp_any() returns GFP_ATOMIC here because BH is disabled. The code is
> still in task context, though, running on behalf of the process that
> called bind(). So the softirq reasoning in the commit message ("can not
> be attributed to a process") does not seem to apply to this call site.
> 
> The ECU holds a kref, a netdev_hold() tracker and an hrtimer. It stays
> alive until the socket unbinds, rebinds or is released through
> j1939_local_ecu_put().
> 
> Should this allocation get __GFP_ACCOUNT as well? If not, could the
> commit message list it with the other deliberate exclusions?
> 
>> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
>> index 50a598ef5fd4a..c832465876049 100644
>> --- a/net/can/j1939/socket.c
>> +++ b/net/can/j1939/socket.c
>> @@ -716,9 +716,14 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
>>   				return -EINVAL;
>>   
>>   			count = optlen / sizeof(*filters);
>> -			filters = memdup_sockptr(optval, optlen);
>> -			if (IS_ERR(filters))
>> -				return PTR_ERR(filters);
>> +			filters = kmalloc(optlen, GFP_KERNEL_ACCOUNT);
> 
> [Severity: Low]
> memdup_sockptr() allocates with GFP_USER | __GFP_NOWARN:
> 
> include/linux/sockptr.h:memdup_sockptr_noprof() {
> 	void *p = kmalloc_track_caller_noprof(len, GFP_USER | __GFP_NOWARN);
> 	...
> }
> 
> As well as adding __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT drops __GFP_HARDWALL
> and __GFP_NOWARN. Was that intended?
> 
> Userspace controls optlen here, up to J1939_FILTER_MAX *
> sizeof(struct j1939_filter), which is 16 KiB. That size becomes an
> order-2 page allocation, so a failure can now print a warn_alloc()
> splat.
> 
> The same change applies to the CAN_RAW_FILTER allocation in
> raw_setsockopt(), where the size can reach 4 KiB.
> 
> Would GFP_USER | __GFP_ACCOUNT | __GFP_NOWARN keep the old behavior for
> both call sites?

Good catch!

Fixed in v2 in j1939 and raw.
+			filter = kmalloc(optlen, GFP_USER | __GFP_NOWARN |
+					 __GFP_ACCOUNT);

https://lore.kernel.org/linux-can/20261108-can-bcmlock-memcg-v2-3-19fafdfc9d12@hartkopp.net/

pw-bot: cr

> 
>> +			if (!filters)
>> +				return -ENOMEM;
>> +
>> +			if (copy_from_sockptr(filters, optval, optlen)) {
>> +				kfree(filters);
>> +				return -EFAULT;
>> +			}
>>   
>>   			for (f = filters, c = count; c; f++, c--) {
>>   				f->name &= f->name_mask;
> 
> [ ... ]
> 

