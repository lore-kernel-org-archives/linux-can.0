Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BC50B429;
	Fri, 18 Sep 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752841; cv=pass; b=DDpGMYbLOAFBYrTHUIv0NFloAifdlzp7kfcsJEk9mx++LvquhSWpoiAYnIoi7jm2sQCea7g+MmdCcmCNHmdAOUdvYdI3HPxKlKFc2/eupVnzc/V9sdbtX+1JGeaNLb1yk0Q8epy/GNN61Adyhh310Q3ZxHpkYxAUDPfTJCsMrZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752841; c=relaxed/simple;
	bh=8tTAq7PRpppAiq9MepwRR/uRrA5oR+wi/G59SzwmcOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRXWo5V9EuRQCemJUFmX2pYn2rjDdkEcy0iDekUDGegI8WuYhv7QEzBmKnLx4XqEY5noLdgD7WZ5s0qSN2JNE5kaP0KXRxKACIujatxw65sEJtPzYH1otADEWA4G0G4V+tAgmhKyOBwddc6oz03mvD09M2YZB8tf90DeXM1swWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ytf7sL9B; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mUOzr/Ox; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ytf7sL9B";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mUOzr/Ox"
ARC-Seal: i=1; a=rsa-sha256; t=1789752829; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UQnKet5JPe0MfvPZ97021x9NBtUsKYgAGsap/vxAgLFfU53gOhXlPeU7bEbkErB7w+
    axr8MvyxO4y5usYeehB/w+q5wDU9puSrQURZq7hR3wT/3FzqgLwFfWbpPa54JRW/sMpf
    D0C2drVk7pQ176w1nNXYv/32n7Qh6cz2HXGKvnmNDZFxjG4dbXfEuPmftuek+oAYs12v
    3871tJlSdW6tjxww7ktk1IrTzUKev3YCZWSRdU7wu0xy5C4uoy1jFvosjYTq/14ywsL4
    c+FRRqhjcQ3pUecmkVPuso8WNlyVsjuNnzFX4PPkvvEryTIXc3Ra2gv5jGe4lDDnfRHw
    mm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789752829;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7XCBtEtkyelPTljLc+XgN49+abBN2ROpCTczSEx9sJQ=;
    b=WywTT95Ppo4/phRPT3x4yFP59YFXzM/JURAWMOfi1hdyDuGRcEPdtBL7j9aCUiKAof
    5m59V7BmUpjNHkFq162NAnSJl1ee3+RNk9/Q10fZQbu4ryQCLzwt4weGF84x8Z04p+Hw
    NDGO8Gio7EaDpsOeiTVwysPMlgSS9kDwYKbMhKvcPdtsON2BbJQDVbc0+QUoXQ7vlw2w
    GqNgTX0XWZqv79PbymiIjwpvuAnopsp6QV05zo85MJb6DaIAGLEP34PJ8LlUESI0nG88
    m1TVzPhq2dFDL9FRUvfxYD6n5uiC0BFLEiYQ2yXnYCJyC0mv7G3bBQQpvZrAX7K0Y9aC
    kCkw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789752829;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7XCBtEtkyelPTljLc+XgN49+abBN2ROpCTczSEx9sJQ=;
    b=Ytf7sL9BV7V6ipwZY/oigCk8tXYAFb7LtzD2Q9EP1YILjBC+HaIRr7u6VXA+sM4mLD
    i1MhFeuXgtrDGAw0UJWVuCuAFD98BALTIN6FsdpG4oEpzqO0S5iMOqJnmaWg/DxgWplt
    TCZyeL0vypWinSMTSLGDJquI7cNoe/kHbzgNzJvCBYBT/OhJ4JuQo/EAvXzgnM279fYJ
    aNes8p1Y2dRUKErcTQUpBtF09zy+VzoIjMrCc/wlVS9MCK56a2vClZIPT0TIe3H9grd3
    n0TFDnyRPUCCNmwn0uAni//sDyfrnZMPsZ2+5yt6J6UHrk5WYbzpGEDdbUd/uQLAfRHG
    PlFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789752829;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7XCBtEtkyelPTljLc+XgN49+abBN2ROpCTczSEx9sJQ=;
    b=mUOzr/Oxy4HoCSZNKczpOI+X7UIE8Ikw5UOXHXz6q8jOB3xSKpNyd2Y4soKXd/A+2K
    1gngOrEKvrvQSu7nowAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tStBLZ9Neyb6Xno1pYqM="
Received: from [10.91.122.125]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b728IHXmkvw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 18 Sep 2026 19:33:48 +0200 (CEST)
Message-ID: <490282e1-a6dd-40ee-8be7-0a311b2b0141@hartkopp.net>
Date: Fri, 18 Sep 2026 19:33:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: fix missing skb header initialization in
 init_can_skb
To: Shaunak Datar <shaunakkdatar@gmail.com>, mkl@pengutronix.de,
 mailhol@kernel.org
Cc: pabeni@redhat.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+1aae11dc8d42ec1a87ec@syzkaller.appspotmail.com
References: <20260918151606.765490-1-shaunakkdatar@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260918151606.765490-1-shaunakkdatar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hallo Shaunak,

many thanks for your patch. But there's already a fix awaiting upstream:

https://lore.kernel.org/linux-can/20260917123716.63116-1-ndaugoing@gmail.com/

Best regards,
Oliver

On 18.09.26 17:16, Shaunak Datar wrote:
> __alloc_skb() sets skb->mac_header to (typeof(skb->mac_header))~0U via
> __finalize_skb_around(). skb_reset_mac_len() checks if the value has been
> updated via the skb_mac_header_was_set() and fires
> DEBUG_NET_WARN_ON_ONCE(1) if not.
> 
> init_can_skb() previously included three header reset calls:
> 
> - skb_reset_mac_header(skb)
> - skb_reset_network_header(skb)
> - skb_reset_transport_header(skb)
> 
> Commit 9f10374bb024 ("can: remove private CAN skb headroom
> infrastructure") dropped these calls which leads to the skb->mac_header
> retaining the original value.
> 
> Restore the three missing calls in the init_can_skb().
> 
> Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
> Reported-by: syzbot+1aae11dc8d42ec1a87ec@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1aae11dc8d42ec1a87ec
> Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
> ---
>   drivers/net/can/dev/skb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f8..9cbddc1edd41 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -210,6 +210,9 @@ static void init_can_skb(struct sk_buff *skb)
>   {
>   	skb->pkt_type = PACKET_BROADCAST;
>   	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
>   }
>   
>   struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)

