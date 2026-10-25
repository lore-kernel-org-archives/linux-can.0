Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792895009;
	b=vqFYpARjZ9B9fr3FMD41ZDyhyMAnYbeIAB5rVE2CblYxZCdCuXdd4oeWNqau9OvMm3j+
	 AO+cjsygsJuvqRyFjxxEyCdGsYSQEKVR2X8icJwdncPgrB0A7L/mDrwdsezioIb7O5LaB
	 CPj+X1J8pGVGFxEjp3bEagGGv2UCDCYadtQ3rCme03/i7hpWRfOIu4HyCF+E00MAqyejJ
	 qYdTQqn8JiskP3joHWCNdZ0zdV9aTxFi3c2NpaKxu6ZKw5gw1w3tGpt98CtV7ZQVLrt25
	 GpgWoBBWyHghfbIWB2xJdkq4woKZaD01rUjOCV5TEyDEbFNkDXeYSc6EamAd88P9BTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792895009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8ivcDCD6sbT3HeyNxmBNTblO+eeeUzkaQd94WtAs7n4=;
	b=j5o7ztblhwrQkGwvG7dP65N0blsgcye8A45gPHdqss7hnF6rFy7YZQaXG1KDoTCDdEHF
	 3ngYY8TBEIQwBkUqIIGUWYy8I9k2oWXz+t9jox07ROuK2O8NIqjCYigK6iOUKGSyCx67Q
	 CzN4afmzNOnIx7Vt/i93O4V1PcN8y+owCHHwD8qtaMZ6dTVQTtRGz0IimK0bvZ8wx5Ktm
	 0tqJp2Nz77U2+T72Q9YjdbnOvaoQ1WITqfb4IadzdhvpyxLKSSbFb6GK8aeBrIryt5Su9
	 ApBFq2bM5LPBa3/iAqAr96NTk8CMoHYj/7wro/mw2s5PDb99B9lrdMTlGKZ0yV7qFmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KA6CYmBc;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43F606A31E
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 02:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB43F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KA6CYmBc
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so1058164c88.0
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2026 19:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792895008; x=1793499808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ivcDCD6sbT3HeyNxmBNTblO+eeeUzkaQd94WtAs7n4=;
        b=KA6CYmBcqsQvC/HFX0T1GLe65+gfKI4HeyLvBOp2ra0ohuc30NDAPlPT3ZOK0Y4csF
         m399BDBg9cUw+07eP4ywoxkaPvZiGyR9gr9FRtxPmNmYsvEp2IZPWLpxGmIXNcgx0jC8
         ctdDNw2lZCggf/ITO3oTzzfeLCaz0I6qAtDSaEHXt0Xi795KZmztElZYWhwlZenlLK09
         yi1djcyDu5kgl91J6j6HiGeJdLQAY1Q9zhsbgbLDHTOI3QwtmgqS1TJeuL7TarkS/Bxi
         xvKphuigbmylaaLgL1T6+Px42KezjZ4WzddBA5QZXyVMLP65iC0KJfgngy5Vd32SHiip
         G9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792895008; x=1793499808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ivcDCD6sbT3HeyNxmBNTblO+eeeUzkaQd94WtAs7n4=;
        b=HuAZF4Q1kA9jDPYlCmQvMnYf065q8NzFo2pK93ezD5VWIf3idY6o8qtO9sU44rhaIZ
         2cXkNk/0jIwNp8zYlk1elpBdSetlMdJ/C2W2PF2y0JKrGqrpuJhfB9adidQyIT9kAB65
         zrFszrI7SQm1+FsHnMdAxkd+0g/nk7qcGo1cth8DBDFngSxSsE/OCU+htG49+F0RtIp+
         xrTnqzxoHjFslk4wJYhm+bYhy6dpdyDAJiIxwA1z0DyDmjgoIakU9uOYQAX7r95IXNUO
         F/i8IWjdCjt4ev5t+qe207HrZgKs0nhMEmjn5NlAXSsj1OMZoyVxJ61ijPjc+dEsGeMl
         7waA==
X-Forwarded-Encrypted: i=1; AKwUvByMc/0+6t3Z5RCx/2DrQnSAI7CrfFHO6etWaUd0HdiwgkB0Rsv5FfmdfdvpQOZTMiKqDg8y0morlXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGDoNdX2xhmobLhoJEx2qo5xONThHVVkg7IDusTQ5dr8x2g6Y4
	hI8ANlxcPrMGIlJG/ueRCtYC+fuOY32bYWvVkWqooPzwSnjr9XyRAZyO
X-Gm-Gg: AYBFou3rDpFnflrFdx6WCu4CUsgJLZVjSsITLpSih8eLTML+qqlUBRUx44MVHGgp9oX
	OaUr9eDhmKeeBHZ/dojgyNjUVCpPxuA6odeLIQB2Q1BxzeMXYGK2uW+YQdh/J9uDDZQuIKJrHKh
	SQ0lgWe1X8aCgmETJfJSyWgJKJeVlTEDWhmz8Da1Zh6jno1icKCev3oEtuex/gvHnYqyJGJ/lzD
	l0s62H5zFQnVFOOAaAIjI19pkwpXk4OivVmM5G9wMnau70SG0NBCOlP+h2pcMZhtsozTIFl/ao1
	FvCFmRhWG3uwYkQd9DstZqaLwOEgRvgn1qUsf8XuV5qYrJg/FrPorcp5tfmirkFedRzezpsB1SN
	B8DpA/YQZMIukLgkQPC54NJ0pEIftQso/ckJGplTqTWQzIdsrDs9Up4RhN982A+nmDU8pDGqKIQ
	sOMOkj8Y6UW7hk9D9YzT0cxEkbdXE7s7ggwiPD0sB4c1l2F2klMJjOXppDeM/k0xwBAxdxiVEgj
	BFzkmPirgFzk3OgGP8peHd1eZh7oAN0nK3UfXz+qDh3WWC4oB0ntGJ7z/O+opV7I3DZ
X-Received: by 2002:a05:7022:607:b0:15a:9834:73f2 with SMTP id a92af1059eb24-19937bb20afmr6922856c88.38.1792895007760;
        Sat, 24 Oct 2026 19:23:27 -0700 (PDT)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm11547267c88.15.2026.10.24.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:23:27 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] can: don't discard the platform_get_irq() error in probe
Date: Sun, 25 Oct 2026 10:18:45 +0800
Message-ID: <179289472574.8393.12094085935716992853@gmail.com>
In-Reply-To: <20261021133130.2cf75b3c@kernel.org>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com> <20261021133130.2cf75b3c@kernel.org>
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

Hi Jakub,

You are right, and thanks for pointing it out -- the Cc came from my send script,
not from `get_maintainer.pl`, and I have fixed the script so it can't happen
again.

To be explicit about what I am not doing: I am not resending. The patches
already reached the people who matter, the CAN trees are the right path for
them, and another copy in everyone's inbox would be exactly the noise you are
asking me to stop making. This is just the acknowledgement.

For the record, the same mistake went out in a second small series the same day
(`can: slcan/can327: publish tty->disc_data only after register_candev()`,
2 patches). Both were sent to linux-can@ plus the per-file people from
`get_maintainer.pl`; the extra Cc is gone from the script, so neither can repeat
it.

Sorry for the noise.

Chaosheng

