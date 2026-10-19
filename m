Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792423741;
	b=LEXN4JXALROiC6DSkm/EVdOqH7jEOcqmh7sVi9aYvoFFOWe2BowJ3P4dDGQhyRWVVrQz
	 /3SX+Zte9oBIpkQmkQ/dzurmzXCX24aq+50/AJP64tLIP4Y+KS3e3RqsZ0tGaT+miU1+W
	 yERZ/sOnFImkLMYSl0Iz3u47EhtM4LIq+P//MV43s5vqmvt4H7mMlby+6XqmlRpainXQ0
	 7u8Wu0fFxKvuooNK5AnVNwrXzaWQPptWDvi6y9CLF6Tku6osVxUyRf5DmARn7GbzxGBqs
	 O58+tKyxHoEe3SRQ6s+X+pl5i8hmUyAUsblqums0C+LuEXGIol+YGdDLUf2J65JZh5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423741;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aO1mqHh3W8kkH6YYVsvAqM9uvV55hc0mi4bVNpb+qaE=;
	b=qmOrktR21mQCb8JW3Ck1vxKgNAmOd6207I2bfXuWzHt2d5W3+7X25zAoXekIvELBkugF
	 eFmTk7awbg0E6QDRzcLRv+jqZTnVHhIKBLqa2r40RX8CLwQyRjVgfL8OpX8xUn+viSVv+
	 0sMLE8UbmlFRDIFM0I8fStEuqRUdLTGLV146ht3OVm9kv3A0LjGnEmzMCocsEW1npLNnj
	 TUvpfzYK2QLyaHALPJl/rKcmzRTrFG0G+L37A16xVoCyX/UTHzrHs39NmTD9MH+xrs0Bv
	 yqXSgR/qMwi6O5IA8Y3iF1SjFE4R/RYjhcPsa3GNGyl810cmZTHXJG5Ur/gbWM+kH5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=S+CUDrss;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=B2ZY32QV;
	arc=fail smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0C6098A00
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 15:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF0C6098A00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=S+CUDrss;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=B2ZY32QV
ARC-Seal: i=1; a=rsa-sha256; t=1792423739; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PvbFGSQZ5plaooGrlariXFiw8RmPgVwfptvLIvdDJwbcPSems6Ai6Y3sOYfkXXXTz8
    08v0qpYlOy62qL+RarLCYWJti4/+os8BIhxI9GzV6X9/04MBvdQ6qcDL8hbnjRrnoBVG
    Xwmi5AcEWoC7Pg8w+yP31c1w+Hjix6azKpQqBq+2r8XKorktNYd7N2redWGUhq9jXqxj
    3/CczThHAyAnsGWueNe7Oh/wDeGjd4A4cGqieAdx5tdvtkSZ0LYeVMM1Ck22QDKr3bxr
    orGktmDyAv4rp3OBc58QZSKWAllRyb9Wyuwg6RuE02D34ZSEU0BOaldG8ax7Zt18VSbp
    MuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423739;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aO1mqHh3W8kkH6YYVsvAqM9uvV55hc0mi4bVNpb+qaE=;
    b=A1SQyM5YdvGi+f4/bDzxvcw3oi31OXoIvMggK8iWhsInstjOcyelbOiXerWIqCYEsA
    mzG8XrsTU90p2QyzB9oNkNrNSECXVACCpOW/j5LefmKBkWFLMz3vO3HF3PhJ6Hy0gevL
    Ny3TttM3HJ2Ef1Wykq9rDsbr/cXp2NQ0HsGWMSCZLntJbn80ptPYGGpQXqtZIYSNHGj8
    oN5htCuIMDghFj8SgLQxJSuT0SkGSsHW1GxjWYEC0WbsQyK2LH4ZJOvx87cnwW1OXHqj
    E1dHXDljp869AKZ7ywxJ6MDWnZdbTIXwVsKCn8BRD1rDV19AgBdF9sReYIQ2FdneJBpy
    ymTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423739;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aO1mqHh3W8kkH6YYVsvAqM9uvV55hc0mi4bVNpb+qaE=;
    b=S+CUDrss8OcmTbdfMcwaDai5NTDw4CGbVLFa/sGWCeEW8lVsKidJ//CnFgH9nQ1vh5
    v1d4Y2RRrPGvi4G0JBrudP3BWC035Lxjj5HBRBdwJphyGmEbYaBTDVLDER+owL2EZgIu
    Ya9CR/hBAG3teWr4nEsM+tbjsanpKGtD9Fu5FEXxF3C5+4xiWhZ9QscAHxk07iyGmVgz
    JlJ3NQPYFgkUDxkGMgON5nRLJG0CU9BdP8GAvLpG6wv8gGo+ueavYGAvz8s6WOTtkACi
    IajJ6G1LF7jdr/GPgJ2HyzeYWJqhUs1zAeDbxQpkcN1hawl1+ChpUSQaG3QDvC0Sv4/t
    u/eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792423739;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aO1mqHh3W8kkH6YYVsvAqM9uvV55hc0mi4bVNpb+qaE=;
    b=B2ZY32QVXPZGdlHBbkVLH/1D10yntABzhHaEe1lAJIL8VXfxaBnLy7UzPy6nvBquKt
    ipaj61StLFFtCFnjK+AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFSxXZm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:28:59 +0200 (CEST)
Message-ID: <103cb851-9e54-471a-900a-2683d817bd41@hartkopp.net>
Date: Mon, 19 Oct 2026 17:28:58 +0200
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
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
 <4c81a8e3-431b-4d18-814b-e09cdcff0b18@hartkopp.net>
 <20261019-supportive-coyote-of-efficiency-797bb1-mkl@pengutronix.de>
 <20261019-gigantic-humble-aardvark-4273f1-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261019-gigantic-humble-aardvark-4273f1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

can: raw: remove redundant NULL check before netdev_hold()

was missing in my tree.

v4 is sent

Many thanks,
Oliver

On 19.10.26 16:52, Marc Kleine-Budde wrote:
> On 19.10.2026 16:49:52, Marc Kleine-Budde wrote:
>> On 19.10.2026 16:46:20, Oliver Hartkopp wrote:
>>>
>>>
>>> On 19.10.26 16:12, Marc Kleine-Budde wrote:
>>>> On 19.10.2026 09:42:39, Oliver Hartkopp wrote:
>>>>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>>>>> triggered when a CAN device is moved to another network namespace while
>>>>> a socket bound to this device is released [1].
>>>>>
>>>>> Only patch 4 is new. Patches 1-3 are already on their way to net-next
>>>
>>> As these three patches "1-3" are not in your current tree anymore you can
>>> simply apply this complete series as-is.
>>>
>>> And on top if this series you can also apply this
>>>
>>> https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hartkopp.net/
>>>
>>> to fix this sashiko-bot remark:
>>>
>>> https://lore.kernel.org/linux-can/sashiko-outbox-176764@kernel.org/
>>
>> It doesn't work for me. Please send a _single_ series on top of the
>> testing branch, which includes _all_ patches.
>>
>> regards,
>> Marc
>>
>> | $ b4 shazam -s -k -l -H --merge-base=@ https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hartkopp.net/
> 
> Ok, that was the wrong series, but
> 20261019074244.50391-1-socketcan@hartkopp.net doesn't work either.
> 
> Marc
> 
> | $ b4 shazam -s -k -l -H --merge-base=@ 20261019074244.50391-1-socketcan@hartkopp.net
> | Looking up 20261019074244.50391-1-socketcan@hartkopp.net
> | Checking for newer revisions
> | Grabbing search results from lore.kernel.org
> | Analyzing 11 messages in the thread
> | Looking for additional code-review trailers on lore.kernel.org
> | Analyzing 19 code-review messages
> | Checking attestation on all messages, may take a moment...
> | Retrieving patchwork CI status, may take a moment...
> | ---
> |   ✓ [PATCH v3 1/4] can: proc: reset pkg_stats atomics individually
> |     + Link: https://patch.msgid.link/20261019074244.50391-2-socketcan@hartkopp.net
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |     ● checkpatch.pl: passed all checks
> |   ✓ [PATCH v3 2/4] can: proc: remove pointers from CAN specific proc output
> |     + Link: https://patch.msgid.link/20261019074244.50391-3-socketcan@hartkopp.net
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |     ● checkpatch.pl: passed all checks
> |   ✓ [PATCH v3 3/4] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
> |     + Link: https://patch.msgid.link/20261019074244.50391-4-socketcan@hartkopp.net
> |     ● checkpatch.pl: passed all checks
> |   ✓ [PATCH v3 4/4] can: protect the receive lists with a per-device lock
> |     + Link: https://patch.msgid.link/20261019074244.50391-5-socketcan@hartkopp.net
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |     ● checkpatch.pl: passed all checks
> |   ---
> |   ✓ Signed: DKIM/hartkopp.net
> | ---
> | Total patches: 4
> | ---
> |  Base: @
> | Magic: Preparing a sparse worktree
> | Unable to cleanly apply series, see failure log below
> | ---
> | Applying: can: proc: reset pkg_stats atomics individually
> | Applying: can: proc: remove pointers from CAN specific proc output
> | Applying: can: replace ARPHRD_CAN type checks with can_get_ml_priv()
> | Applying: can: protect the receive lists with a per-device lock
> | Using index info to reconstruct a base tree...
> | M       net/can/isotp.c
> | M       net/can/raw.c
> | Falling back to patching base and 3-way merge...
> | Auto-merging net/can/isotp.c
> | Auto-merging net/can/raw.c
> | CONFLICT (content): Merge conflict in net/can/raw.c
> | Patch failed at 0004 can: protect the receive lists with a per-device lock
> | Resolved 'net/can/raw.c' using previous resolution.
> | error: Failed to merge in the changes.
> | hint: Use 'git am --show-current-patch=diff' to see the failed patch
> | ---
> | Not fetching into FETCH_HEAD
> | Use --resolve to enable conflict resolution
> 

