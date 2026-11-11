Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378551;
	b=X2znRjcRuQfOfRZGuAW6cK5nIvRxlo92x/koHuIoa4Rudp+JijW50Qyfey4sIrDWc1FG
	 jztTlEFUxtwJhK6ILODUxVVXHu+kAOeAo9HJsqCZMMGJ50ymqYLe1TEEqUIPkZ8wF5KIV
	 sbaJ34AVGO+HAsrfRqYblvReQLrnwRYTaaUqy7JUAGh4Nzh73NgkUKfTV3uzxY4MC9ZTK
	 orccuNvLJcKlEgJ1tyjClixr1FZCdjwika44KGQXK9QOiWGHN1t/3e2bc3kyM8Q1wqMqF
	 9BXs7q8UjMKzmzBfTfCV+M0ado6U5vguoun/troefs24Lue02nL58Q+3ywpjZ6P2i8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/WZuXTnG3QlqmY4khWAwpBN7iLQgfE+jMyzDq4k51ro=;
	b=it8l3rqj2wQvaDzdTKtJuko6Su0wWCvTgWeV/eGvwTsS4kwRz8cyfiHgoTfJ6NyzEXnt
	 YaY6SUXfh+8cOVyqe5VLyZNQPWRTraScC0wPGwc/d9wupSPQ0MQj6Ua70ACHndja8W48V
	 LhY+IG8J1P5KMEEH5yj8WieIQ5LpHCPgx+ejT9LoXge0V79IFP4msxZeSM5SubvQ7kH2A
	 l+MkxP8/FCvN+p6YvveVGAdT3Uzl2msiBNUrtDkMmTdBmqeM0esevZz+GdXJRDQJP2/Xa
	 5iV8fdLe2n48ZhYm0z2ylvCMRwbj1pfO5Vv62qADt+xUWJ1/NJIBsLgGo1O3M0+pHhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROY8Ge3E;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0D606A324
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 06:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C0D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROY8Ge3E
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36f6295304dso3681057eec.1
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 22:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378550; x=1794983350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/WZuXTnG3QlqmY4khWAwpBN7iLQgfE+jMyzDq4k51ro=;
        b=ROY8Ge3EJP4qcR5iNI21mlhLWXRkGQMfj6CVisQ3eBfqGQ8/ffyDnODxIS/AXaIHYc
         jUqz0aT+wulIgdLSKmxhc4hRcOA/zW3fq7vkb1z4or6dHIeJE56sRn11CP2coc+mUXHl
         J1bbFUN2oHzJE/8h3vHxsxFjaMjFylbaziU/5tPdZHdncUr7kaOyaq8tU8FXa1LXDKtf
         cXVJqGZr7aodKoOPumjVwtB6Y4dEXBTH87zOgh/ifiUeHwf1fi45fSEsDg8A1RqV9jJ5
         7yj5u4TDTil42RVje38/riSdWWQXSGyq0vjgLn8CVRCI3/nrAm3/aEg3Dt8MOJxy4Fpg
         /SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378550; x=1794983350;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WZuXTnG3QlqmY4khWAwpBN7iLQgfE+jMyzDq4k51ro=;
        b=ilah8VQDrjbl/IuYssCJN4d3g/eEtJqh5GgzwHkiwqDLe9gej/Ic0ZRitN5/EYAMcf
         gInZe01pSOtW3dzNDk5Y6TiNamKONdHCmDLM8VWaLwGWtb76FluDeCk0q+eJ8iHk7ee3
         jntx9pfpu8ExgXEwq1ykXcZF4OL3cMSXomHn/uSNgwflv2Hs6TYjFePAwd+CtMmRKUng
         pbl2ap0jUcEAu86kV9/wFUTgyXkjaPq1WoqLziCQb8e6/Rqt8UCS2Hed9owblfS9+3sS
         rTinBEQJCMjwpe0LBYJJ233vwl0JdjBhnJuMA4SEJOIuAfu+71aEtGuGUOCejz0x2MKk
         YDeA==
X-Gm-Message-State: APuU4Z835NQsvclFgnlupz7qt6PUeZwC10XQs03vF0rpkU2xJ798k0IP
	7C+sbggkwbCDTSbv2PMo2x8VnSlROetElaQpukDaIQ//oBPZl1LKsIQ7vQbJRTvj
X-Gm-Gg: AYBFou2G/Ih84YyH8mp2qs7WVBgzHV2dhYglt4y9ittu+XNrDsPaV3F486fozKTO4K9
	LPJ32rHI/p42CzPKJvNpX3+1ZTjz7CqhOJmKJXatITu/wCi+DSV7cEbivZtCPsR26uJ7x8htnFF
	pJgE/bEXm/ppkIArCD02HhWpIc/xTP6YP6vwt6uET4oPSQSDekAgE9yGzsYBri8wvT6KNdMXNQ4
	TlWW8YD7KK9HtHJitd8kNL13vkGL1GCva3hyh+EdZULocpop8kQPXKSw1aXlNGo4ULBJSSDRvEO
	opFTRcdF4lagdTjKqpBMO7h48VDepnRUjy9N4h/D06H/yH7H9B+UvtZMyFSl/ZwrawfaGSqkCkN
	werFXXYL/5H1PcQYn2i1XwbuHdh/tXvl1PHNfJYqDmm1SXgBzZwSc+p/0+/3edshSdPtFbcF1A6
	2Q0RWTcI7fhjqkwGlL8k2TiCofJHDetCMXWw2dfUbZ1qLrXGhqaXdN9420myk+zT2agj68kCEFY
	bCgBfF2H0drizEhBuFeEMFyPlOh3ISoFSYsNiAuBHrPcv3fx3krs2iJn6MGekiVvlI5r+bZ4z5f
	laO2vA0204TPX017g4IrMbkKxt12ksZ6XWxNqhGtiSqkdYw8MjozAB5X4LcFkzs=
X-Received: by 2002:a05:7301:dcd:b0:370:d7fe:6585 with SMTP id 5a478bee46e88-37685c7a46dmr1921905eec.11.1794378549751;
        Tue, 10 Nov 2026 22:29:09 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm12812621eec.6.2026.11.10.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:29:09 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] can: publish tty->disc_data only after register_candev()
Date: Wed, 11 Nov 2026 14:40:00 +0800
Message-ID: <1794300000.12345.987654321@gmail.com>
In-Reply-To: <c9e14a02-c360-414f-9808-8801ba18544d@enpas.org>
References: <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com>
	<e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
	<179289472575.8393.17187271051946169028@gmail.com>
	<c9e14a02-c360-414f-9808-8801ba18544d@enpas.org>
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

Hi Max,

Thank you for the thorough review, and for taking the time to work out why the
patch felt wrong. You are right, and I am dropping this approach.

The point I missed is the first one you made: "ldisc first, then netdev" is an
implicit contract in these two drivers, and my patch interleaves it. Even if
nothing races today, the next person to touch these functions would have to
reason about SMT safety that was previously not theirs to reason about. That is
swapping one trap for another, which is exactly what I claimed to be removing.

So v3 will use your alternative instead of mine, and nothing else:

	err = register_candev(dev);
	if (err) {
+		tty->disc_data = NULL;
		free_candev(dev);
		pr_err("can't register candev\n");
		return err;
	}

Same in can327. The ordering stays as it is, so the implicit contract is
untouched, and the failure path no longer leaves tty->disc_data pointing at
memory that free_candev() has just released. The commit message will say that
plainly, and will state why no barrier or extra locking is needed: the pointer
is read exactly where it was read before, and the only write on this path
happens before the interface can be brought up.

The sashiko report on 1/2 (a lost tty_wakeup while ldisc_sem is held) also goes
away with your version, since nothing is reordered any more.

On your question: yes. I use an AI assistant when I write patches, and the
disclosure line required by Documentation/process/coding-assistants.rst will be
on v3. Your instinct about why this one looked too neat is right: the assistant
was good at exactly one thing here, finding the smallest diff that removes the
dangling pointer, and moving the assignment is a smaller diff than clearing it.
That is the move that quietly crossed the SMT boundary. Knowing when the
smaller diff is the wrong one is still my job, and I got it wrong.

v3 in a day or two, after I have re-read both drivers end to end rather than
trusting the diff.

Thanks,
Chaosheng

