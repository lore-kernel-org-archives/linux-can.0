Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393462;
	b=n//R49geoWyNxfgbK2CR4u741WeDd1uY6GJqNhVEGqVWVMghw/UHQ3lEiKEIZq6NQDD7
	 EthW32/9X1d3CzzDLkU1fN3RwyPaavSySe3Tmlly68IbbKPwqoRQ9pg9mm5Ahv+BrH1NS
	 f/oqwLfRCz9RciFO9I0EyS4puPozwwCOvkxrVX2+l9P8f7C3eCWtbBrivlK3EjQB6HvFD
	 xxheNX5tqNgo6MbYhF8WoG4QNmk32eOrQLXXuOgJtda/19fjzAnURAq7B1oLteppHnfJX
	 WV5f8zpQYvX+PXkgctjvf1mPYWjmyqBC2WWgbe5oZ+C7bv6ovon3cE0Kb3cAvgtdwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393462;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=o7SRZFmppRjb9BEcBE8C/dEOzRCctvE4fO7K4fNweYc=;
	b=3Ou364jKWTsL+YshqTkKBWGPZuDn4oXzCKcrYo/mXiIqVn6vRXDfaHatuKrP0e2DUPtm
	 /7UxIB1oiiMsekFHfOjkEE32+vyU0Dp4wf34hAgHefy5LSZO67a32nIenUOuAPnBq68G0
	 hYtGUHjT91z3XL2dk+1XsLA6Lcj2/7ZJbBTR+ygx8/Y+rTEHT04bom4c0iBPUN4Kq1OjO
	 2DCSPQbkQWUKGbVmwJaLoWFrlEwPg72o+K0yGY5PTmncAl3QrjLGKJJutT1PtYPnbB3ez
	 2w6l8uaMfd6wETTuuO2kMAY/59oYCkuKeTk95UKCgg/q6l9eyuz2Rlz9M2JR6Af+CEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HjQErhaF;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B38606A31C;
	Wed, 11 Nov 2026 10:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HjQErhaF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=o7SRZFmppRjb9BEcBE8C/dEOzRCctvE4fO7K4fNweYc=;
	b=HjQErhaFqrZ+okoTOuMo1sfBoqjqBbMmk59Wpk6wwVTQneHsXfBXdTD+oZb1Ol
	mw4XTZkHLCgsYJ/VjUmuhMHn0QO/OfhMpGsrdft0NyZGHMcg13GNAWcqaq3KtnNq
	1E8j6Zv0kgonsqzk1gaUateEW2NFs2PbF9ATu+PVIgi1g=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 0/4] can: j1939: fix the abort timer and bound EDPO
Date: Wed, 11 Nov 2026 18:36:00 +0800
Message-ID: <179439336063.276536.1205296974801485658@163.com>
In-Reply-To: <20261111-daffy-bright-galago-0e3bd2-mkl@pengutronix.de>
References: <1794300100.11111.1000000@163.com>
 <20261111-daffy-bright-galago-0e3bd2-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+tdRfRqFJVJHQ--.9277S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry8Cw4Dtw17Zr4kuFW3Jrb_yoWkAFb_W3
	yqq3yUt3WxJFWfKw43CFZ8Zr40vw47Ar95Jr9Yvr12kwnYyrs7WFna9r9aqr1xXFs5Jr98
	A3s0vw47CayI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjByI5UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAB5AtWr0RV41-gAA3l

Hi Marc,

All three points were right. v9 is out with them fixed.

The threading one was the worst and it was entirely my fault: I generated the
five mails with my own script and never set `In-Reply-To`, so the four patches
went out as four separate threads. They are not separate now — v9 goes through
`b4 send`, the patches are replies to the cover letter, and the series carries a
`change-id` and a `base-commit`. The hand-rolled script is retired for this
series.

The cover letter now has an overview of the two bugs and the two hardening
changes, the testing status, and a bulleted change log for v9 and v8.

All four changelogs start in the imperative.

Two things I fixed on my own while rerolling, because they would have cost you
review time:

- [1/4] and [4/4] were missing `Fixes: 9d71dd0c7009`. All four patches fix
  behaviour that dates from the original J1939 commit, so they all carry the tag
  now, plus `Cc: stable@vger.kernel.org`.
- [2/4] said the CTS bound was "a separate fix" while [4/4] of the same series
  does it. That now says where it lives.

Functionally nothing changed since v8 except one comment in [2/4].

Thanks,
Chaosheng

