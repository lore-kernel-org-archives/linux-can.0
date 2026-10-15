Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E74AA004
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048312; cv=pass; b=ag/h9R5+3tXujcaH2REHAyUEnw+0P7PqshM8Bst3uh4D2KTC5aTjF1Z7AC78JDDxXDtWVjk8zuQ5Rns0M7uXCdLr4x1Yr3xvIiAoGS30u/AqYLHazQEls1iVU5fdCRWkoD4umSCdrSVnVIXXfR24OaPvLjqwCHt1vu40UbpBdsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048312; c=relaxed/simple;
	bh=jq+zfJ3ECLVr3biYxfSr8PI9fNDQc9f/cLsYaUwEbnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYo8FWSj8Fn5kMbJNq15RrWEvX2kmfsz6Mg345drou3GqBrllWoXla7jZQGSpcrWdEKEhaVRsBs4stbOQlJgxSwB7niKXsNBOtoppmYF1f+9O0knYpwVccqgdD6PCF3wd0eiBQcXfsWcMt0cSFtszRUk+g46JmGQdfjjUKRP+pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QJPhavDm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iIV1m2V7; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QJPhavDm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iIV1m2V7"
ARC-Seal: i=1; a=rsa-sha256; t=1792048294; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gk5XXpyH/v5CkOSfNrS4dkL7toLAE899uzaenjfvHl7u/niNc+HwleOcUIForz5kk0
    HPYGE+dbcY8kIuIse3cwwg9bOTlegJVLNOCrzyyuAnkwWFwob0ern8l3bcOtXLwyVm8y
    NgbW5OJWlV/s3dubM12eL0Phz3nhqltqB43hOC61NoCaMqayWd8XQgFh28M/gXBxALQ0
    RyKBUygNXvdTZbxVTC0sT3EC8FGF0IyKjcIFgxZWwtjeaDUo8V4d9DKD3i3vcfJw9Nla
    zUPMlzccLOYH70ZBVtQtyNymd8GT8O5Klah8tZU9xDEIl/zAIAIvge/KW9Mmors7Zk38
    S5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792048294;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IrPI34EuSJU59TiXBScTBwjaHWq9aiMaP7e2zoIGVWM=;
    b=gSSMYY+JNCTzpqy69fgqK7Cv6Dw3LTaDFWol0SX6fXKUsQCiEL1Gs1e54al9ilL70D
    JGdDpPEl5LIyRWglIuYVJqNy/gwHzHWphDS9zDLRGVZ2E4XGTgDyLuz0BFWxIhfFIYT0
    Lwa+CuL3sxkNQsbKQMXDWPTubPAhkh+5O7TdwFKgOZhyuESkp5pL7lwqESWyAesjeSMP
    wKWmz1p+vCVnSeW43+0ynAM0AJpTGuSSco6wsqmk7tAdc/y5C3pkKL45Y2uaTT2ee5pZ
    0OkyczsF6W6/wCfVJisfhDeIWM3UXKX+9SDEvsO7MZ1AaSR6vgIpGcqcTWmt0sWyciqT
    AlKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792048294;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IrPI34EuSJU59TiXBScTBwjaHWq9aiMaP7e2zoIGVWM=;
    b=QJPhavDmWjiaXI35E27w64ssXVWRG/9F9ypyNp646b466Tp7tr87p6mXxJtsmA0+U0
    TO/HNOIOBQXsvs7qu3ivLU/kNQIGUf1AHfP9QsvnSdGfql0kjLPQ/sZ2P9LHB9KKXPM6
    GZCqX+Qusp5j+ACUXd0XUz1AZ8KDFzehoMDnvpifdCGHtMQ9ka3ddq3Uxwv2auc9waj6
    KFNWjq4pfIkhfLRbMV51FrcbwMJHP+p0ukX5Jd47p3y8j2OJIF5EX/EMnhhu4bbHabs6
    4XuhXDVVummKaoisihxNB7AptanJvgOxpdSdaVnEWfbiVOSOqr5XDWvg7P186s9mLJ/g
    tXBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792048294;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IrPI34EuSJU59TiXBScTBwjaHWq9aiMaP7e2zoIGVWM=;
    b=iIV1m2V7XhLh7VM+2hkctK26Uk4x9if3KWEfcYuFJa7L395uYUIZfvzNx3iQ0H3fgL
    iGkegw3m148LHbli5DAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29F7BYG8c
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Oct 2026 09:11:34 +0200 (CEST)
Message-ID: <b97d2d43-9b2a-4091-a019-aea6b990341a@hartkopp.net>
Date: Thu, 15 Oct 2026 09:11:34 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next] can: raw: take rtnl_lock() before leaving the
 notifier list
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, kuba@kernel.org
References: <20261013115557.114582-1-socketcan@hartkopp.net>
 <179202612843.1406898.1976844402266899912@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179202612843.1406898.1976844402266899912@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is an old feedback.

Corrected patch based on this sashiko review is already on its way:

https://lore.kernel.org/linux-can/20261014142114.280279-4-socketcan@hartkopp.net/

On 15.10.26 03:02, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message for raw_release() (net/can/raw.c) says the
>    change is meant to "Align raw_release() with the isotp and bcm fixes…
> 
> --
> 
> can: raw: take rtnl_lock() before leaving the notifier list
> 
> This commit moves rtnl_lock() in raw_release() so it runs before the
> socket is removed from raw_notifier_list. A concurrent netdev notifier
> then can't skip a socket that is being released. Under RTNL,
> raw_busy_notifier can't point to the released socket, so the busy-wait
> loop is replaced with a WARN_ON_ONCE().
> 
>> Align raw_release() with the isotp and bcm fixes for the same window and
>> take rtnl_lock() before removing the socket from the notifier list. As
>> raw_busy_notifier can not point to the released socket under RTNL,
>> replace the busy-wait loop with a WARN_ON_ONCE().
> 
> [Severity: Medium]
> Which isotp and bcm fixes does this refer to? The message has no commit
> ids or Link: tags. In this tree, both of those release paths still look
> the way raw_release() looked before this patch.
> 
> isotp_release() in net/can/isotp.c still calls list_del() before it takes
> RTNL:
> 
> net/can/isotp.c:isotp_release() {
>      ...
> 	spin_lock(&isotp_notifier_lock);
> 	while (isotp_busy_notifier == so) {
> 		spin_unlock(&isotp_notifier_lock);
> 		schedule_timeout_uninterruptible(1);
> 		spin_lock(&isotp_notifier_lock);
> 	}
> 	list_del(&so->notifier);
> 	spin_unlock(&isotp_notifier_lock);
> 
> 	rtnl_lock();
> 	lock_sock(sk);
>      ...
> }
> 
> bcm_release() in net/can/bcm.c has the same busy-wait loop. It calls
> list_del(&bo->notifier) without holding RTNL at all.
> 
> For isotp, this window also seems to matter more than it does for raw.
> Suppose dev_change_net_namespace() runs in the window (for example,
> ip link set <candev> netns X). isotp_notifier() skips the socket,
> because it is already off isotp_notifier_list. isotp_release() then
> calls can_rx_unregister() with net = sock_net(sk), and that returns
> early once the device has moved:
> 
> net/can/af_can.c:can_rx_unregister() {
>      ...
> 	if (dev && !net_eq(net, dev_net(dev)))
> 		return;
>      ...
> }
> 
> Wouldn't that leave receivers with data == sk on the device's receive
> lists after sock_put() frees the socket? raw avoids this only because
> raw_release() passes dev_net(ro->dev) instead of sock_net(sk).
> 
> Could the commit message name the isotp and bcm commits it relies on?
> Alternatively, it could be reworded so it doesn't suggest isotp and bcm
> are already fixed for this window. As written, the isotp and bcm
> changes that are still needed could be missed in review or stable
> backporting.
> 

