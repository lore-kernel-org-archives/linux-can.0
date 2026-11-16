Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848406;
	b=1wqbeiSqki9w5qm6aCIVr16LNY+xLeFLDXA/7LwUh0EDkufDyqko7/U5AkixPQExw4vT
	 qbkRgAssiZiZPcCY/hb9mupSnm1fe2lesUSlTkjcx9GoA+BhZkKth/NU+FMLQtO6DULso
	 U3LHRavsKZojsmvnLeandluRoJeVjwLG0bOfWuBpQ1Lx/ldsq6ulqy8cXrBoUjHnX1VF9
	 ut5XT1lZLYTeMq4IhZ/gcc/ExO4NT2yM3kcVaKx021u3BpTPEO76TycQTguQzCmKbcAF0
	 xYbEPh/kxVk4dDQEC9hwuJnH/LG6N2OoQfXl4rRdzr7YUca4sXXP/o4w4iqm8wokYFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848406;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ho8Pw3OzOIO6yZIwLewwoAwZMDNCLICWc3pROsaHEQM=;
	b=R4PCoEahbpnoun15PORKXuJ0zIlAKeh4Tp9nzmKEUhsCsJaCELShcFJxEoHMVQSqd1sc
	 GYmzUjwSmtTMj+kgyy37wlhA/JgoIAgWizq5t8wk1/sS4w1rK7ieVJvpRukZ2wPAAinH2
	 F1ThPv7q19GcT7ecoNi355PjBkWGJTOWFdUZvsDgtL63ctcbTjQBChaHl23E61A0qjnMw
	 1SOI2X5i+DM39rBY4faKSQe1cKBAu/jQa3MDe9vpYOEnd/LepOZAGuYfS6HtUf6oxDLJd
	 oetxPzzVyspmW8IToB2xJx/K6QgzaTdVGWksZxycwzw7ycDxVS5X89Fz4k2qZWcUlgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lVu7xIPZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XtU4Vvlf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90414606A33F
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 17:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90414606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lVu7xIPZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XtU4Vvlf
ARC-Seal: i=1; a=rsa-sha256; t=1794848393; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fPhBdYt2L8/a/8G8mLG6pD7S4G35DfsjUI7A98FlEqI1fcr+B3WtXVgEvCPwcxH1F5
    qxkeE0/OJreneJvRcrhWNyqsxNefWSbTD0siqsKeegZhK6EwdgyxQO3jfbkVVfSh7d22
    yAmW06Zz5NgUHHQe+hL5Nmr2Wey9Uyz4hkgJpZLiVSTZcRCXiS5QbmJR7d44l9z5Q7p2
    UE1A1LF6IA2U0rtUh+Hir+I2BQ+5QFKnZQYnbq8kFdtGFzu76QkQMVmiiX5gR4foLdJG
    Q67q305LqKvj3m7jnqznzkxT8wnLLble8ZK1NFbBUpS6lPlEcgERHfs0J7YBshME7s3m
    7KzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794848393;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ho8Pw3OzOIO6yZIwLewwoAwZMDNCLICWc3pROsaHEQM=;
    b=BxjH6ZjwtyybCpOUAjn8BnJSWqJuP/IRPEuVzKeXZ+j06B/YtzeLFXXz/ssd5NRHUR
    8rPmrkYZiT5TBb46FYBJwt4Zm6y+LwhNcfthGEGsI/t5Nl0SUZ2eyuc1WS8pyMb446cn
    qUGtBW7D8ecJu0kdeDvSQSAVhPIO4uDTnglaPC+2CK+fsSRNluVfqeSDiLnCOsbfL9OH
    /67AtwnMA7AdleJLT3fkinZaa9SiAf8o2kRA2fQZmZx40YIu6C7PyiQOeHjn+Vld63fl
    8zRYWJS/3Hf4TtxeKFC6ZIAq6dK5j3CezUdgfGD5YmeCTeqjzip+HaCJKrlfhLaYQHqf
    IY5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794848393;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ho8Pw3OzOIO6yZIwLewwoAwZMDNCLICWc3pROsaHEQM=;
    b=lVu7xIPZWfo4MiM4xQNJdAFIENMsbvBgNJ8e+ZTWok2448iBvkCjEpLC2xZiACRg5M
    q1YEEWJC7RDlwRhYLuY2ey9I925C5Lc36xGQm06Blre5Yk/fq8MkkNVm3SMzDE01bWBy
    fPCNCZtHX1z1lzlX7eyf0xq6pSeZPCMpGdNEkXNzoM3tX7sjhgr2eOvYuHCAhhQikX5W
    qW7qnk7sWGsFt4lSfQQ9OcN7G7Cr1icHNgBYjpkT/cKKAh6U+YLvD3roY94YmPWGHXSl
    II7hn6oU13rU1QYC1oB1IDa2m2jCT19qeha5CniDVcC1GVuSxXxGA98B1W+ec7A1KvQU
    Tv3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794848393;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ho8Pw3OzOIO6yZIwLewwoAwZMDNCLICWc3pROsaHEQM=;
    b=XtU4VvlfhrGWDIIM0/fqsg5l6NT2A4TuFnOqZ5jUi+WkMfcwLg5De21ZJZPTdU86T4
    6SCJs/P0d/+kwzhqLXDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AGGxqIoZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 16 Nov 2026 17:59:52 +0100 (CET)
Message-ID: <df95ffcf-c6e6-4dbc-bbab-7749ce93ea86@hartkopp.net>
Date: Mon, 16 Nov 2026 17:59:47 +0100
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
Subject: Re: [PATCH net 6/9] can: isotp: use a private mutex instead of
 lock_sock()
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
 <20261115095746.709371-7-mkl@pengutronix.de>
 <sashiko-outbox-216678@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-216678@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.11.26 10:58, sashiko-bot@kernel.org wrote:

> This problem wasn't introduced by this patch, but can
> isotp_setsockopt_locked() [1] modify socket options while an ISO-TP
> transfer is still active after NETDEV_UNREGISTER?

(..)
> Should isotp_setsockopt_locked() also check that so->tx.state and
 > so->rx.state are ISOTP_IDLE?

Yes, this is a valid finding and the suggested check is the right
approach.

isotp_setsockopt_locked() only checks so->bound, which is cleared by
isotp_notify() while a transfer may still be draining. isotp_bind()
already rejects a new binding in this state by checking so->tx.state
and so->rx.state for ISOTP_IDLE, and isotp_setsockopt_locked() needs
the same check as suggested:

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8229b6a69e..4644a1533a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1721,6 +1721,14 @@ static int isotp_setsockopt_locked(struct socket 
*sock, int optname,
  	if (so->bound)
  		return -EISCONN;

+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
+	 * socket options, see isotp_bind().
+	 */
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
+		return -EAGAIN;
+


As this is a pre-existing issue that is not related to the lock
replacement in this patch, I will send it as a separate patch.

Best regards,
Oliver

> [1] https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
> 

