Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554761;
	b=hKGAmORfxwqueq5LzjtIaCnDC2/Z6sfWytPk70JwLekWy6mdtRv1/UOXSEhmx4Wq4Bxd
	 ztI6ik8F41eUjQqGXXc5LQCeVObbDgsZyUpCEvJ/6e9hwS/dV23xgPA/Yu1Ci7R3+e+EL
	 Oy7kJTGbYLLfcx0sIcAeByQ4f0gd3u1GHtlxymITlMJVWb9Mt9geoBlMeiWtlNrVNRNvl
	 aWbK/kJ48SIAqZVDzAodjdg7VNqnzaS0uAV9I7IogqVs0JVdRUCtPFrIcRoWQUx7rlZUD
	 pfQx0p7W0KShVLXtPkprZJseMSjYgAHHp76qUYj/bizoa0iBxhtJw/NcTVRiHN9a6sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=VLwpA9pUMgllWzK8YBIzeEAJDxdkrBAErUBA+2fd920=;
	b=CddHQQPMXzp62vfdGMJ7pNFRWV2PQiA0lA0Gg3b5vuUSoBAVOrAdPDejQSK0csOz8CBF
	 vMI7Fzvq4mIPXoXrH3t4oJgzmYN50xPGPK1rApdNWqDiEVjkJvd+f7XuoUo7nJTihfE7Z
	 d9VzsSwOAQ488n5ldB/YZtsJ316eDzn3SeuCdNg32CQuxo25i8nwpCs1gv4+sVHyh/rRk
	 3TwMD7XoOD7Lcv0RETUsXG4lqFV6CKmRHJbPW5vpQXKO6zEqSBshcVEyKbWJfM5beHjuD
	 ejZhexDoMdaVL/cWFirLLR+PQExShBGmBjmUac6d9gBzNFLHEJOmFRXLM2zV8D9Lmmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AbnVnUwj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49149606A31C;
	Fri, 13 Nov 2026 07:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49149606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AbnVnUwj
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E172E2020ED;
	Fri, 13 Nov 2026 08:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLwpA9pUMgllWzK8YBIzeEAJDxdkrBAErUBA+2fd920=;
	b=AbnVnUwjuWzNVrnUsmmvmcnt88Fd3OP/2jvL5KN/5DD8dJHsXuCTow9YzHFEwS5XwLQbwf
	AtFBuSHHKCnQIMtfi5lRbC419QOBkv1xbG50MyC7fPOp020dzsUcwvgyjKl9jniT9pDLHq
	PIhHUdSTobZp1foUwiCTI5hXtgSEuR+LVs56ycjUFR7wHGrAjVD+35Dz63U1Kn+PQRU31v
	3nE2iA/+PRB/EUWia+3MEQBds860Bu0efJUEGpoEWOQgePCxbDbGJFMuVbvr3BvE/3OaMg
	ES+U0jZquqq31NifcPunqSLwigLtASRb1DNL4xYvLUuoY52+KDWzX6qraZw5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLwpA9pUMgllWzK8YBIzeEAJDxdkrBAErUBA+2fd920=;
	b=glzQKUsUxCIaP9B42+Rr9uftQz8d7WqkrZ/i8Bq4CtEccQrnLNDwEVTSJ3vyYYaPc2OxAE
	MyhRPYapu1D/4ZoVI0QClmV0Z1hPwD2MgpPHkeFaKkN/VvC/WET+FdWPTGZuRQ0YavLFxK
	FVcWXt1K+vGP2N25Soa49+xjS6ooFY9VIEU9G3qRk7uicbWfL+O8RIjfU8K0Ddpq0Rf76b
	8L4clxuknAqryjNVX7LKBmO6Izi5SJpVvm1DBPRY6wW/M5ykRnZkSXDA0Wp/jwAD65n6qc
	bQsqvruu+innG/Sd74u2DBn0zYV5vFiWXib/kwMzeSBZkt5gqdDUrqpBid099g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554757; a=rsa-sha256;
	cv=none;
	b=AYY8Q2sMjhXxU8IZ4HIXyWnKVgK7+x9cvh5xGB/ZM/CmOyGIsdPhMGndrzp+Jg3Z36S1t2
	lz9r3CKojWNhjCikYwn8iNoTEFjB5OLr9OSC5CYhJyW4dC9mKIvEUpcJquu1rZCWwogJSJ
	qJOvXXB5kRb8r9pczh82gaXZCUOKxSp1BwOlV2vvphfJ61JgXimsFwHQRCTjUXhT1LpUvq
	UfTDsRAN2DXOYp31e8KWj+kf5PEapLngTJoso3/VLaysj/vEQD7Uomsv6WGAXw67z2ZaVm
	QYK5XhXLYM8F/LMk1rZVzSOYe5JLzAEGLPOzR9aA3mwlIJhqKj4YVCaH0m9tuA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xRlfZ-003xJ5-2j;
	Fri, 13 Nov 2026 08:25:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xRlfZ-0000000FpS4-36Tn;
	Fri, 13 Nov 2026 08:25:57 +0100
Date: Fri, 13 Nov 2026 08:25:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: netdev-bot+sashiko@kernel.org, Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 3/4] can: j1939: drop the message when the
 reassembled skb is gone
Message-ID: <ava7hRQ7lxXckkPL@pengutronix.de>
References: <179410166346.60581.12668181404057434786@163.com>
 <179452018024.488853.2874336452045412196@kernel.org>
 <179453947398.30993.12910253526180673543@163.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179453947398.30993.12910253526180673543@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Nov 13, 2026 at 11:11:13AM +0800, Chaosheng Qu wrote:
> Hi,
> 
> Both accepted.
> 
> Dropping the message silently is the weak part. session->err stays 0, so
> j1939_session_destroy() queues nothing, and the only trace is a netdev_dbg()
> that is off by default. For an RTS/CTS receive session this runs when the
> receiver's own EOMA comes back, after the originator has already been told
> the message was delivered, so the two sides end up disagreeing with nothing
> in the log. The next version uses WARN_ON_ONCE(!se_skb) and sets
> session->err = -EBADMSG before dropping.

Hm... will a stack trace provide an additional value in this case? If
not, please use netdev_err_once()

 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
