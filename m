Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991370;
	b=q6nD/3x3dYhustWUDRjzbd5brmp6NLdbgs2X6MTQ13+U8Z0VuV3U8+gNo6MNCMWOo2MC
	 kINBH7JNDCnK7i/sLf1loDl8aHu/M1G1PXLam3wJcXyv4dqKIpHEIm4GQsnS4JuTkLK18
	 HV6aXGlPMXk/2EJirawh+3LjpeC8SjhC5YoQlPdgemO5UUh713yHDbiI0wHc+sesBnvNS
	 tHBRWxtIlgHSEmaS0hNMDYbTTllzWwrdwEgyLFfgj41SvQ50EH5iIu12rW0duCznL+9Ax
	 oUSXanGLnpLtnrRxGfErqLGVWjxvijzqcR7Zki5lRfa/0D7wr+fRJyHDuVchlsW2RPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991370;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=l8qgb2X55amZaJ0fNhmmqVqNW9Iw3JiU2ShlGC7x8Vs=;
	b=JLziiscjWMUSNy9wq9edBY18wkadcuxsFps4D1+qVKFc1Rz39sPFatZOoai+M1KmBjcl
	 izRA7XpA9tiEH/B5ol4WekuQZs9uG44zstM6UluppmQCVYSehXWRa09XUpN7rArPMBBk/
	 LQ3GEInMuWW1AgIgw+B3urIiNZrR3M3FyiTbTo6jLdU4MvnH9NY9lYOzHrUlDsRTkwkX0
	 JgwhZC5z977MYzSicb8oCNk8lqgttd6dmkWZSr0Ao8CuEM2MSFz1TR5CnM2hzN98M4p8m
	 CAJF0bmaj/QvbLJAii8WFM+6r2oeDu2lmEwJjO4oo6N3EB0kyAi/K6/VHFKBwfnflLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bEihaVno;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=8EThDUp2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5A606A89F;
	Wed, 18 Nov 2026 08:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF5A606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bEihaVno;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=8EThDUp2
ARC-Seal: i=1; a=rsa-sha256; t=1794991363; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hsilY/mr5/VRU7ZZ8f2r9ypQk/I8kol9ns10ndjfi/UATq+j9Q1+k95ZgzpuzAh8co
    VHDzdmOEFFTf2zt/UYx8qDJA1vVfkg1wgdc+wO02YZuttwtGZOMECVpnIt3hJG35UgZO
    vZ3F1hgdNDkUXUb3UJ/W99WKG51GiX47GshImPnpyIdSet6EhFCXWsSJcHB2+/U17Tdl
    ZOQByHd+WR21EJI6VnOJ2wgRNsOwl2AlDQfgYqv1ATJ+6Kb3BW6tRmapDqdxcP0WW+ct
    vBMkg2KNbG0JgHvQgEwetq6rJaOokvpJJg+gToYSYSASkBTBCaWy3KGd60qnZiFSnpxt
    7nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794991363;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l8qgb2X55amZaJ0fNhmmqVqNW9Iw3JiU2ShlGC7x8Vs=;
    b=VwdZBpCDNVyAcnm+iI5To6/Jpqb+v+ed4aA5hBNkFQ1Qmrc/MftNxRlEkvYTOsEvBf
    jLxkWvhcjBuzBVL0MS5a0UKOnuL4Fty3CH2KPVaVjmBolMFIzi30DtPzNUow9hjZldeB
    yOiwAGNSxsR2cXLD1KY+sq1cfPfPQdCgVHyZmtuJ6mytXR/XM4qz0ZodsaWNfTjE1oow
    iTahc3mzrFTmv42hozHoJRK22C1ssc2MN7+2saTIiJzUKr8qUDhkve5I7Xc/QyZXX/V9
    laGYqRyXEYk4GLlJ8GWuoH25D8TAh7IBAm/RcKPjhE8g6KJ8HymlMaVO73byayd/I+Bg
    LnvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794991363;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l8qgb2X55amZaJ0fNhmmqVqNW9Iw3JiU2ShlGC7x8Vs=;
    b=bEihaVnoEWMDljHYQ/LZhohMN/vYTKoRdJYsqgrM86Gy1JjjMHmi2vgUokJSBeOgZt
    keT3Frf8ly6+MEi99l8YBvA/HEmYIap48WQ3quqGI0A6t9hXAz/Jq7yNOxg+33UpY+a4
    l+2kcwHE26pKFbn8hAfJ5KMQRSZj3A86xaP9vpLFpiOVcCoxyozmUEjK6HouSTzSPIM5
    w0P4QHB+LtMytT/Ge4sVpvlwEwfAv32g40fXkNKHvSxEZwQyXKHcacX236xGXD3l2dhJ
    FyVwfVFRW14LdySC+AEQ89gNMuIHM4kMRIVAkW02yqDUIfC/7gwlzD1dfd7ydv8iE0ws
    Zbeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794991363;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l8qgb2X55amZaJ0fNhmmqVqNW9Iw3JiU2ShlGC7x8Vs=;
    b=8EThDUp2Z6OfjJg2w+ZRlMH21eR4+Gr3Z1mEHnr8pWaMn0TobbRofNN8vATC2tL8uA
    MG5lc30qOYXwVSFP1fAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AI8ghBP9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Nov 2026 09:42:43 +0100 (CET)
Message-ID: <c6390e46-94c6-4118-856a-c31f1c45e13e@hartkopp.net>
Date: Wed, 18 Nov 2026 09:42:37 +0100
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
Subject: Re: [PATCH net-next] can: bcm: Document ival1 count semantics
To: raoxu <raoxu@uniontech.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <12B691026195694E+20261112023110.1234039-1-raoxu@uniontech.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <12B691026195694E+20261112023110.1234039-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Xu Rao,

many thanks for your patch.

On 12.11.26 03:31, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Clarify that count controls the initial transmission schedule rather
> than counting successfully transmitted CAN frames. An error returned by
> can_send() does not prevent the counter from advancing.
> 
> Describe the transition to ival2 when count reaches zero, or termination
> if ival2 is zero.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> This documentation-only patch follows Oliver Hartkopp's suggestion to
> clarify count semantics in the discussion of my earlier patch,
> "can: bcm: Account cyclic transmissions only on success".
> That code change has been dropped; this patch does not change BCM behavior.
> 
>   Documentation/networking/can.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 51bc70748f75..840d840665a4 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -892,6 +892,11 @@ only one timer is needed 'count' is set to zero and only 'ival2' is used.
>   When SET_TIMER and START_TIMER flag were set the timers are activated.
>   The timer values can be altered at runtime when only SET_TIMER is set.
> 
> +For cyclic transmission tasks, 

obsolete. the entire section is about cyclic transmission tasks.

``count`` specifies the number of
> +transmission attempts scheduled at ``ival1``

correct.

, not the number of
> +successfully transmitted CAN frames. 

obsolete.
The counter advances even when
> +``can_send()`` returns an error.

Yes. But no user knows about can_send().
  When ``count`` reaches zero, the
> +transmission continues at ``ival2`` if nonzero, or stops otherwise.

This duplicates the description of the functionality from the previous 
test block.

What about;

When a CAN frame can not be passed to the configured CAN network interface
(e.g. due to a full transmit queue or a network interface being down) this
failure is not reported to the user. In such a failure case the transmission
sequence continues as configured: The frame is not re-sent, the timing
remains unchanged and a non-zero 'count' value is decremented anyway.
Therefore a TX_EXPIRED notification (requested with TX_COUNTEVT) only
indicates that the 'count' transmissions at 'ival1' have been processed and
does not confirm that these frames have been sent successfully.

?

Would this be fine from a users perspective?

Best regards,
Oliver

ps. please tag the patch for can-next if you want to send a V2

