Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492914A60F;
	Mon, 28 Sep 2026 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597806; cv=pass; b=fnk4rDDCB/Qe51HeelUedkdiieoAoQJQWehe2vDz896QyIrdY+Jp0TFv6Osd29dYIJM0hqXhOWcONUZtTmBlxYgn/L7Ndcwx/wTNwrSfZ7lzfBXRBGwa65z92O1n57MCPkIxY3nMpcvG/Nh6KE0GVoE7yKbyIwP3cN1M2zR1ZSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597806; c=relaxed/simple;
	bh=/2evjd2+72ZQewLYViyHpo7Db1D+xFI86negJxGswDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+drrWQOghFpymvC+93zODrB/glZx3Jby6/rQuf1EI4hQ2YA3pbOLGDkSNJs35+Ur1zxcBwSi7dfWdjXc6eqRptoObCk+eePwaH/HXacXaPAKhg13hrGFpBfRwWuhqtQ/uCtXOyZp4W1QsAOYp0Qe6cpNPmJrcfP/naw31cmM8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pc3n+X0/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ynuGiXLl; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pc3n+X0/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ynuGiXLl"
ARC-Seal: i=1; a=rsa-sha256; t=1790597795; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RinegyyW7BlPh6jipTBsJl6XjNzehnC4W4kMg0bfVDbFIlvhufPQPue+/PoTL+JQdL
    jjYwJvdfKy6+DhClhQZLQ/HcioRGPiIkml3mqPW2p9Bk83b06aTG3dmNfwUoeP1vFLO1
    ReIeHurnXyKDBxZGa21P5OfM7kmyzOEesyDKOybjHV4E9az4DMmXQ5GfNE03RwFPLVwg
    5V7673wiJsleH6IAoRq+cNiJsULW8pLvcQYlbMNQfzvOST9LKsijTNgGXWyjhBbVylwO
    pgQi8anpEFstab/wY1N7D6r+I6pXCNhfHJRLHt9wrycSC3R/1ftCJjSDWNTcGTKizlWe
    5j7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790597795;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2An1qy9oy7UwD9iyloKVnzVLllLnxZ+90/zNaHKPmkQ=;
    b=s6JnTjlhQuGCArI8+8o9WGxTYuQRf6FOj6fRoN0GFnFLNs0fegqtTXhPqj/3fsXJ/a
    FQxCWP9XkjhiBZ2o4zftvI7FS93JRpbciKL00TxpnUuPGgJ0GpnXRUU1ihr1mu/lFP/w
    Aq5FSH5nPEZev+1zoDHYwqW3FTOQl3C1PRKvgYyzczDsmta7vORI0t8xAhfSDYgJ7g1N
    4P3RrY0owe9fpF0HCXHZr9kDD9aQlelaA3HmGxxA1FGKZVOCKGhBje4MMBPB+O06Ldt3
    55clRBYGiFZJ/0aX3t+iun85TnN//MeRoUK7ArziaxD/KReKxHyF3tVOuiT4VCuo634x
    oqIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790597795;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2An1qy9oy7UwD9iyloKVnzVLllLnxZ+90/zNaHKPmkQ=;
    b=pc3n+X0/Tg/SlxHEWXhdyhaIdcjXVffC8WSFchD72uo8V6YJ+1CGY/a3hiM1+3iYIj
    wCOIdulStp8ZGzs67rq4PXCRycKovBIoqQWUv5SEo8dAPvzbZnXV9tEhHPt4PGdF0Zwe
    mqwz/YPNtCF7AKRmlntLH0T2hHa4HFE4f8UYISDxATEPzx/FHmb1YyaundiHnO1Lqz8Q
    e5HA2F2km6DrJM6q05fwVM/QdaW5JVm96J6QPIv1YpIh5SMQF1pz45nPifVmbKMBI1u3
    A80k6FQ2EaQwBzomD0pV44l75WIQ9jQz1bs8+7R2ooaR/Egx/heCGO2Iot9Jrzx43gfC
    47DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790597795;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2An1qy9oy7UwD9iyloKVnzVLllLnxZ+90/zNaHKPmkQ=;
    b=ynuGiXLlW+BM2PZhXwGO2svH5hQeDnuFZUEPdMxHA6D14/ZSrf6+hv/Pgh9n9gY+9T
    tY7RsiKqxC9syOK1EGBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SCGZLUt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 14:16:35 +0200 (CEST)
Message-ID: <9216a55d-957d-4f7c-b67a-6093a1917faf@hartkopp.net>
Date: Mon, 28 Sep 2026 14:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] can: RX frames silently dropped in raw_rcv() with RPS
 enabled since d4fb6514ff8e
To: =?UTF-8?Q?J=C3=B6rg_Willmann?= <joe@clnt.de>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, netdev@vger.kernel.org
References: <VI1P18901MB0640EC60F0E40E18EED92A0AAA8D2@VI1P18901MB0640.EURP189.PROD.OUTLOOK.COM>
 <2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joerg,

many thanks for the report!

On 28.09.26 13:55, Jörg Willmann wrote:

> since commit d4fb6514ff8e ("can: use skb hash instead of private
>   variable in headroom") we are losing received CAN frames on raw sockets
>   when RPS is enabled on the CAN interface. The problem also shows up in
>   the stable backports (seen on [6.12.109]).
> 
>   Setup:
>   - Kernel: 6.12.109
>   - Platform: OpenWrt 25.12.5, 4 CPU cores
>   - CAN controller / driver: mcp251xfd
>   - OpenWrt enables packet steering (RPS) by default on multi-core
>   systems, so rps_cpus is non-zero on can0
> 
>   Symptom:
>   The application on a CAN_RAW socket misses frames. /proc/net/can/stats
>   counts more RX frames than the application receives. With
> 
>   echo 0 > /sys/class/net/can0/queues/rx-0/rps_cpus
> 
>   the losses disappear completely. [Optional: rate/amount of loss, number
>   of filters on the socket, whether join_filters is used.]
> 
>   Analysis (as far as I understand it):
>   1. RX skbs from the driver start with skb->hash == 0.
>   2. With RPS enabled, get_rps_cpu() calls skb_get_hash() in the
>   netif_rx() path before can_rcv() is reached. The flow dissector
>   finds no L3/L4 headers in CAN skbs, so every CAN frame gets the
>   same non-zero hash with sw_hash = 1.

Ouch! I wasn't aware of this.

>   3. can_set_skb_uid() only assigns a new counter value while
>   skb->hash is 0, so the RPS hash is kept and the frame gets no
>   unique identifier.

Correct! That's bad and not intended here.

>   4. raw_rcv() treats a frame as a duplicate when both the skb pointer
>   and skb->hash match the per-CPU uniq entry. Since the slab
>   allocator often returns the same address for the next skb, a new
>   frame with the same (constant) hash is dropped as a duplicate.

Right!

>   Before d4fb6514ff8e this could not happen because the unique id was
>   kept in can_skb_priv::skbcnt, independent of skb->hash.

Yes. We won't get can_skb_priv::skbcnt back but I will take a look at it.

Best regards,
Oliver

