Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058187;
	b=dMmoKVaaaHjBbo7myI4dGC6RMlCtl6ZE/VKI6+vP2Ek6gz/lwBzuhdv3rbvT9PQauRSH
	 UkGPTJAeFRbaJjQOs8pTc6wFjfhoZOLJR5JG5ykcS+BiS7L9jafl/IpUMRb61y1rWCDpL
	 ugyvWqyXNhp1czT+9Db4G1h+JVe4z3nB9bYQXGvESGJCb0ay9XdA6teVWcQNuV5iP5VJE
	 uH182z/zkQkFOQAfXxcpbVDIkh8WOc9NrXL+KdZFw4IPibg8uHgHfLUpg1WM6+t+9J8AX
	 iSdz3NwX+wEGK1yMrc53Gn902HCbb3315AVqFVdurTINchhFxNNPFiozMJKwoSwLl1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058187;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ou7V3YVgbiThd8omXKtFtFH/VUYarWOFDxFfgSseEQw=;
	b=GXLonP4vobsWaNfqOq/0GjveRHg9H3DXjMg5CsRABsrlgk1LtcrTKe9FIUgvjQzISo+a
	 +8b0Z11gv9bCMz02Nt4/isn+o4XbtNWbRONR+1V/Dak76bA/ThuJ8c5eC3PNm42yZ8Yf7
	 NTzWXTSNK6xMNyoTWttLjQOxTKzZZOHLO6y1OEX41r8Cfg05bQlJbt0A5Hsn1hl5rmWKE
	 e1vXv7yoGI1eVAttFe62jAgpu0JgRSDYKYzuJt2QOaCiYmijUw3y3dfBaokeUPISaF9eB
	 BEIC1O1em64R9dr8eeSbOCNIw+5qqshskBCnbUTigoZUTtRj836pkyT3Gl8ZFxwPF1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Edaj90fN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RtY3Yq0a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A665606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A665606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Edaj90fN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RtY3Yq0a
ARC-Seal: i=1; a=rsa-sha256; t=1794058167; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aFfXLhOgdVdwiGKamCnkmuZmDvc405EB/H5WvV8JOf8kysWZu15TzZsVCHULswpQ20
    o9LH08Ln/ZDQvvP6rFxsRhImU+b84eDqvX2Fc4U2EHSAnB/p7KJUG6ajTYbozECPWZjz
    AV8f3Nc9IkUZXHVbOsttgngdlgR3iqf+ZUlWySDTox8kP1DK4yY8LlRZJ0Bl837hfsMw
    z4iHfosiaDTt0F9iTgS1kh+gOLGB3OwkD66LiPBT3GU0/CzsyL7dPtgyMJOOjruTgs92
    ujD2xtHVd/I9QYkgIHpLqJd2syzwXH5qvl5Eg2FFRLIDh20XgapX/CvmbFGPjwOrX9wf
    drnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794058167;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ou7V3YVgbiThd8omXKtFtFH/VUYarWOFDxFfgSseEQw=;
    b=tnk/4UvvG0lrQVuUHqTzAZsc9CPcK6jeE0dhK48pChiXSx0VNYA1fOoVJxk7HSa1k8
    IAAhcmHYufY6WUgRsAYxpWqdMTxoHN2RjacfgfzgZDBP/aitNOGDy81HfluxputctjPC
    4QykJZLkTVls1uMFCTiGn0DRWRVqBVPgoHS22pOsU1SsLjBmuEdBrhzm4azuKTyYgKi7
    A3Dph/zh0+0Gvd7iftBYgXIFsh9peI88wvi+As9XdqWRqC6sfRtj06h+Sv3rc4xfu73T
    t9sTnAmgzgZppSxYcrZyVzlR7BHKB4SU9mDJmGSXxo8+dbQmX4E8UcDfP/4f/GJgR8/z
    64Ng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794058167;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ou7V3YVgbiThd8omXKtFtFH/VUYarWOFDxFfgSseEQw=;
    b=Edaj90fN/0tmKp9djotKKUP1i9IAUJ2pJupNswq6Zfvjw8cAqpYkH2z3XtXsh7HCnY
    fCHDTUcG6BiqcO7uCKDyBmslak1wz65Q1I9jUxdjWaUzy7rKuvJYco3jK2Mk7KFsJrQ6
    Jrx8IP12vIyJbjfK12CTpTQdAoa1g7azu4GPyMq7Jx5NnwexcOV51hEGU7MhKroMe9m+
    qcEgub0SVMk6EDMBhq56jPnoz3BorsD165jSEZq9oX4r23X0DwRHEOKjeQ7fe2EBMBzu
    E6x7VVelroO6KtGWySoK5ixcD1hfABajGcMVHrIdSUiq5kEKy3U1D4lorhTa34/1AelL
    eO/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794058167;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ou7V3YVgbiThd8omXKtFtFH/VUYarWOFDxFfgSseEQw=;
    b=RtY3Yq0aeRO1TXeOOtz1l4R9Cb3lxJqbOEF2JuKKFN+M4SP4bY3RNR0GcHXxtTGSMO
    aj/ylyspe7MVOFda+yDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7DTRlRO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:29:27 +0100 (CET)
Message-ID: <8ff77616-1c44-474d-8f3f-aa23d2aaa12c@hartkopp.net>
Date: Sat, 7 Nov 2026 14:29:21 +0100
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
Subject: Re: [PATCH 1/3] can: bcm: copy the CAN frames outside of lock_sock()
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
 <sashiko-outbox-202903@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-202903@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.11.26 14:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] can: bcm: indefinite rtnl_lock stall in bcm_notify() [1]
> --
> 
> commit 21cad73125ec2cd172e1d3266d5282c5a3ca76be
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: copy the CAN frames outside of lock_sock()
> 
> This commit copies CAN frames from user space into a kernel buffer before
> acquiring lock_sock() in bcm_sendmsg(), preventing a stalled user-space copy
> from blocking bcm_notify() under RTNL.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 7bd2aa39777af..9c39f7363ca59 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	if ((size - MHSIZ) % cfsiz)
>>   		return -EINVAL;
>>   
>> +	/* Copy the CAN frames from user space before lock_sock(), so a
>> +	 * stalled copy can not block bcm_notify() waiting for lock_sock()
>> +	 * under RTNL. Only the frames the opcode handler reads are copied.
>> +	 * The handlers keep their checks and read the frames from fmsg.
>> +	 */
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can bcm_notify() still
> block RTNL indefinitely in remove_proc_entry() [1]?

This bot is really not that intelligent when it isn't even able to look 
into the following patch [2/3] of this series, which fixes exactly this.
m(

> 
> When a bound CAN device is unregistered, bcm_notify() is called under
> rtnl_lock and tears down the socket's /proc/net/can-bcm/<inode> entry:
> 
> net/can/bcm.c:bcm_notify() {
> 	...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
> 		...
> 		if (bo->bound && bo->ifindex == dev->ifindex) {
> #if IS_ENABLED(CONFIG_PROC_FS)
> 			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
> 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
> 				bo->bcm_proc_read = NULL;
> 			}
> #endif
> 	...
> }
> 
> Because that procfs entry is world-readable and remove_proc_entry() waits
> for active readers (pde_users) to finish, a local user who stalls a read()
> on /proc/net/can-bcm/<inode> (for example via userfaultfd or FUSE) causes
> remove_proc_entry() to block forever while holding rtnl_lock and lock_sock().
> 
> [1] https://sashiko.dev/#/bug/linux-23a32da5-4d8e-457b-9e84-376ce500a113
> 

