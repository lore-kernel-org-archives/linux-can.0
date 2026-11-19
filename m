Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109196;
	b=1NBX8t+ieOQucDiOUcsOzE4Vey5p7FFXlLHAanejmLzmAMQSQI4zgnHZC1SCXY6LHjsd
	 BEOBspMkzJLvJBE70JQoL2j0UbiwMOyIzqWHhcAfiWmq0C1k5fuxvEZaWInlh+wgRCDgk
	 LuQ6JxmPicaQe8+i0bG8N1lUtcfS0kYS3pz2PInl/vbx2a1u67q/tKzQvYtUS2sTUq/vI
	 Z3mvHn5SpI6JZ40HYfklX9tV18VFn68JJGwvq5PJyRxLBNT30g/rKSJlhkKL1KWzlBNT6
	 jONpi8dDpV99MQphcWWzm09m58grumWAgHK1Lq5byNO81PG0T1SloHz8jTxadaUTjPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109196;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LxUt5SsYtClWKS+AM0t4bBTS84tiWXWJOLwqB2NwRXE=;
	b=PWv6WhxKE9oLDIwl/WLooEL6C9AuT93rQBunOzr3TKFFYnmVAv3UxaOlS+rmO/3BebU1
	 YVNJehaeWgnR1HTO1H7sMJrsxo4UqrxuKvGzmiSG5IuTQmCu9xL50tFCrGi7+xdMGxflS
	 vKpsCCUwT0JXdjnxz2eLlQlRiqj3EYjVnS3My230dc/liFNseTO0L/bSUZCR20fQX/3r1
	 akgbm8ODtH5ypNgWZYa5Hr53+iTtjMl+X+SBKLSfiRxgFJI8M4xdPe7BVnRlqMIh5U78h
	 5QyW0I8+ck1SubtsoJc0ivhCWC5S0lf8CZxFFvu8BkrGt07raHQs//UEr9X87SARUKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=V3OV9ZTn;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=GOZEynJw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5A606A320;
	Thu, 19 Nov 2026 17:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=V3OV9ZTn;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=GOZEynJw
ARC-Seal: i=1; a=rsa-sha256; t=1795109185; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b9O8O+Qr5Ga6wW3Ubg1cGcJv9JvKndqeoG3aKLIg/uPvK0ItZWa89DHy8xZFZjxDh1
    qrRXXFrSpGDG+9sNxc8ifZP8xoxhOGbIUk/BytFsWUXhqrfWS9MUSNaqBginzVpbU3QF
    CWlqpNQaI1fs5SN4gw8aAlnfN3ivRHPYztiGegbmNAwYgDaNmZFWmqottvjQ/cr1VaJq
    vjlqsk6lcAS2ctM1/b467G/pvPzPXX1i4l6Uq6HS5OIQqKRo7IsgD7WRrFKt/KR2Suyv
    retVJ1R7/Mv2xKw1IfL0nAq/NYiJAX7XzBzNvwEVcv2WaknEykkjX+Z4PuXTnh5gc3AP
    dtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795109185;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LxUt5SsYtClWKS+AM0t4bBTS84tiWXWJOLwqB2NwRXE=;
    b=J1/s56WN+h++/bstgBtZ5COV6oNnDzoa4ZTx6vnRqxhj1wxVChjZ01NelO5fe/XQgg
    UZCF3gulqetlS8GvggtUXLG7vusD/NPQlFOUOuHxkGt7zHRyAAlHbgwzWv5Y4dlRiAql
    TKOPTHm+TLHTxSzAeBQGdubB0bC09w/DtJsdWEYpPAyw4GzEAfOtgTPJeJaQt6RarAN4
    qRnltLXywZyuFD3TuKXw/5O7C7xZacHUH+AeOfthjulAjavt9ES9tUa6AiEWLEqiMD8M
    wp2EkOSIES/JOZjC4GfuWis8RcSwhczxGg+zOU/wrzHJdm4pvMGJwNRURbwpOlDjyM/j
    MBJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795109185;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LxUt5SsYtClWKS+AM0t4bBTS84tiWXWJOLwqB2NwRXE=;
    b=V3OV9ZTnLuY73+rWQWfZBDRdDUTuMppYFvhmdD/j1vZTQ7oBIWTN5cQSl4hKppsBk+
    xUEgtplK1PkNrCTrzHN9FeAB+qjbmYFpkevkKE2SSDZsUeJPnpFWntaZ2W9FS79wGK5F
    +DfJumMXYeWfBSgXJZ4tuM4wE+hwSvNAe3yS3m1vZzRNCKm7bYzuJUZMb9llbkKPHEZC
    FOisFPVEsns5Dn+JtCoi7D7D/i4VLxZjbO8cGY6BPbcJhRHXDAy2KysRpZkNpCFPTC6q
    TdS2EO8BzajsL/BzVFP9kufKOuurm7qFiBcBKNzKLm4vqXcpm5WTdQFKXunnwUJIhs5K
    7Q0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795109185;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LxUt5SsYtClWKS+AM0t4bBTS84tiWXWJOLwqB2NwRXE=;
    b=GOZEynJwQvFvsJjNS6xKkt45o0Hmm+VfpXKGuxEAXw3ONESUeXbJS9RlF+45KNc1Us
    ouvz6gEsXEVNVH6YY0AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJHQPMwC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 18:26:25 +0100 (CET)
Message-ID: <b7b1b385-cec0-4828-aff4-d0ab5fd61951@hartkopp.net>
Date: Thu, 19 Nov 2026 18:26:25 +0100
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
Subject: Re: [PATCH] can: softing: lock card->fw.lock unconditionally in
 softing_card_shutdown()
To: Ian Rogers <irogers@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
References: <20261119170722.1524088-1-irogers@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261119170722.1524088-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

the PCMCIA Softing CANcard2 is discontinued since 2013 and the latest
Windows drivers date back to Windows 7/8.

The Softing CANcard driver is to be removed as there's no known user and 
we lack the access to this at least 25 y/o hardware for 10 years now:

https://lore.kernel.org/linux-can/20261118092955.1283165-11-mkl@pengutronix.de/

So thanks for your patch but unfortunately too late.

Btw. beware of Sashiko bot reviews for this obsolete patch that will 
make you rework the entire driver :-D

Best regards,
Oliver


On 19.11.26 18:07, Ian Rogers wrote:
> softing_card_shutdown() calls mutex_lock_interruptible(&card->fw.lock)
> with an empty if-body ('{ /* return -ERESTARTSYS */; }'). Because
> softing_pdev_remove() invokes softing_card_shutdown() before
> unregistering netdevs or removing sysfs attributes, a pending signal
> while card->fw.lock is contended causes mutex_lock_interruptible() to
> return -EINTR without acquiring the lock. Execution then proceeds unlocked
> through IRQ and DPRAM teardown and calls mutex_unlock(&card->fw.lock) on a
> mutex not owned by the current task.
> 
> Use mutex_lock(&card->fw.lock) in softing_card_shutdown().
> 
> Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
> -Wextra-semi-stmt enabled; fix and changelog drafted with an AI coding
> assistant. Build-tested under LLVM=1 W=1 (-Werror) and -Wextra-semi-stmt;
> not tested on Softing CAN hardware.
> 
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Fixes: 47fa0336c1b7 ("can: softing: softing_card_shutdown(): add  braces around empty body in an 'if' statement")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/net/can/softing/softing_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
> index 519ab3097f86..d3dfad4f5321 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -448,9 +448,7 @@ static void softing_card_shutdown(struct softing *card)
>   {
>   	int fw_up = 0;
>   
> -	if (mutex_lock_interruptible(&card->fw.lock)) {
> -		/* return -ERESTARTSYS */;
> -	}
> +	mutex_lock(&card->fw.lock);
>   	fw_up = card->fw.up;
>   	card->fw.up = 0;
>   

