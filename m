Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6156377AAA;
	Sun, 26 Jul 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049639; cv=pass; b=iSiJa/ubTagyyedhVPoKD9nXKig+l/jFOuwiF0AOqxrXUYIBa3pEEH/dDM+x+fYd9U7lenAnzi2AVeWNPzPRsnhD1IKpkxzyaLOYFKhIDDcz9AIx3UB0yvL8HDWyo5HR6S1eTvLO3tPNw05CR4uJbjYOeSeVC2tvEc17FOc30sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049639; c=relaxed/simple;
	bh=mKlNvfa2qYnLhMSLhP4+NidA+QoJBJfCFl9uh/aU24E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=K+RnC5RZfW5Pf5azvSUO2U4Y2WSDWeUVhrunta5d3SNkjsvon6YRx1PPxJ95eIbx9KSnCikijUekn5IDJoAABNxvORS0UbDbqjbvxVlBCmhjFr9DQzyIoAV/OL4iNVrVcqjkLipg6KosufxewmW/ArwbbVGu1323TpI8nxQRGzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jAjQNrIS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r541z66S; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jAjQNrIS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r541z66S"
ARC-Seal: i=1; a=rsa-sha256; t=1785049626; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cxOkDy5cHwAUun54Wgnlq2eMHvIi4g3pdeb97E9uWXrbQ61BEVYyoViCVUVoZjlMfw
    wyrFdKyYpekZqoWrgheZcG6vreg2wvJDpOnYfuk/RKYx0MmcttFH+oCWwd2iStx6gVhi
    9C/nwvSpMvIeVz8SiouVHDj3J0lAcBbsXc5PC8Wr8T05zT88LCHE2CdjLFbxcNVkNWSg
    UqxN9vOiiBQeMm7OanJrV6c2m3GLTweluJ2ivrmGJOPHlZDvwbbJIs6SWG8j1VhL0dDX
    edsewsfX9Gcnb5ix/Ww/5JiXmvXBnchUCaRRHFHlTOkuJPa6UvtnNvQLV37ndLDtjuPj
    CgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785049626;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gMQEahTEeIL0w08NfkW3wSh3tsfZIY/MZBFg1GOQJtU=;
    b=LRGnOGdod+CbS4ZR/9HZfzSAPr1I7WbEEm7izRDpeUJeeGD33lzV3XxCBXq23NHxEP
    IqUxx34VJSwlqaQ0UoiFvmL2W8xm5sbH5s6BaX3meU9+TZiSrDwxdjhA3SVy88ZkYWKc
    1e0EotvhPJOLwEXiR09Xos3O7VTko3a4YSN7o6k5DJYjPhrhNNazXLJhhpkhQOzVY/9F
    FPG9wL7Gi46crbcFqYHc/ffumsIG8iuvVckKgC7W61wAgloRlkRtVkUl5MVdLy4/8sjp
    Wky4QwQ8/WzooBW0+z0v6b8tyNIc0/4FPJdwOuQdkp+W7aHnWPxFcteBX6qdgacpe1nf
    IT6Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785049626;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gMQEahTEeIL0w08NfkW3wSh3tsfZIY/MZBFg1GOQJtU=;
    b=jAjQNrISYfpTVTgj5DnkKBlfkOA2exeARUsqaU7tHGoFZHi1ZWKkkKu87QsEryCEAD
    ucASazhylkxeaBNuagy2PIeniz+bN07/mNlIHUKa/G52SDUU4ReuJ/WalvCBVXNIRLwC
    agcBZSDP4UOIrWn4ahBn2uyGjuezbj5tZhyV92MTsUK2FcPijqRgd7I/spMFTyCtvnv5
    uLXObpPJzozug0WS62Ps93VcHzjoMPhUJf9SugtOZMmZXaCGhsAyWpKWUNmIjwN2l2+c
    +igc3LXS90bpCVdkq7eUNg+CTGeZU80KSmIdU3ijCFcVgKk6eJGMD7kDfaqlVgggl9jv
    TH1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785049626;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:Cc:From:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gMQEahTEeIL0w08NfkW3wSh3tsfZIY/MZBFg1GOQJtU=;
    b=r541z66SrfbBhLyEq7+Z8sP6XJ//YCXB1hyyMm639StTqH7k3xOBXie/YZErCmxRKW
    DKPI208xASmO5p/uB4BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926Q7763Pr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 26 Jul 2026 09:07:06 +0200 (CEST)
Message-ID: <d1adcca2-2980-44f3-8ffa-26c08b81aa96@hartkopp.net>
Date: Sun, 26 Jul 2026 09:06:58 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v11] can: isotp: fix timer drain order, wakeup
 handling and tx_gen ordering
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <20260724181525.43556-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
In-Reply-To: <20260724181525.43556-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.26 14:31, sashiko-bot@kernel.org wrote:

>> +
>> +		/* drain to avoid stale error for a later poll()/SO_ERROR */
>> +		sock_error(sk);
>> +
>> +		return err ? err : size;
> 
> [Severity: High]
> Does discarding the return value of sock_error() here silently drop
> asynchronous RX socket errors?
> 
> If a concurrent RX timeout or malformed PDU sets sk->sk_err to ETIMEDOUT
> or EBADMSG, calling sock_error(sk) will unconditionally clear it to 0. Since
> the returned value is ignored and the function prioritizes returning the TX
> result or size, it seems the application will never be notified of these RX
> failures via sendmsg(), poll(), or getsockopt(SO_ERROR).
> 
> Should we preserve or return this error if no TX error occurred?

sk_err is a single per-socket slot shared by the RX and TX paths, so it 
cannot cleanly separate a TX result from a concurrent RX error.

Note that a plain unreliable datagram protocol like UDP/IP gives no 
feedback for bad or missing received data at all - it just silently 
drops it. ISO-TP does a bit more and surfaces RX problems 
(EBADMSG/EILSEQ/ETIMEDOUT) via sk_err on a best-effort basis, which is 
fine: for an unreliable protocol these are ultimately caught by timeouts 
at a higher ISO layer anyway.

What this patch fixes to 100% is the send path's POSIX contract: 
sendmsg() now returns the TX-specific result from tx_result[] (>0 bytes 
on success, <0 on a real TX error), instead of returning whatever 
happened to sit in sk_err - which could misreport an unrelated 
concurrent RX error as the TX outcome. Draining sk_err afterwards is 
required in CAN_ISOTP_WAIT_TX_DONE mode, since the result is delivered 
synchronously via the return value.

So the send path is now correct and race-free; the shared-sk_err RX 
notification stays best-effort by design. Truly separating the two would 
need distinct RX/TX error channels (e.g. MSG_ERRQUEUE), which is a 
feature, not a fix, and out of scope here.

Best regards,
Oliver
