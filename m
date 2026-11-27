Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.77.172.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777962;
	b=qr9a5jkbtkOjHFvKGDCZCmicXhRTP+O8KRFaonlBXm6/bKV+C1UyExUT7olCE2dgIMsA
	 MRpo4J5MHohPqpLyiWugLXZJ3bAmOpyYdGrvzwcRdKLW63LKcGom7JButYBSKCMYu1YF7
	 IsjUFKYvoczyB5aKU9OL8ytAZ3nuzG07opkFnrFY73l3GOOQNOFLA4ik5HsjvfGFYn5nY
	 uPDTDt+4JiJhcdjgrb3RQiiGI04WSoklM94xFj0fP4HU9OmEsjMdx5t203SwLaNOMCGec
	 DY6fcwXROtYvywXBSCS/FotQXCjNuUMT71nAfmJsgp5HeJUcyCFe9Y3bzGbwvuNa6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777962;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UNYOinv1kAjb+s6KJVsKvxox6IAHN35g5+UoNO/+/1E=;
	b=ZN+2BtyR65FqzNoc+TdZp8TOq7RCFLvcxtjCRdkNav3cUphHqDF21no2sqpq0199XTzB
	 dW2RyCJX/sSztxOo4YBpxaDbh9rIKysM95QJ3Nbfu5drbrb5oDB15UAUF3JSzie+YfU9D
	 mZNw1ThqcIezc5K2fkpzsxTNh/KXhiySBUqKenFOCicmtiJI2WAc3rjG5m+BL9EmagCfT
	 VXqXA5a6V54nZrMrQrlPU+PH3iNIbSjyG6trdgxmylGxwDhksYg0dzObhAIMPNEXjONGC
	 Sfg0A/Dbc2Hjd5ijOQy8bz2e4T4U8huXPDv/Uy9jgA4KvjEedjNVTUnzrI8acdaK2lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=MbNFYihS;
	arc=none smtp.remote-ip=93.77.172.86
Received: from forward501e.mail.yandex.net (forward501e.mail.yandex.net [93.77.172.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C6606A31C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 11:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=MbNFYihS
Received: from mail-nwsmtp-smtp-production-main-68 (mail-nwsmtp-smtp-production-main-68.yp-c.yandex.net)
	by forward501e.mail.yandex.net (postfix) with ESMTPS id 321F6C016E;
	Fri, 27 Nov 2026 14:12:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68 with ESMTPSA id UChBv30l7Ko0-hOcojhuu;
	Fri, 27 Nov 2026 14:12:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795777952; bh=UNYOinv1kAjb+s6KJVsKvxox6IAHN35g5+UoNO/+/1E=;
	h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
	b=MbNFYihS9XpS7xc+9v3cc1/po+y1Sp8O1YMfzs9HwPJkB7TcLndmkftDqO144UWDd
	 cNoBXoUSSaGRIZfI8Im4OZjLqr0N8kNJ9cFwQLy1TrWnmQRGG/RfQTp8sVH7cZ9Pc5
	 gCuk9zdXrIW3aUvFoGmzKf88wWxsgaexzcsMRsaw=
Authentication-Results: mail-nwsmtp-smtp-production-main-68; dkim=pass header.i=@yandex.ru
Message-ID: <d0461ebb-994a-4c9b-8407-fdd091d5911b@yandex.ru>
Date: Fri, 27 Nov 2026 14:12:29 +0300
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
Subject: Re: [PATCH v15 2/3] can: j1939: fix "struct j1939_ecu" refcount leak
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
 Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
 <f778db47-a217-448e-9dbd-f1860afab00b@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <f778db47-a217-448e-9dbd-f1860afab00b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 6:57 PM, Tetsuo Handa wrote:

> syzbot is reporting "struct j1939_ecu" refcount leak, for
> 
>    j1939_ecu_get(ecu);
>    priv->ents[ecu->addr] = ecu;
> 
> in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
> even after
> 
>    priv->ents[ecu->addr] = NULL;
>    j1939_ecu_put(ecu);
> 
> in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
> __j1939_rx_release() from j1939_netdev_stop() has completed.
> 
> Fix this problem by
> 
>    (1) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
>    (2) making j1939_ecu_map_locked() no-op
> 
> when a netdev which is associated with j1939_priv is no longer registered
> (indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
> __j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).
> 
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
