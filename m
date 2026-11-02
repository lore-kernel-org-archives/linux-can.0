Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616861;
	b=axM1dcsu5gyyV3oBi1eVvCtL9gM4R8lN+MAo5O5IAkjTilvTJOAVfxjkmT71EWVZbGd1
	 A/zTfBH7mRFrHesVL7NybM9Ue7fUv0+PzfQYHBhNNVBJOJ9NQAFRjlx7rtNa765kbZZNL
	 Dd1ez3Xco8VMD71GDPbFBy2RPOn0KNWo92dk77kNvsqEEvk6qG3OXmropxAXGpc3WPUfP
	 s7arLOd5kzwx6cKIsauOei5USrLcCKJIoWFsdccxSsna0s95LIna2AXF9RR8b5o2OSx1h
	 xdHouWl41IknQJ8z+lmhznf5SWE8z6MWBKdvXcVo3A3fz3OOFZqRlkwiZecKOp5ynxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616861;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q5EB7CnfbErUQDeaiM4p+ccMDzblj9hXugE7oaJSHcU=;
	b=qqADvGGWdhKlSuB6poWgvRb4x+p1+biYXb0R+B8PDPWNb3rAsDQRPuPGwSdpUTKqLOlt
	 8cV2JH1TZnis629xzkdsmPSwQ4AkWwy0GWqRAnsCr0fidEzjzy6RajPdABo+q29U/cTPv
	 xXsNRJB8ud7jiKlHkiOBxmJjZ3FgP0pMn3CmWtsdkT7dRK6CIaBjDXE+I29mIIhgiM9/I
	 x9HJM6tlscjt63Fz2vhvDPZ2hHM85Ckk6xnfCbq9Og+0JKXUSbKPC5VXh9++bU+0HRHOk
	 /3oI+llbnNffK43sImTFF4nOG4hHj8dzh2B52gn15IoWqtFHu9Ytm899yGujPLgAdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=RULg5eBj;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255B606A326;
	Mon,  2 Nov 2026 10:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4255B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=RULg5eBj
Received: from stf-laptop (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 7D5C47803A2;
	Mon,  2 Nov 2026 11:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793616858;
	bh=q5EB7CnfbErUQDeaiM4p+ccMDzblj9hXugE7oaJSHcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RULg5eBjUPlVUk2D7XFwT+ncIBoOpIGNBUrvHYQIo+5QBMPFPql8yIy29Yij+E81Y
	 6u3c13Dupx15l2sAMLCzF95kWDXww1Y95oeGpbx4v+c03iMb0cAmAhNMHwUMPd40m/
	 sWS8wfows63RIxD7H7pfxKLhz30DV6w5G9+cA0Or8rpj59SCkIEtubIQTK4inqkAU6
	 5UBrcLqm35mm54eYis2UVWdlC4R7FbbDIKYugTI/pIasyL9bJRDUsF7CL0ZKNQtgAq
	 bv6xmMSgkvK4KhrkD5vL7Te6qzHyzgXdqgOW/itKVAm4dfbtI6JU06YRQ1XO8fNY3x
	 zOdjVuyvJwkkQ==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristmd@gmail.com,
	kuba@kernel.org
Subject: Re: [PATCH v7 12/13] can: peak_usb: dump undecodable URBs once and rate limit decode errors
Date: Mon,  2 Nov 2026 11:53:34 +0100
Message-ID: <20261102105337.29362-3-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179349933002.3127.4498885660427450789@kernel.org>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr> <20261030-canfd_check_channel_idx-v7-12-fc4a3faf3acf@peak-system.fr> <179349933002.3127.4498885660427450789@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 01/11/2026 03:15, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> Can the decoder's error message and the dump of the same URB get split
> up by two separate net_ratelimit() decisions?
[...]
> Would making one rate-limit decision per URB, either
> in the core or passed down to the decoders, keep each message and its
> dump together?

Yes, they can be split during a burst. I'd rather not pass a rate
limit decision down to the decoders for this: each message already
says what is wrong with the URB, and the dump only completes it. In
v8, I'll drop the trailing colon of "got unsupported rec in usb msg",
which announced a dump that may no longer follow it, and say in the
commit message that both are rate limited separately.

Thanks!

Stéphane
