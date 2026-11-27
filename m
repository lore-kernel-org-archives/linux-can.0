Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777290;
	b=ixQ0cOfBbql+0IrnwEOOSxJiBwVBW2eRO1J8O5GUbaGsewm6Ah/PTh/N0/AOSZXKAfgY
	 4permSTmi7KY6MY+oUIKRHgZ6dHmwHifQZiiWbNzTTMZ66iXa+xDQIw5xRRsH6CBpRNjB
	 zr0sWmYQ/Z6nzDN2z4kcGhD3y0BUujSMa77/uEZcoUJIr5WWsYkVVhjj0PKjmJdQ9ydHe
	 OOZD+WbJ6xp1Ys+pmHhIbIpND+jz/I/F7NyoYqGgakQ2an3aJH/DDAHuuabAJD58+qusj
	 rZynkdvvUboTeOjlPCVvyZxSzSvbKJADyZIc3DVzBUc1IIpRlf2yGOBBEVUl3WlebFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777290;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tso0UwYKfSqeJjdd5/LaoDNx104SnGW/lFCbh91N/GQ=;
	b=nsz2SyNfMhnbjD1/s0Am2yy/tRmM/sASbr21Lh853sVjPYg65dXUeS2fQq+yH2/pDI6V
	 vtSagYg1zvnkxLW0YGM2DHF0QAADTHhRb8BFwf0fzEx2JEf5DapDlafPABeSqrR4aU/CQ
	 fWPSc364g9ync6eprEjmoylTKYzzQV521F/U9gU90G8Rmr6wl2QWC0MYw8og8MKMyeB1b
	 wv+90f/MksGOxIb2bP9QwCtHsgyCfr7GXfb7fpsv5yj1kdzRG0yFWVecvCNnv+SETW8TY
	 ZdXO5x70J231q6WmsYXxIoNWSqOp6HhRhIvN9t/jBeeqU+BXDC7gTrLv2zhxwHjRClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=kV9MlvfJ;
	arc=none smtp.remote-ip=31.44.14.20
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net [31.44.14.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA6606A31C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 11:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFA6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=kV9MlvfJ
Received: from mail-nwsmtp-smtp-production-main-59 (mail-nwsmtp-smtp-production-main-59.yp-c.yandex.net)
	by forward504d.mail.yandex.net (postfix) with ESMTPS id 88E691004B0;
	Fri, 27 Nov 2026 14:01:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59 with ESMTPSA id E1h9rcZc1W20-0ekn7XZb;
	Fri, 27 Nov 2026 14:01:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795777278; bh=tso0UwYKfSqeJjdd5/LaoDNx104SnGW/lFCbh91N/GQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=kV9MlvfJ/nHg9KnF6OmBB8rFkaRRUPJtsSiUmKYgFDqX+lXdseL1vZ81aQ7C8U4CQ
	 x5HWji3Ot0QESIemAK8Fvc2UhPeVLe9oCc5AGbEB5VXrSVHqHyKdeo6ZDWrP4uZBZN
	 z87Qqd2g4hJqJHeYGT7AZiitmTPs1p5YLvvdPRVQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-59; dkim=pass header.i=@yandex.ru
Message-ID: <6fc3db25-9bc6-47c1-9776-70a99100e6bb@yandex.ru>
Date: Fri, 27 Nov 2026 14:01:14 +0300
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
Subject: Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device
 stop
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20261126082257.491041-1-dmantipov@yandex.ru>
 <awlQJD0GXoDQQ65m@pengutronix.de>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <awlQJD0GXoDQQ65m@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/26 12:40 PM, Oleksij Rempel wrote:

> So I would not take this patch. Could you please test the whole v15
> series with your syzbot reproducer and reply there, ideally with a
> Tested-by? If v15 does not fix your leak, or I overlooked something,
> please let me know.

Yes, v15 fixes the leak reported at https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0.
So feel free to add:

Tested-by: Dmitry Antipov <dmantipov@yandex.ru>

to patch 1 of v15. Most likely

Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0

should be added as well.

Dmitry
