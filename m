Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694615;
	b=OSeybil9BwrFg3qN46q24G2ihneqGkdy2AIc1P+NSTcUzxxWzai834Z8T/g2j+DCJjBR
	 uSnaag9AICPnNl812FT5aXjecXssUUFExOWcqk6AN3vYkfyruFS489oCIRZl8aKArha2D
	 2A7BvYIUA5z4Qq1UwHjId2rgRT9zdRqq6HrYduHcmvfdNZKOES2JuTGJSMmFegnMPR01q
	 149hnVsLWIlUpmNkYyTHpp/ZrWJUv9ba2cE+ukDIqLktFWtJveDdisgnksnge4kiSmyry
	 3BoQJErjPRGrgVs3TipB4SEqE4oShcm1grjxkh+wgw15VEY/4A8BZM7CjmR9lb2GkwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694615;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BCsIDvBG2WMc+zpumYXaKqeU9eoeIes5/qkV9rNDvaI=;
	b=trh553EePelwBeshVFM1Yne8d7uDb5VPsB+/O3nQzMtUpJgn6Wu3LJ6Q1r2Euix8t4Jz
	 GhvfS9Z3iUbYm3dXioocCSIs5rnE8LbppLLJ7iVCCqV2L3A+cQCtLP17msN/ODs8zW5cn
	 S771l/K9Og/k7DnuQNcHbVnTADN3glEHY+pliKRfyzQRT0vaMhaPJKq1PxxvfF9PYaxH3
	 Idg+CDSPlP3urEC9UfC7jlmVzvSNxn2TY/kb8PoZxZ3UZjbzGeerFlM0YV7naNXSvqmhh
	 LkgP5649il3ku7NiHZYVW0hpgO//oIIy1soVmZAnViaI0d+ev38RsyWhPB+trf7oyuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=MfFfCQme;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939B606A31C;
	Thu, 26 Nov 2026 12:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9939B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=MfFfCQme
Received: from stf-laptop (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 78EB8780395;
	Thu, 26 Nov 2026 13:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1795694607;
	bh=BCsIDvBG2WMc+zpumYXaKqeU9eoeIes5/qkV9rNDvaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfFfCQmeHuHIhxYOfOlGl/XSA+5HImpgfeQj3Rt7nKS+Pk4bQ9ivsfTttFovqg/KY
	 YQ/YDZQxFwlRjiGcxJiXnKeiltUJqAxM+OWHNRyCxyodrNhsyxZa6NOgviQ9qSn2jU
	 9MRjCWUBJshNvLk7MWOGaYmRiTfl0y6sTHfTaULq2P+aPI4NwN2gV6a88ST1kphmzX
	 XtmQGuP9vV8PgpmqnWw3eCwiqLMHiy5bECX29S7M2/8CFCpLT036/ZAQlcePKBKp8R
	 va3WoMVcf5hYQodQjEoZcWbLfqVwVdOd1d0pTEogTBm9jIHMAx5stNKA5PVYJ7Nd9i
	 5LOziD4KZ0jtg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: sashiko-bot@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Dan Carpenter <error27@gmail.com>,
	Lukas Magel <lukas.magel@posteo.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/14] can: peak_usb: register the netdevs only once all channels are set up
Date: Thu, 26 Nov 2026 13:00:13 +0100
Message-ID: <20261126120018.28871-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-235102@kernel.org>
References: <20261126-canfd_check_channel_idx-v9-7-abe0099b4585@peak-system.fr> <sashiko-outbox-235102@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/11/2026 10:11, sashiko-bot@kernel.org wrote:
[...]
> [Severity: Low]
> Should the command helpers called during probe before register_candev()
> also use dev_err() instead of netdev_err()?
>
> pcan_usb_get_can_channel_id(), dev_init(), and dev_set_bus() call helpers
> such as pcan_usb_wait_rsp(), pcan_usb_send_cmd(), pcan_usb_pro_send_cmd(),
> pcan_usb_pro_wait_rsp(), pcan_usb_pro_send_req(), and
> pcan_usb_fd_send_cmd(), which still log errors via netdev_err(dev->netdev,
> ...) on an unregistered net_device during peak_usb_create_dev().

Yes, they should, but not in this patch. Since this patch calls
dev_init(), dev_set_bus() and dev_get_can_channel_id() before
register_candev(), their error messages, if any, now get the
"(unnamed net_device) (uninitialized)" prefix. The same point was
raised on v6 and answered there [1]: these helpers only log on error,
and since SET_NETDEV_DEV() has already been called, the message is
still printed and attached to the USB interface: only its prefix is
wrong. Converting all of them would make this Fixes: patch grow for a
cosmetic issue, so I'll do it in a separate patch for linux-can-next.

[1] https://lore.kernel.org/r/20261030102705.30262-4-stephane.grosjean@free.fr

Thanks!

Stéphane
