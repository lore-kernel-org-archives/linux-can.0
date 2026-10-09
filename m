Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE54FE2CE
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575918; cv=pass; b=jok0jQxHluzW8EBX8TxK0hTI6hRaV3xhY2MBVRGfptmXsveEJnRH7oU0K+gkj8MXmAq8MjDlMkj+SnFoDU1ExWmR8oaMXZX9+apFDnI7hLW6gAJGuT49pvEkktLLzF0h76JiXm1FGnyJkQMTQKmKJs5QZRVlz1Ksx7le/0WYVTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575918; c=relaxed/simple;
	bh=sxd397/AVATNShPXv/PI6y3GMzanBnb+lfwBRiGlqbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgbegugYqpx3nt3mhffFWHYox/924XM0qeomiSvF2hbtLO+3JUw3KB0XCB8Y0PRgfMPIGEp7qlaw0hEIMUmk+NXxOrf2ViLx1iKeoBCi1fPeSJuj3aWx+MjvoVDbKLZvMEH9Y4L0R6cwtPcX43R184lCI+VZWsIGXFz+qJYVgsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XDg1O7EE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XDg1O7EE"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E8DE020236B;
	Fri, 09 Oct 2026 21:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791575908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqQtl4jPnYD2fxab3WYsP3Gtf3W77GCtjpOfWLZC7pQ=;
	b=XDg1O7EE7bx35utj1ym6DH5zpIMQxIc7msRR7qHkcuIArnVok2NGMiTtOrlQfIHDmVhXl8
	vQY2lajuhLXaGaRVgzWz/79d4z/rhCvcT0fQ1FaQkK3NhNOP/6d+yTc/aYLcWmFvQpBGQh
	TYFGRbGNa1P1K9etxTFvFlebkSSLp84W0RfKR8oqGycN7JTzdefzVBKeN+DsVN7f1T0hvj
	jsUMJqJZTNVnL/syxrzftUsvXcmKLbpAMAr9v2VbYpL9TjX6YdULElGhr3U6Yq5jVvO2il
	RR4ZsporZtl4jGzYAOD6BsnKkOqcTMwhxwyynoxlfzocFPQD3vlSCX5z/ZhL4w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791575908; a=rsa-sha256;
	cv=none;
	b=GVLOf6FdYMQomI8SJd08hNgQ6GFXpwXbAfRDFI21jwemZBx+RHF/p5ra1jbsXzhrAfvZbU
	5WsByBs64mQNuyb+dDPVNCtgZsb60N1O3rwGcBaSZeKm8zGFmN5c8KK7FKy3JsPe6QlQsz
	xblM7yG+tO6HeC0+uhwSYzW3+3X+ekYGCT+NsstsE6MCUhMo9kozF6/J9sLYtWsJ2P4HeU
	6Sy82nYFPbv8qVkl1nv6qCCM4sKFs1KtNazx0JZYvEIFoYsRRovfM5+s9XpjCCYpaBg6Gi
	4MCGcMnIsEQwFfBpgzVNTWS6++PUE6l85NvfYX+qO7XD2b6v3M0qXN+2zSexdg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791575908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqQtl4jPnYD2fxab3WYsP3Gtf3W77GCtjpOfWLZC7pQ=;
	b=EEmk+Vb40CoCnEzqPOMi3+ijtEd3cULBYLsNZcVYcVmJ1DufHQKYb+wPAkenNkO5JMlv0N
	WWosKgL5257mruNxnCDiqVhJE0TtCYAkoFUzUTgB19zcOBCFnGTok/D/7MlmT7YzEWD86O
	eGzyMf9XOkX98aBj1oXw5MPQh0I6yV7oNHok3geKw3P7P+FZIujh1DyMMqlkDfsFkXllyr
	Sn3uAtgfpRWi2hY5cnuXB/HZgQScIEboiLB6tkVsv0+eCY050lLLBj9L2MXBgektOSyp7b
	plZpaPtnVr8meIk9XBYxH9ssbRDTJGFtTEdEKRgHuxvT6hmNZfAlN8pP2AXP1g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFGjc-0055wx-2f;
	Fri, 09 Oct 2026 21:58:28 +0200
Received: from pengutronix.de (unknown [185.249.113.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 785D05BDE12;
	Fri, 09 Oct 2026 19:58:28 +0000 (UTC)
Date: Fri, 9 Oct 2026 21:58:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
Message-ID: <20261009-watchful-ochre-mouflon-edb997-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
 <14f90123-382a-42fe-942a-b62f14307c85@hartkopp.net>
 <20261009-merciful-certain-dogfish-2c497c-mkl@pengutronix.de>
 <75ef350f-97a5-4b69-bc1d-d7152a7a1cbf@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75ef350f-97a5-4b69-bc1d-d7152a7a1cbf@hartkopp.net>

On 09.10.2026 18:48:09, Oliver Hartkopp wrote:
>
>
> On 09.10.26 18:32, Marc Kleine-Budde wrote:
> > On 09.10.2026 16:46:39, Oliver Hartkopp wrote:
> > > Can you please push the testing branch?
> >
> > You could also use the tag mentioned in the PR, but I've force pushed
> > the testing branch. Sorry for the delay.
>
> No problem.
> Btw. I've tried to click the tag in the web interface and then go through
> the commits via the "parent" URLs - which worked.
>
> But I wasn't able to pull the entire code as the testing branch was not
> pushed.

This should work:

| git fetch git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git linux-can-next-for-7.4-20261009
| git checkout FETCH_HEAD

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
